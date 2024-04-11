package net.wg.gui.battle.historicalBattles.consumablesPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
   
   public class HBEquipmentButtonGlow extends HBGlowBase
   {
      
      private static const SHOWN:String = "shown";
      
      private static const HIDDEN:String = "hidden";
      
      private static const NORMAL:String = "normal";
      
      private static const VIVID:String = "vivid";
       
      
      public var background:MovieClip = null;
      
      public var shine:MovieClip = null;
      
      public var tfContainerBlack:HBKeyIndicator = null;
      
      public var tfContainerGreen:HBKeyIndicator = null;
      
      public function HBEquipmentButtonGlow()
      {
         super();
         this.shine.stop();
         this.background.stop();
      }
      
      override public function showGlow(param1:int) : void
      {
         showAnimation(SHOWN);
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
         showAnimation(HIDDEN);
      }
      
      override public function setBindKeyText(param1:String) : void
      {
         this.tfContainerBlack.setText(param1);
         this.tfContainerGreen.setText(param1);
      }
      
      override protected function onDispose() : void
      {
         this.tfContainerBlack.dispose();
         this.tfContainerBlack = null;
         this.tfContainerGreen.dispose();
         this.tfContainerGreen = null;
         this.background = null;
         this.shine = null;
         super.onDispose();
      }
   }
}
