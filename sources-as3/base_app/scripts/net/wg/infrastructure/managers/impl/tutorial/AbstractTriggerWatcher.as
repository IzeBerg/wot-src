package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import net.wg.infrastructure.interfaces.ITriggerWatcher;
   
   class AbstractTriggerWatcher extends EventDispatcher implements ITriggerWatcher
   {
       
      
      private var _target:DisplayObject;
      
      private var _componentId:String;
      
      private var _type:String;
      
      function AbstractTriggerWatcher(param1:String, param2:String)
      {
         super();
         this._componentId = param1;
         this._type = param2;
      }
      
      public function dispose() : void
      {
         if(this._target)
         {
            this.stop();
         }
      }
      
      public function start(param1:DisplayObject) : void
      {
         this._target = param1;
      }
      
      public function stop() : void
      {
         this._target = null;
      }
      
      protected function dispatchTriggerEvent() : void
      {
         dispatchEvent(new TriggerEvent(TriggerEvent.TRIGGER_ACTIVATED));
      }
      
      public function get componentId() : String
      {
         return this._componentId;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
   }
}
