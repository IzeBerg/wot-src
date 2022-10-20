package net.wg.gui.battle.halloween.consumablesPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
   
   public class HWEquipmentButtonGlow extends HWGlowBase
   {
      
      private static const SHOWN:String = "shown";
      
      private static const GREEN:String = "green";
      
      private static const HIDDEN:String = "hidden";
      
      private static const NORMAL:String = "normal";
      
      private static const VIVID:String = "vivid";
      
      private static const IDLE:String = "idle";
       
      
      public var background:MovieClip = null;
      
      public var shine:MovieClip = null;
      
      public var tfContainerBlack:HWKeyIndicator = null;
      
      public var tfContainerYellow:HWKeyIndicator = null;
      
      public function HWEquipmentButtonGlow()
      {
         super();
         this.shine.stop();
         this.background.stop();
      }
      
      override public function showGlow(param1:int) : void
      {
         showAnimation(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN ? GREEN : SHOWN);
         if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN_SPECIAL)
         {
            this.shine.gotoAndStop(SHOWN);
            this.background.gotoAndStop(VIVID);
         }
         else
         {
            this.shine.gotoAndStop(HIDDEN);
            this.background.gotoAndStop(NORMAL);
         }
      }
      
      override public function hideGlow() : void
      {
         if(currentLabel != IDLE)
         {
            showAnimation(HIDDEN);
         }
      }
      
      override public function setBindKeyText(param1:String) : void
      {
         this.tfContainerBlack.setText(param1);
         this.tfContainerYellow.setText(param1);
      }
      
      override protected function onDispose() : void
      {
         this.tfContainerBlack.dispose();
         this.tfContainerBlack = null;
         this.tfContainerYellow.dispose();
         this.tfContainerYellow = null;
         this.background = null;
         this.shine = null;
         super.onDispose();
      }
   }
}
