package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.vehicleCustomization.data.HistoricIndicatorVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class HistoricIndicator extends UIComponentEx
   {
      
      private static const HISTORICAL_OFFSET:int = 21;
      
      private static const PLAY_STATE:String = "play";
       
      
      public var nonHistoricIcon:Image = null;
      
      public var textField:TextField = null;
      
      public var glow:MovieClip = null;
      
      private var _firstTimeShow:Boolean = true;
      
      private var _currentHistoric:Boolean = true;
      
      private var _dataVo:HistoricIndicatorVO = null;
      
      public function HistoricIndicator()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.textField.mouseEnabled = false;
         this.nonHistoricIcon.mouseEnabled = this.nonHistoricIcon.mouseChildren = false;
         this.nonHistoricIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_NON_HISTORICAL;
         this.nonHistoricIcon.visible = false;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.glow.mouseEnabled = this.glow.mouseChildren = false;
         var _loc1_:Sprite = new Sprite();
         this.glow.hitArea = _loc1_;
         addChild(_loc1_);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._dataVo && isInvalid(InvalidationType.DATA))
         {
            visible = !this._dataVo.isDefaultAppearance || StringUtils.isNotEmpty(this._dataVo.historicText);
            if(visible)
            {
               this.glow.gotoAndStop(1);
               this.applyTextChanges();
               if(!this._firstTimeShow && this._currentHistoric && !this._dataVo.isHistoric)
               {
                  this.glow.gotoAndPlay(PLAY_STATE);
               }
            }
            this._currentHistoric = this._dataVo.isHistoric;
            this._firstTimeShow = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this.glow.stop();
         this._dataVo.dispose();
         this._dataVo = null;
         this.nonHistoricIcon.dispose();
         this.nonHistoricIcon = null;
         this.textField = null;
         this.glow = null;
         super.onDispose();
      }
      
      public function applyTextChanges() : void
      {
         this.nonHistoricIcon.visible = !this._dataVo.isHistoric;
         this.textField.htmlText = this._dataVo.historicText;
         if(this._dataVo.isHistoric)
         {
            App.utils.commons.setShadowFilterWithParams(this.textField);
         }
         else
         {
            App.utils.commons.setShadowFilterWithParams(this.textField,0,0,16711680,1,16,16,2,2);
         }
         this.glow.x = this.textField.width >> 1;
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      public function setData(param1:HistoricIndicatorVO) : void
      {
         this._dataVo = param1;
         invalidateData();
      }
      
      public function get virtualWidth() : int
      {
         var _loc1_:int = this.textField.width;
         return int(_loc1_ + (!!this._currentHistoric ? 0 : HISTORICAL_OFFSET));
      }
   }
}
