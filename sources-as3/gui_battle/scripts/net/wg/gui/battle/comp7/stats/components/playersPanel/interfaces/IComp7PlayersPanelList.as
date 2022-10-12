package net.wg.gui.battle.comp7.stats.components.playersPanel.interfaces
{
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelList;
   
   public interface IComp7PlayersPanelList extends IPlayersPanelList
   {
       
      
      function updatePointOfInterest(param1:Comp7InterestPointVO) : void;
      
      function removePointOfInterest(param1:uint, param2:uint) : void;
   }
}
