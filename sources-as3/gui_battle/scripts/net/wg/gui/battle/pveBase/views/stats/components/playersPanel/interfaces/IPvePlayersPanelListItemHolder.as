package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.interfaces
{
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   
   public interface IPvePlayersPanelListItemHolder extends IPlayersPanelListItemHolder
   {
       
      
      function setPanelHPBarVisibilityState(param1:uint) : void;
      
      function setCountLivesVisibility(param1:Boolean) : void;
   }
}
