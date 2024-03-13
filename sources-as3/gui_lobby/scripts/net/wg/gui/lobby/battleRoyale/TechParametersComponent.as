package net.wg.gui.lobby.battleRoyale
{
   import net.wg.infrastructure.base.meta.IBattleRoyaleTechParametersComponent;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleTechParametersComponent;
   
   public class TechParametersComponent extends BattleRoyaleTechParametersComponent implements IBattleRoyaleTechParametersComponent
   {
      
      private static const TECH_PARAMETERS_WIDTH:int = 349;
      
      private static const TECH_PARAMETERS_HEIGHT:int = 500;
      
      private static const SHAMROCK_PANEL_HEIGHT:int = 0;
       
      
      public function TechParametersComponent()
      {
         super();
         setManageSize(true);
         setSize(TECH_PARAMETERS_WIDTH,TECH_PARAMETERS_HEIGHT);
      }
      
      public function as_updateHeight(param1:Number) : void
      {
         setSize(TECH_PARAMETERS_WIDTH,param1 + SHAMROCK_PANEL_HEIGHT);
      }
   }
}
