package net.wg.white_tiger.gui.battle.views.wtPlayersPanel
{
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
   
   public interface IHunterPanelListItem extends IPlayersPanelListItem
   {
       
      
      function setSquadNoSound(param1:Boolean) : void;
      
      function setSquadState(param1:int) : void;
      
      function setSquad(param1:Boolean, param2:int) : void;
      
      function setResurrect(param1:Number, param2:Number, param3:Number) : void;
      
      function setPlasma(param1:int) : void;
   }
}
