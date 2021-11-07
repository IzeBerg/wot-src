package net.wg.infrastructure.managers.impl.tutorial
{
   import net.wg.data.constants.generated.TUTORIAL_TRIGGER_TYPES;
   import net.wg.infrastructure.interfaces.ITriggerWatcher;
   
   public class TriggerWatcherFactory
   {
       
      
      public function TriggerWatcherFactory()
      {
         super();
      }
      
      public static function createWatcher(param1:String, param2:String) : ITriggerWatcher
      {
         var _loc3_:ITriggerWatcher = null;
         var _loc4_:Class = getClassByType(param2);
         return new _loc4_(param1,param2);
      }
      
      private static function getClassByType(param1:String) : Class
      {
         switch(param1)
         {
            case TUTORIAL_TRIGGER_TYPES.CLICK_OUTSIDE_TYPE:
               return ClickOutsideTriggerWatcher;
            case TUTORIAL_TRIGGER_TYPES.CLICK_TYPE:
               return ClickTriggerWatcher;
            case TUTORIAL_TRIGGER_TYPES.ESCAPE:
               return EscapeTriggerWatcher;
            case TUTORIAL_TRIGGER_TYPES.ENABLED:
               return EnabledTriggerWatcher;
            case TUTORIAL_TRIGGER_TYPES.DISABLED:
               return EnabledTriggerWatcher;
            case TUTORIAL_TRIGGER_TYPES.ENABLED_CHANGE:
               return EnabledChangeTriggerWatcher;
            case TUTORIAL_TRIGGER_TYPES.VISIBLE_CHANGE:
               return VisibleChangeTriggerWatcher;
            default:
               App.utils.asserter.assert(true,"Incorrect Trigger Type: " + param1);
               return null;
         }
      }
   }
}
