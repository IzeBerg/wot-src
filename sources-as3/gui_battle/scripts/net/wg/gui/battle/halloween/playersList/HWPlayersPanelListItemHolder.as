package net.wg.gui.battle.halloween.playersList
{
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItemHolder;
   
   public class HWPlayersPanelListItemHolder extends PlayersPanelListItemHolder
   {
       
      
      public function HWPlayersPanelListItemHolder(param1:PlayersPanelListItem)
      {
         super(param1);
      }
      
      public function setBuffIcon(param1:String) : void
      {
         HWPlayersPanelListItem(getListItem()).setBuffIcon(param1);
      }
   }
}
