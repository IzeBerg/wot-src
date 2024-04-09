package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.list
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.PveDAAPIVehicleInfoVO;
   import net.wg.gui.battle.pveBase.views.stats.components.playersPanel.interfaces.IPvePlayersPanelListItemHolder;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelList;
   
   public class PvePlayersPanelListLeft extends PlayersPanelList
   {
      
      private static const LINKAGE:String = "PvePlayersPanelListItemLeftUI";
       
      
      private var _HPBarVisibilityState:uint = 0;
      
      private var _countLivesVisibility:Boolean = true;
      
      public function PvePlayersPanelListLeft()
      {
         super();
      }
      
      override protected function get itemLinkage() : String
      {
         return LINKAGE;
      }
      
      override protected function get isRightAligned() : Boolean
      {
         return false;
      }
      
      override public function toString() : String
      {
         return "[WG PvePlayersPanelListLeft]";
      }
      
      override public function getItemHolderClass() : Class
      {
         return PvePlayersPanelListItemHolder;
      }
      
      override protected function addItem(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc3_:PvePlayersPanelListItemHolder = null;
         var _loc2_:PveDAAPIVehicleInfoVO = param1 as PveDAAPIVehicleInfoVO;
         if(_loc2_ == null || _loc2_.teamPanelMode != PveDAAPIVehicleInfoVO.HIDE)
         {
            super.addItem(param1);
            _loc3_ = _items[_items.length - 1] as PvePlayersPanelListItemHolder;
            _loc3_.setPanelHPBarVisibilityState(this._HPBarVisibilityState);
            _loc3_.setCountLivesVisibility(this._countLivesVisibility);
         }
      }
      
      override public function setPanelHPBarVisibilityState(param1:uint) : void
      {
         var _loc2_:IPlayersPanelListItemHolder = null;
         if(param1 == this._HPBarVisibilityState)
         {
            return;
         }
         this._HPBarVisibilityState = param1;
         for each(_loc2_ in _items)
         {
            (_loc2_ as IPvePlayersPanelListItemHolder).setPanelHPBarVisibilityState(param1);
         }
      }
      
      public function setCountLivesVisibility(param1:Boolean) : void
      {
         var _loc2_:IPlayersPanelListItemHolder = null;
         if(param1 == this._countLivesVisibility)
         {
            return;
         }
         this._countLivesVisibility = param1;
         for each(_loc2_ in _items)
         {
            (_loc2_ as IPvePlayersPanelListItemHolder).setCountLivesVisibility(param1);
         }
      }
   }
}
