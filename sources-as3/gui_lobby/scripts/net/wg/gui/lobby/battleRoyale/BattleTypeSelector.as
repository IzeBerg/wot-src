package net.wg.gui.lobby.battleRoyale
{
   import net.wg.gui.lobby.battleRoyale.events.BattleTypeSelectorEvent;
   import net.wg.infrastructure.base.meta.IBattleTypeSelectorMeta;
   import net.wg.infrastructure.base.meta.impl.BattleTypeSelectorMeta;
   
   public class BattleTypeSelector extends BattleTypeSelectorMeta implements IBattleTypeSelectorMeta
   {
       
      
      public function BattleTypeSelector()
      {
         super();
      }
      
      public function setIsVisible(param1:Boolean) : void
      {
         visible = param1;
         dispatchEvent(new BattleTypeSelectorEvent(BattleTypeSelectorEvent.BATTLE_TYPE_SELECTOR_VISIBILITY_CHANGED,true,false,visible));
      }
   }
}
