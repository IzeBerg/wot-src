package net.wg.gui.battle.views.epicDamagePanel.components
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class GeneralBonus extends BattleUIComponent
   {
       
      
      public var valueTF:TextField = null;
      
      public function GeneralBonus()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.valueTF = null;
         super.onDispose();
      }
      
      public function set bonusValue(param1:Number) : void
      {
         this.valueTF.text = App.utils.locale.makeString(EPIC_BATTLE.TAB_SCREEN_GENERALBONUSVALUE,{"value":String(param1)});
      }
   }
}
