package net.wg.gui.battle.commander.views.playersPanel.list
{
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.commander.views.playersPanel.interfaces.IRTSPlayersPanelList;
   import net.wg.gui.battle.commander.views.playersPanel.interfaces.IRTSPlayersPanelListItemHolder;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelList;
   
   public class RTSPlayersPanelList extends PlayersPanelList implements IRTSPlayersPanelList
   {
      
      private static const ITEM_HEIGHT:int = 25;
       
      
      public function RTSPlayersPanelList()
      {
         super();
      }
      
      override public function get height() : Number
      {
         return !!visible ? Number(panelListItems.length * ITEM_HEIGHT) : Number(0);
      }
      
      public function setCommanderData(param1:Number, param2:DAAPIVehicleCommanderDataVO) : void
      {
         var _loc3_:IRTSPlayersPanelListItemHolder = IRTSPlayersPanelListItemHolder(getHolderByVehicleID(param1));
         if(_loc3_)
         {
            _loc3_.setVehicleCommanderData(param2);
         }
      }
      
      public function setIsSpotted(param1:Number, param2:Boolean) : void
      {
         var _loc3_:IRTSPlayersPanelListItemHolder = IRTSPlayersPanelListItemHolder(getHolderByVehicleID(param1));
         if(_loc3_)
         {
            _loc3_.setIsSpotted(param2);
         }
      }
      
      public function setRTSIsMove(param1:Number, param2:Boolean) : void
      {
         var _loc3_:IRTSPlayersPanelListItemHolder = IRTSPlayersPanelListItemHolder(getHolderByVehicleID(param1));
         if(_loc3_)
         {
            _loc3_.setRTSIsMove(param2);
         }
      }
      
      override public function getItemHolderClass() : Class
      {
         return RTSPlayersPanelListItemHolder;
      }
      
      override public function updateOrder(param1:Vector.<Number>) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:IPlayersPanelListItem = null;
         if(!param1)
         {
            return;
         }
         var _loc2_:Vector.<Number> = new Vector.<Number>(currOrder.length);
         var _loc3_:Number = 0;
         for each(_loc4_ in param1)
         {
            _loc5_ = currOrder.indexOf(_loc4_);
            if(_loc5_ != Values.DEFAULT_INT)
            {
               if(_loc5_ != _loc3_)
               {
                  _loc6_ = getItemByVehicleID(_loc4_);
                  if(_loc6_)
                  {
                     _loc6_.y = ITEM_HEIGHT * _loc3_;
                  }
               }
               _loc2_[_loc3_] = _loc4_;
               _loc3_++;
            }
         }
         currOrder.splice(0,currOrder.length);
         currOrder = currOrder.concat(_loc2_);
      }
   }
}
