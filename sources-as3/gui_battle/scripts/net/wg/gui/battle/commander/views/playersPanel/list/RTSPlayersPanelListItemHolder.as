package net.wg.gui.battle.commander.views.playersPanel.list
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.commander.views.playersPanel.interfaces.IRTSPlayersPanelListItem;
   import net.wg.gui.battle.commander.views.playersPanel.interfaces.IRTSPlayersPanelListItemHolder;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItemHolder;
   
   public class RTSPlayersPanelListItemHolder extends PlayersPanelListItemHolder implements IRTSPlayersPanelListItemHolder
   {
       
      
      private var _rtsListItem:IRTSPlayersPanelListItem = null;
      
      public function RTSPlayersPanelListItemHolder(param1:PlayersPanelListItem)
      {
         this._rtsListItem = IRTSPlayersPanelListItem(param1);
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._rtsListItem = null;
         super.onDispose();
      }
      
      public function setVehicleCommanderData(param1:DAAPIVehicleCommanderDataVO) : void
      {
         this._rtsListItem.setVehicleCommanderData(param1);
      }
      
      public function setIsSpotted(param1:Boolean) : void
      {
         this._rtsListItem.setIsSpotted(param1);
      }
      
      public function setRTSIsMove(param1:Boolean) : void
      {
         this._rtsListItem.setRTSIsMove(param1);
      }
      
      override public function setVehicleData(param1:DAAPIVehicleInfoVO) : void
      {
         super.setVehicleData(param1);
         this._rtsListItem.setVehicleType(vehicleData.vehicleType);
      }
   }
}
