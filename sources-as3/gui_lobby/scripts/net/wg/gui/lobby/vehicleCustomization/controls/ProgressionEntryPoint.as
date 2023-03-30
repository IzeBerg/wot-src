package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.lobby.vehicleCustomization.CustomizationMainView;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.MouseEventEx;
   
   public class ProgressionEntryPoint extends UIComponentEx implements IDisposable
   {
      
      private static const OVER_STATE:String = "over";
      
      private static const OUT_STATE:String = "out";
      
      private static const BORDERS_HIT_AREA_NAME:String = "borderHit";
      
      private static const BASE_SCALE:uint = 1;
      
      private static const FREE_SPACE_WIDTH:uint = 184;
      
      private static const ONE_LINE_TEXT_SIZE:uint = 20;
      
      private static const TEXT_POSITION_SMALL:uint = 122;
      
      private static const TEXT_POSITION_BIG:uint = 130;
      
      private static const TEXT_POSITION_SINGLE:uint = 135;
      
      private static const FONT_SIZE:uint = 13;
      
      private static const FONT_SIZE_BIG:uint = 15;
      
      private static const TEXT_SIZE:uint = 130;
      
      private static const TEXT_SIZE_BIG:uint = 160;
       
      
      public var hitMc:Sprite = null;
      
      public var border:Sprite = null;
      
      public var borderHover:Sprite = null;
      
      public var textField:TextField = null;
      
      private var _textFormat:TextFormat;
      
      public function ProgressionEntryPoint()
      {
         var _loc1_:Sprite = null;
         super();
         hitArea = this.hitMc;
         buttonMode = true;
         hitArea.buttonMode = true;
         _loc1_ = new Sprite();
         _loc1_.name = BORDERS_HIT_AREA_NAME;
         addChild(_loc1_);
         this.border.mouseEnabled = this.border.mouseChildren = false;
         this.borderHover.mouseEnabled = this.borderHover.mouseChildren = false;
         this.border.hitArea = _loc1_;
         this.borderHover.hitArea = _loc1_;
         this._textFormat = new TextFormat();
         this._textFormat.size = FONT_SIZE_BIG;
         this.textField.setTextFormat(this._textFormat);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         stop();
         this.textField = null;
         this.border = null;
         this.borderHover = null;
         this.hitMc = null;
         super.onDispose();
      }
      
      public function setScale(param1:Number) : void
      {
         var _loc2_:Boolean = param1 < CustomizationMainView.ENTRY_POINT_SCALE;
         var _loc3_:Boolean = this.textField.textHeight > ONE_LINE_TEXT_SIZE;
         scaleX = scaleY = param1;
         this.textField.scaleX = this.textField.scaleY = BASE_SCALE / param1;
         if(_loc3_)
         {
            if(_loc2_)
            {
               this.textField.y = TEXT_POSITION_SMALL;
            }
            else
            {
               this.textField.y = TEXT_POSITION_BIG;
            }
         }
         else
         {
            this.textField.y = TEXT_POSITION_SINGLE;
         }
         this.textField.width = !!_loc2_ ? Number(TEXT_SIZE) : Number(TEXT_SIZE_BIG);
         this._textFormat.size = !!_loc2_ ? FONT_SIZE : FONT_SIZE_BIG;
         this.textField.x = FREE_SPACE_WIDTH - this.textField.width >> 1;
         this.textField.setTextFormat(this._textFormat);
      }
      
      public function set label(param1:String) : void
      {
         this.textField.htmlText = param1;
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         gotoAndPlay(OVER_STATE);
         dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_CUST_HIGHLIGHT));
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         gotoAndPlay(OUT_STATE);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx)
         {
            if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
               dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,SoundTypes.CUSTOMIZATION_SELECT));
               dispatchEvent(new CustomizationEvent(CustomizationEvent.SHOW_PROGRESSION_DECALS_WINDOW));
            }
         }
      }
   }
}
