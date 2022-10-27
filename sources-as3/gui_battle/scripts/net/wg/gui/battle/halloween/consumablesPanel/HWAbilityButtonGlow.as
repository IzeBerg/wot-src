package net.wg.gui.battle.halloween.consumablesPanel
{
   import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
   
   public class HWAbilityButtonGlow extends HWGlowBase
   {
      
      public static const RELOADED:String = "reloaded";
      
      public static const LOADED:String = "loaded";
      
      public static const ACTIVATED:String = "activated";
      
      public static const DEACTIVATED:String = "deactivated";
      
      public static const HIDDEN:String = "hidden";
      
      public static const HIDDEN_ACTIVATED:String = "hiddenActivated";
       
      
      public var tfContainerBlack:HWKeyIndicator = null;
      
      public var tfContainerYellow:HWKeyIndicator = null;
      
      public var tfContainerGreen:HWKeyIndicator = null;
      
      private var _isGlowShown:Boolean = false;
      
      public function HWAbilityButtonGlow()
      {
         super();
      }
      
      override public function showGlow(param1:int) : void
      {
         this._isGlowShown = true;
         if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN_SPECIAL)
         {
            showAnimation(RELOADED);
         }
         if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN)
         {
            gotoAndStop(LOADED);
         }
      }
      
      override public function hideGlow() : void
      {
         this._isGlowShown = false;
         if(currentLabel == RELOADED || currentLabel == LOADED || currentLabel == DEACTIVATED)
         {
            showAnimation(HIDDEN);
         }
         else if(currentLabel == ACTIVATED)
         {
            showAnimation(HIDDEN_ACTIVATED);
         }
      }
      
      override protected function onActiveChanged() : void
      {
         if(!this._isGlowShown)
         {
            return;
         }
         var _loc1_:String = !!_isActive ? ACTIVATED : DEACTIVATED;
         showAnimation(_loc1_);
      }
      
      override public function setBindKeyText(param1:String) : void
      {
         this.tfContainerBlack.setText(param1);
         this.tfContainerYellow.setText(param1);
         this.tfContainerGreen.setText(param1);
      }
      
      override protected function onDispose() : void
      {
         this.tfContainerYellow.dispose();
         this.tfContainerYellow = null;
         this.tfContainerBlack.dispose();
         this.tfContainerBlack = null;
         this.tfContainerGreen.dispose();
         this.tfContainerGreen = null;
         super.onDispose();
      }
   }
}
