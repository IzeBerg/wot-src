package net.wg.gui.battle.commander.views.playersPanel.list
{
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.commander.views.playersPanel.interfaces.IRTSPlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItem;
   
   public class RTSPlayersPanelListItem extends PlayersPanelListItem implements IRTSPlayersPanelListItem
   {
       
      
      public function RTSPlayersPanelListItem()
      {
         super();
      }
      
      public function setVehicleCommanderData(param1:DAAPIVehicleCommanderDataVO) : void
      {
      }
      
      public function setIsSpotted(param1:Boolean) : void
      {
      }
      
      public function setRTSIsMove(param1:Boolean) : void
      {
      }
      
      public function setVehicleType(param1:String) : void
      {
      }
   }
}
