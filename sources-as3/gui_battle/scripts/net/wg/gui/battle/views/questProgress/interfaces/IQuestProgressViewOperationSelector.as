package net.wg.gui.battle.views.questProgress.interfaces
{
   import net.wg.gui.battle.views.questProgress.data.QPProgressTrackingVO;
   
   public interface IQuestProgressViewOperationSelector extends IQuestProgressView
   {
       
      
      function updateProgressTracking(param1:QPProgressTrackingVO) : void;
   }
}
