package net.wg.gui.battle.commander.views.playersPanel.list
{
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.commander.views.playersPanel.interfaces.IRTSPlayersPanelList;
   import net.wg.gui.battle.commander.views.playersPanel.interfaces.IRTSPlayersPanelListItemHolder;
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
   }
}
