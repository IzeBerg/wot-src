package net.wg.infrastructure.managers.impl.tutorial
{
   import net.wg.data.constants.generated.TUTORIAL_TRIGGER_TYPES;
   
   class EnabledTriggerWatcher extends BaseEnabledTriggerWatcher
   {
       
      
      private var _trigger:Boolean = true;
      
      function EnabledTriggerWatcher(param1:String, param2:String)
      {
         super(param1,param2);
         this._trigger = param2 == TUTORIAL_TRIGGER_TYPES.ENABLED;
      }
      
      override protected function checkComponentEnabled() : Boolean
      {
         return super.checkComponentEnabled() && _enabled == this._trigger;
      }
   }
}
