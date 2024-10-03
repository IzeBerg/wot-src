package net.wg.gui.battle.eventBattle.views.timersPanel
{
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   
   public interface ITimerIconContent
   {
       
      
      function setSettings(param1:NotificationTimerSettingVO) : void;
      
      function updateData(param1:StatusNotificationVO) : void;
   }
}
