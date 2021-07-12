package net.wg.gui.battle.views.damagePanel.components.tankIndicator
{
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   
   public class ItemWithModules extends BattleUIComponent
   {
       
      
      private var _modules:Vector.<DamagePanelItemFrameStates>;
      
      public function ItemWithModules()
      {
         super();
         this._modules = this.getModules();
      }
      
      override protected function onDispose() : void
      {
         this._modules.splice(0,this._modules.length);
         this._modules = null;
         super.onDispose();
      }
      
      public function reset() : void
      {
         var _loc1_:int = this._modules.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._modules[_loc2_].state = BATTLE_ITEM_STATES.NORMAL;
            _loc2_++;
         }
      }
      
      public function setModuleState(param1:String, param2:String) : void
      {
         App.utils.asserter.assert(this[param1] != null,"Not valid moduleName = " + param1);
         var _loc3_:DamagePanelItemFrameStates = this[param1];
         _loc3_.state = param2;
      }
      
      public function showDestroyed() : void
      {
         var _loc3_:DamagePanelItemFrameStates = null;
         var _loc1_:int = this._modules.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._modules[_loc2_];
            _loc3_.state = BATTLE_ITEM_STATES.DESTROYED;
            _loc2_++;
         }
      }
      
      protected function getModules() : Vector.<DamagePanelItemFrameStates>
      {
         return new Vector.<DamagePanelItemFrameStates>(0);
      }
      
      protected function get modules() : Vector.<DamagePanelItemFrameStates>
      {
         return this._modules;
      }
   }
}
