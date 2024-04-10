package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.interfaces
{
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IRandomPlayersPanelListItem;
   
   public interface IPvePlayersPanelListItem extends IRandomPlayersPanelListItem
   {
       
      
      function setVehicleType(param1:String) : void;
      
      function setTeamColor(param1:String) : void;
      
      function setHighlighted(param1:Boolean) : void;
      
      function setShowFrags(param1:Boolean) : void;
      
      function setShowVehicleTypeIcon(param1:Boolean) : void;
      
      function setCountLivesVisibility(param1:Boolean) : void;
      
      function setCountLives(param1:int) : void;
   }
}
