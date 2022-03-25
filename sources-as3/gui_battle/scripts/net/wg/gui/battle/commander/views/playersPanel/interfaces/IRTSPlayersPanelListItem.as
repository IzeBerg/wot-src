package net.wg.gui.battle.commander.views.playersPanel.interfaces
{
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
   
   public interface IRTSPlayersPanelListItem extends IPlayersPanelListItem
   {
       
      
      function setVehicleCommanderData(param1:DAAPIVehicleCommanderDataVO) : void;
      
      function setIsSpotted(param1:Boolean) : void;
      
      function setRTSIsMove(param1:Boolean) : void;
      
      function setVehicleType(param1:String) : void;
   }
}
