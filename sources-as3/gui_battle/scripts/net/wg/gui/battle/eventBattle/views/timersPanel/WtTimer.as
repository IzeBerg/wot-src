package net.wg.gui.battle.eventBattle.views.timersPanel
{
   import flash.display.DisplayObject;
   import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   
   public class WtTimer extends DestroyTimer
   {
       
      
      private var _iconContent:DisplayObject = null;
      
      public function WtTimer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._iconContent = null;
         super.onDispose();
      }
      
      override public function updateData(param1:StatusNotificationVO) : void
      {
         super.updateData(param1);
         if(this._iconContent is ITimerIconContent)
         {
            ITimerIconContent(this._iconContent).updateData(param1);
         }
      }
      
      override public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         super.setSettings(param1);
         if(this._iconContent is ITimerIconContent)
         {
            ITimerIconContent(this._iconContent).setSettings(param1);
         }
      }
      
      override public function setStaticText(param1:String, param2:String = "") : void
      {
      }
   }
}
