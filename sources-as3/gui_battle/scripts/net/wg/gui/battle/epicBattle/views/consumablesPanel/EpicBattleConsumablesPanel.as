package net.wg.gui.battle.epicBattle.views.consumablesPanel
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.epicBattle.views.consumablesPanel.interfaces.IEpicBattleConsumableButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   import net.wg.infrastructure.base.meta.IEpicBattleConsumablesPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattleConsumablesPanelMeta;
   
   public class EpicBattleConsumablesPanel extends EpicBattleConsumablesPanelMeta implements IEpicBattleConsumablesPanelMeta
   {
       
      
      public function EpicBattleConsumablesPanel()
      {
         super();
      }
      
      public function as_addEpicBattleEquipmentSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:String, param8:Boolean, param9:String, param10:int) : void
      {
         super.as_addEquipmentSlot(param1,param2,param3,"",param4,param5,param6,param7,param9,param10,0);
         var _loc11_:IEpicBattleConsumableButton = this.getEBRendererBySlotIdx(param1);
         _loc11_.isTooltipSpecial = param8;
      }
      
      public function as_updateLevelInformation(param1:int, param2:int) : void
      {
         var _loc3_:IEpicBattleConsumableButton = this.getEBRendererBySlotIdx(param1);
         if(_loc3_)
         {
            _loc3_.updateLevelInformation(param2);
         }
      }
      
      public function as_updateLockedInformation(param1:int, param2:int, param3:String, param4:Boolean) : void
      {
         var _loc5_:IEpicBattleConsumableButton = this.getEBRendererBySlotIdx(param1);
         if(_loc5_)
         {
            _loc5_.updateLockedInformation(param2,param3,param4);
         }
      }
      
      public function as_updateStacks(param1:int, param2:int) : void
      {
         var _loc3_:IEpicBattleConsumableButton = this.getEBRendererBySlotIdx(param1);
         if(_loc3_)
         {
            _loc3_.updateStacks(param2);
         }
      }
      
      public function as_showPossibleStacks(param1:int, param2:int) : void
      {
         var _loc3_:IEpicBattleConsumableButton = this.getEBRendererBySlotIdx(param1);
         if(_loc3_)
         {
            _loc3_.showPossibleStacks(param2);
         }
      }
      
      override protected function createEquipmentButton() : IConsumablesButton
      {
         return App.utils.classFactory.getComponent(Linkages.EPIC_BATTLE_CONSUMABLE_BUTTON,EpicBattleConsumableButton);
      }
      
      private function getEBRendererBySlotIdx(param1:int) : IEpicBattleConsumableButton
      {
         return getRendererBySlotIdx(param1) as IEpicBattleConsumableButton;
      }
   }
}
