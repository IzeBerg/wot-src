package net.wg.white_tiger.gui.battle.views.wtConsumablesPanel
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   import net.wg.white_tiger.infrastructure.base.meta.IWTConsumablesPanelMeta;
   import net.wg.white_tiger.infrastructure.base.meta.impl.WTConsumablesPanelMeta;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ConsumablesPanel extends WTConsumablesPanelMeta implements IWTConsumablesPanelMeta
   {
      
      private static const ITEMS_PADDING:int = 53;
      
      private static const DIVIDER_OFFSET:int = 12;
      
      private static const CAT_AMMO:int = 0;
      
      private static const CAT_CONSUMABLE:int = 1;
      
      private static const CAT_SKILL:int = 2;
       
      
      public function ConsumablesPanel()
      {
         super();
      }
      
      override protected function createShellButton() : IBattleShellButton
      {
         return App.utils.classFactory.getComponent(Linkages.EVENT_SHELL_BUTTON_BATTLE,IBattleShellButton);
      }
      
      override protected function createEquipmentButton() : IConsumablesButton
      {
         return App.utils.classFactory.getComponent(Linkages.EVENT_EQUIPMENT_BUTTON,IConsumablesButton);
      }
      
      override protected function drawLayout() : void
      {
         var _loc3_:IConsumablesButton = null;
         var _loc1_:int = renderersLength;
         var _loc2_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = Values.DEFAULT_INT;
         var _loc6_:int = Values.DEFAULT_INT;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc3_ = getRendererBySlotIdx(_loc7_);
            if(_loc3_ != null)
            {
               _loc6_ = this.getSlotCat(_loc3_.consumablesVO.tag);
               if(_loc3_ && _loc3_.visible)
               {
                  if(_loc5_ != _loc6_)
                  {
                     if(!_loc4_)
                     {
                        _loc4_ = true;
                     }
                     else
                     {
                        _loc2_ += DIVIDER_OFFSET;
                     }
                  }
                  _loc3_.x = _loc2_;
                  _loc2_ += this.itemsPadding;
               }
               _loc5_ = _loc6_;
            }
            _loc7_++;
         }
         basePanelWidth = _loc2_;
      }
      
      public function as_setChargeProgress(param1:int, param2:Number, param3:Boolean) : void
      {
         var _loc4_:IWTConsumablesButton = getRendererBySlotIdx(param1) as IWTConsumablesButton;
         if(_loc4_)
         {
            _loc4_.setCharge(param1,param2,param3);
         }
      }
      
      public function as_setDebuffView(param1:int, param2:Boolean) : void
      {
         var _loc3_:IWTConsumablesButton = getRendererBySlotIdx(param1) as IWTConsumablesButton;
         if(_loc3_)
         {
            _loc3_.setDebuffView(param2);
         }
      }
      
      public function as_setSelected(param1:int, param2:Boolean) : void
      {
         var _loc3_:IWTConsumablesButton = getRendererBySlotIdx(param1) as IWTConsumablesButton;
         if(_loc3_)
         {
            _loc3_.setSelected(param2);
         }
      }
      
      private function getSlotCat(param1:String) : int
      {
         if(param1 == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM)
         {
            return CAT_SKILL;
         }
         if(StringUtils.isEmpty(param1))
         {
            return CAT_AMMO;
         }
         return CAT_CONSUMABLE;
      }
      
      override protected function get itemsPadding() : int
      {
         return ITEMS_PADDING;
      }
   }
}
