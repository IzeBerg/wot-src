package net.wg.gui.lobby.personalMissions.components.interfaces
{
   import net.wg.gui.interfaces.IUpdatableComponent;
   
   public interface IChainsPanel extends IUpdatableComponent
   {
       
      
      function getSelectedChainID() : int;
      
      function selectChain(param1:int) : void;
      
      function init(param1:int) : void;
      
      function getPanelHeight() : int;
   }
}
