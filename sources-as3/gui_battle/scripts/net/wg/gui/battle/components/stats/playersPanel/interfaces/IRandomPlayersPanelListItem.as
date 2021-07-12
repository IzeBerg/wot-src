package net.wg.gui.battle.components.stats.playersPanel.interfaces
{
   public interface IRandomPlayersPanelListItem extends IPlayersPanelListItem
   {
       
      
      function setSquadNoSound(param1:Boolean) : void;
      
      function setSquadState(param1:int) : void;
      
      function setSquad(param1:Boolean, param2:int) : void;
   }
}
