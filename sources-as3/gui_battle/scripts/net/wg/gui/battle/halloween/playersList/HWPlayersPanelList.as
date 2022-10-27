package net.wg.gui.battle.halloween.playersList
{
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelList;
   
   public class HWPlayersPanelList extends PlayersPanelList
   {
       
      
      public function HWPlayersPanelList()
      {
         super();
      }
      
      public function setBuffIcon(param1:int, param2:String) : void
      {
         var _loc3_:HWPlayersPanelListItemHolder = getHolderByVehicleID(param1) as HWPlayersPanelListItemHolder;
         if(_loc3_)
         {
            _loc3_.setBuffIcon(param2);
         }
      }
   }
}
