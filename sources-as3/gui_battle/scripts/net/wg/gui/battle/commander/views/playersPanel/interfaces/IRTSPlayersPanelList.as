package net.wg.gui.battle.commander.views.playersPanel.interfaces
{
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelList;
   
   public interface IRTSPlayersPanelList extends IPlayersPanelList
   {
       
      
      function setCommanderData(param1:Number, param2:DAAPIVehicleCommanderDataVO) : void;
      
      function setIsSpotted(param1:Number, param2:Boolean) : void;
      
      function setRTSIsMove(param1:Number, param2:Boolean) : void;
      
      function set visible(param1:Boolean) : void;
   }
}
