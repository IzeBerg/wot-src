package net.wg.gui.battle.comp7.views.consumablesPanel
{
   import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
   import net.wg.gui.battle.views.consumablesPanel.BattleAbilityEquipmentButtonGlow;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleEquipmentButtonGlow;
   
   public class Comp7ConsumableButtonGlow extends BattleAbilityEquipmentButtonGlow implements IBattleEquipmentButtonGlow
   {
      
      private static const SHOW_GLOW_ORANGE_SPECIAL_STATE:String = "orangeSpecial";
      
      private static const SHOW_GLOW_ORANGE_UPGRADE_STATE:String = "orangeUpgrade";
       
      
      public function Comp7ConsumableButtonGlow()
      {
         super();
      }
      
      override public function hideGlow(param1:Boolean = true) : void
      {
      }
      
      override public function showGlow(param1:int, param2:Boolean = true) : void
      {
         if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE)
         {
            gotoAndPlay(SHOW_GLOW_ORANGE_STATE);
         }
         else if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE_UPGRADE)
         {
            gotoAndPlay(SHOW_GLOW_ORANGE_UPGRADE_STATE);
         }
         else if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE_SPECIAL)
         {
            gotoAndPlay(SHOW_GLOW_ORANGE_SPECIAL_STATE);
         }
         else if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN || param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN_SPECIAL)
         {
            gotoAndPlay(SHOW_GLOW_GREEN_STATE);
         }
      }
   }
}
