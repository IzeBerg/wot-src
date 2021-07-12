package net.wg.gui.battle.components.interfaces
{
   import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.ISecondaryTimerFX;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   
   public interface IStatusNotification extends IDisplayObject
   {
       
      
      function fullSize() : Boolean;
      
      function hideTimer() : void;
      
      function setSettings(param1:NotificationTimerSettingVO) : void;
      
      function get typeId() : String;
      
      function setTimerFx(param1:ISecondaryTimerFX) : void;
      
      function resetTimer() : void;
      
      function updateViewID(param1:String, param2:Boolean) : void;
      
      function updateRadialTimer(param1:int, param2:Number) : void;
      
      function showTimer(param1:Boolean) : void;
      
      function tweenToX(param1:int) : void;
      
      function setStaticText(param1:String, param2:String = "") : void;
      
      function cropSize() : Boolean;
      
      function setSpeed(param1:Number) : void;
      
      function get isActive() : Boolean;
      
      function set isActive(param1:Boolean) : void;
      
      function get isShowing() : Boolean;
      
      function get actualWidth() : Number;
      
      function getStatusCallback() : IStatusNotificationCallback;
   }
}
