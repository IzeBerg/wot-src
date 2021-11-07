package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
   import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
   import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EventConsumablesPanel extends ConsumablesPanel
   {
      
      private static const DIVIDER_OFFSET:int = 10;
      
      private static const CAT_AMMO:int = 0;
      
      private static const CAT_CONSUMABLE:int = 1;
      
      private static const CAT_SKILL:int = 2;
       
      
      public function EventConsumablesPanel()
      {
         super();
      }
      
      override protected function createEquipmentButton() : IConsumablesButton
      {
         return App.utils.classFactory.getComponent(Linkages.EVENT_EQUIPMENT_BUTTON,EventBattleEquipmentButton);
      }
      
      override protected function createShellButton() : IBattleShellButton
      {
         return App.utils.classFactory.getComponent(Linkages.EVENT_SHELL_BUTTON_BATTLE,BattleShellButton);
      }
      
      override protected function drawLayout() : void
      {
         var _loc3_:IConsumablesButton = null;
         var _loc1_:int = renderers.length;
         var _loc2_:int = 0;
         var _loc4_:int = Values.DEFAULT_INT;
         var _loc5_:Boolean = false;
         var _loc6_:int = Values.DEFAULT_INT;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            if(customIndexGap.indexOf(_loc7_) != -1)
            {
               _loc2_ += groupsGap;
            }
            if(renderers[_loc7_] != null)
            {
               _loc3_ = getRendererBySlotIdx(_loc7_);
               if(_loc3_ && _loc3_.visible)
               {
                  _loc4_ = this.getSlotCat(_loc3_.consumablesVO.tag);
                  if(_loc6_ != _loc4_)
                  {
                     if(!_loc5_)
                     {
                        _loc5_ = true;
                     }
                     else
                     {
                        _loc2_ += DIVIDER_OFFSET;
                     }
                  }
                  _loc3_.x = _loc2_;
                  _loc2_ += itemsPadding;
               }
               _loc6_ = _loc4_;
            }
            _loc7_++;
         }
         basePanelWidth = _loc2_;
      }
      
      private function getSlotCat(param1:String) : int
      {
         if(param1 == BATTLE_CONSUMABLES_PANEL_TAGS.TRIGGER || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_NITRO || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_PASSIVE_ABILITY || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.SUPER_SHELL || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_BUFF || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.REPAIR_AND_CREW_HEAL || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.INSTANT_RELOAD)
         {
            return CAT_SKILL;
         }
         if(StringUtils.isEmpty(param1))
         {
            return CAT_AMMO;
         }
         return CAT_CONSUMABLE;
      }
   }
}
