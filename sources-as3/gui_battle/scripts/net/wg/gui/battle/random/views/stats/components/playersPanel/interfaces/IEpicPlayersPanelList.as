package net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces
{
   public interface IEpicPlayersPanelList extends IPlayersPanelList
   {
       
      
      function setAndSortByGroup(param1:int, param2:Number) : void;
      
      function get selectedPlayerGroup() : int;
      
      function set selectedPlayerGroup(param1:int) : void;
   }
}
