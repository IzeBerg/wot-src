package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.display.DisplayObject;
   
   public class EnabledChangeTriggerWatcher extends BaseEnabledTriggerWatcher
   {
       
      
      public function EnabledChangeTriggerWatcher(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      override public function start(param1:DisplayObject) : void
      {
         super.start(param1);
         this.dispatchTriggerEvent();
      }
      
      override protected function dispatchTriggerEvent() : void
      {
         dispatchEvent(new TriggerEvent(TriggerEvent.TRIGGER_ACTIVATED,false,false,_enabled));
      }
   }
}
