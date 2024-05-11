package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.MouseEventEx;
   
   public class ShopEntryPoint extends UIComponentEx implements IDisposable
   {
      
      private static const OVER_STATE:String = "over";
      
      private static const OUT_STATE:String = "out";
       
      
      public var icon:Sprite = null;
      
      public var hitMc:Sprite = null;
      
      public var textField:MovieClip = null;
      
      public var innerTextField:TextField = null;
      
      public function ShopEntryPoint()
      {
         super();
         this.innerTextField = this.textField.textField;
         hitArea = this.hitMc;
         buttonMode = true;
         hitArea.buttonMode = true;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         stop();
         this.textField = null;
         this.innerTextField = null;
         this.hitMc = null;
         this.icon = null;
         super.onDispose();
      }
      
      public function set label(param1:String) : void
      {
         this.innerTextField.text = param1;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         gotoAndPlay(OVER_STATE);
         dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_CUST_HIGHLIGHT));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         gotoAndPlay(OUT_STATE);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         if(_loc2_ != null && _loc2_.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,SoundTypes.CUSTOMIZATION_SELECT));
            dispatchEvent(new CustomizationEvent(CustomizationEvent.SHOW_SHOP));
         }
      }
   }
}
