package net.wg.gui.components.crosshairPanel.components.artyShot
{
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CROSSHAIR_CONSTANTS;
   import net.wg.gui.components.crosshairPanel.VO.GunMarkerIndicatorVO;
   import net.wg.gui.components.crosshairPanel.VO.ShotFlyTimeVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ArtyShotIndicator extends MovieClip implements IDisposable
   {
      
      private static const NAME_TEXT_PADDING:uint = 15;
      
      private static const GREEN_FRAME_LBL:String = "green";
      
      private static const GREEN_EMPTY_FRAME_LBL:String = "greenEmpty";
      
      private static const RED_FRAME_LBL:String = "red";
      
      private static const RED_EMPTY_FRAME_LBL:String = "redEmpty";
      
      private static const PURPLE_FRAME_LBL:String = "purple";
      
      private static const PURPLE_EMPTY_FRAME_LBL:String = "purpleEmpty";
       
      
      public var nameTF:ArtyShotIndicatorText = null;
      
      public var timeTF:ArtyShotIndicatorText = null;
      
      public var indicatorIcon:MovieClip = null;
      
      private var _data:GunMarkerIndicatorVO = null;
      
      private var _baseDisposed:Boolean = false;
      
      public function ArtyShotIndicator()
      {
         super();
         this.gotoAndStop(GREEN_FRAME_LBL);
         this.timeTF.blendMode = BlendMode.SCREEN;
         this.indicatorIcon.blendMode = BlendMode.SCREEN;
         this.nameTF.blendMode = BlendMode.SCREEN;
      }
      
      protected function onDispose() : void
      {
         this._data = null;
         this.nameTF.dispose();
         this.nameTF = null;
         this.timeTF.dispose();
         this.timeTF = null;
         this.indicatorIcon = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function setData(param1:GunMarkerIndicatorVO, param2:Boolean) : void
      {
         this._data = param1;
         if(this._data.state == CROSSHAIR_CONSTANTS.ART_SHOT_INDICATOR_ACTIVE)
         {
            if(this._data.shotResult)
            {
               this.gotoAndStop(GREEN_FRAME_LBL);
            }
            else
            {
               this.gotoAndStop(!!param2 ? PURPLE_FRAME_LBL : RED_FRAME_LBL);
            }
            this.nameTF.blendMode = BlendMode.NORMAL;
            this.nameTF.defaultTextFormat.bold = true;
         }
         else
         {
            if(this._data.shotResult)
            {
               this.gotoAndStop(GREEN_EMPTY_FRAME_LBL);
            }
            else
            {
               this.gotoAndStop(!!param2 ? PURPLE_EMPTY_FRAME_LBL : RED_EMPTY_FRAME_LBL);
            }
            this.nameTF.blendMode = BlendMode.SCREEN;
            this.nameTF.defaultTextFormat.bold = false;
         }
         this.nameTF.text = this._data.shellTypeName;
         this.nameTF.setTextFormat(this.nameTF.defaultTextFormat);
         this.nameTF.width = this.nameTF.textWidth;
      }
      
      public function setShotFlyTime(param1:ShotFlyTimeVO) : void
      {
         if(param1.flyTime > 0)
         {
            this.timeTF.text = param1.flyTime.toString();
         }
         else
         {
            this.timeTF.text = Values.EMPTY_STR;
         }
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         this.nameTF.gotoAndStop(param1,param2);
         this.indicatorIcon.gotoAndStop(param1,param2);
      }
      
      override public function get width() : Number
      {
         return this.indicatorIcon.width;
      }
      
      override public function set width(param1:Number) : void
      {
         this.indicatorIcon.width = param1;
         this.nameTF.x = (param1 - this.nameTF.width) / 2;
         this.timeTF.x = (param1 - this.timeTF.width) / 2;
      }
      
      public function get minWidth() : uint
      {
         return this.nameTF.textWidth + NAME_TEXT_PADDING;
      }
      
      public function get data() : GunMarkerIndicatorVO
      {
         return this._data;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
