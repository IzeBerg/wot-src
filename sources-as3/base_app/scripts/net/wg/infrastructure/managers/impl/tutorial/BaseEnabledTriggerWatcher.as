package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import scaleform.clik.events.ComponentEvent;
   
   public class BaseEnabledTriggerWatcher extends AbstractTriggerWatcher
   {
      
      private static const PROPERTY_ENABLED:String = "enabled";
       
      
      protected var _enabled:Boolean = false;
      
      public function BaseEnabledTriggerWatcher(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      override public function start(param1:DisplayObject) : void
      {
         super.start(param1);
         param1.addEventListener(ComponentEvent.STATE_CHANGE,this.onComponentStateChangeHandler);
         this._enabled = this.componentIsEnabled;
      }
      
      override public function stop() : void
      {
         target.removeEventListener(ComponentEvent.STATE_CHANGE,this.onComponentStateChangeHandler);
         super.stop();
      }
      
      protected function checkComponentEnabled() : Boolean
      {
         var _loc1_:Boolean = this.componentIsEnabled;
         if(_loc1_ != this._enabled)
         {
            this._enabled = _loc1_;
            return true;
         }
         return false;
      }
      
      protected function get componentIsEnabled() : Boolean
      {
         if(target != null && target.hasOwnProperty(PROPERTY_ENABLED))
         {
            return target[PROPERTY_ENABLED];
         }
         return false;
      }
      
      private function onComponentStateChangeHandler(param1:Event) : void
      {
         if(this.checkComponentEnabled())
         {
            dispatchTriggerEvent();
         }
      }
   }
}
