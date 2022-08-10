package net.wg.gui.lobby.battleResults.components
{
   import net.wg.gui.components.controls.InfoIcon;
   
   public class TotalIncomeDetails extends IncomeDetails
   {
      
      private static const MULTIPLIER_INFO_DEFAULT_Y:int = 12;
      
      private static const MULTIPLIER_INFO_LINE_HEIGHT:int = 20;
       
      
      public var multiplierInfo:InfoIcon = null;
      
      public var multiplierPremiumInfo:InfoIcon = null;
      
      public function TotalIncomeDetails()
      {
         super();
         this.multiplierInfo.visible = false;
         this.multiplierPremiumInfo.visible = false;
      }
      
      override public function setColumnsAlpha(param1:Number, param2:Number) : void
      {
         super.setColumnsAlpha(param1,param2);
         this.multiplierInfo.alpha = param1;
         this.multiplierPremiumInfo.alpha = param2;
      }
      
      override protected function onDispose() : void
      {
         this.multiplierInfo.dispose();
         this.multiplierInfo = null;
         this.multiplierPremiumInfo.dispose();
         this.multiplierPremiumInfo = null;
         super.onDispose();
      }
      
      public function setMultiplierInfoTooltips(param1:String, param2:String, param3:int) : void
      {
         this.multiplierInfo.tooltip = param1;
         this.multiplierPremiumInfo.tooltip = param2;
         this.multiplierInfo.y = this.multiplierPremiumInfo.y = MULTIPLIER_INFO_DEFAULT_Y + param3 * MULTIPLIER_INFO_LINE_HEIGHT;
      }
      
      public function setVisibilityInfoIcon(param1:Boolean) : void
      {
         this.multiplierInfo.visible = param1;
         this.multiplierPremiumInfo.visible = param1;
      }
   }
}
