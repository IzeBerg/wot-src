package net.wg.gui.battle.commander.views.playersPanel.interfaces
{
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   
   public interface IRTSPlayersPanelListItemHolder extends IPlayersPanelListItemHolder
   {
       
      
      function setVehicleCommanderData(param1:DAAPIVehicleCommanderDataVO) : void;
      
      function setIsSpotted(param1:Boolean) : void;
      
      function setRTSIsMove(param1:Boolean) : void;
   }
}
