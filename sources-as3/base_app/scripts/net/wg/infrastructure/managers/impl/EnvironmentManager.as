package net.wg.infrastructure.managers.impl
{
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.system.fscommand;
   import net.wg.infrastructure.events.EnvironmentEvent;
   import net.wg.infrastructure.exceptions.EnvironmentException;
   import net.wg.infrastructure.managers.IEnvironmentManager;
   
   [Event(name="",type="net.wg.infrastructure.events.EnvironmentEvent")]
   public final class EnvironmentManager extends EventDispatcher implements IEnvironmentManager
   {
      
      private static var ms_instance:EnvironmentManager = null;
       
      
      private var _useEventSystem:Boolean = false;
      
      private var _result:Object = null;
      
      private var _checkSuccessHandler:Function;
      
      private var _checkFaultHandler:Function;
      
      public function EnvironmentManager()
      {
         super();
         ms_instance = this;
      }
      
      public static function getInstance() : IEnvironmentManager
      {
         if(ms_instance == null)
         {
            ms_instance = new EnvironmentManager();
         }
         return ms_instance;
      }
      
      [Event(name="WoTQuit",type="net.wg.infrastructure.events.EnvironmentEvent")]
      public function quit() : void
      {
         this.dofsCommand(EnvironmentEvent.QIUT);
      }
      
      [Event(name="WoTLogoff",type="net.wg.infrastructure.events.EnvironmentEvent")]
      public function logoff() : void
      {
         this.dofsCommand(EnvironmentEvent.LOGOFF);
      }
      
      public final function useEventSystem() : void
      {
         this._useEventSystem = true;
      }
      
      public final function useExternallInterface() : void
      {
         this._useEventSystem = false;
      }
      
      public final function addCallback(param1:String, param2:Function) : void
      {
         if(this._useEventSystem)
         {
            addEventListener(param1,param2);
         }
         else
         {
            ExternalInterface.addCallback(param1,param2);
         }
      }
      
      [Event(name="",type="net.wg.infrastructure.events.EnvironmentEvent")]
      public final function call(... rest) : *
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         this._result = null;
         if(this._useEventSystem)
         {
            if(rest.length == 0 || rest == null)
            {
               _loc3_ = "cmd can`t be null, when arguments count is zero";
               throw new EnvironmentException(_loc3_);
            }
            _loc2_ = rest.shift() as String;
            if(_loc2_ == null || _loc2_ == "")
            {
               _loc4_ = "First argument must be a string and non-zero value";
               throw new EnvironmentException(_loc4_);
            }
            dispatchEvent(new EnvironmentEvent(_loc2_,rest));
            return this._result;
         }
         return ExternalInterface.call.apply(this,rest);
      }
      
      [Event(name="",type="net.wg.infrastructure.events.EnvironmentEvent")]
      public final function envoke(param1:String) : *
      {
         this._result = null;
         if(this._useEventSystem)
         {
            dispatchEvent(new EnvironmentEvent(param1,[]));
            return;
         }
         return ExternalInterface.call(param1);
      }
      
      public function setLastResult(param1:Object) : void
      {
         this._result = param1;
      }
      
      [Event(name="",type="net.wg.infrastructure.events.EnvironmentEvent")]
      private function dofsCommand(param1:String) : void
      {
         if(this._useEventSystem)
         {
            dispatchEvent(new EnvironmentEvent(param1));
         }
         else
         {
            fscommand(param1);
         }
      }
      
      public function checkEnvokeReady(param1:Function, param2:Function = null) : void
      {
         if(this._useEventSystem)
         {
            if(param1 != null)
            {
               param1();
            }
         }
         else
         {
            this._checkSuccessHandler = param1;
            this._checkFaultHandler = param2;
            this.callCheckNextFrame();
         }
      }
      
      private function callCheckNextFrame() : void
      {
         if(ExternalInterface.available)
         {
            if(this._checkSuccessHandler != null)
            {
               this._checkSuccessHandler();
            }
            this._checkSuccessHandler = null;
            this._checkFaultHandler = null;
         }
         else
         {
            if(this._checkFaultHandler != null)
            {
               this._checkFaultHandler();
            }
            App.utils.scheduler.scheduleOnNextFrame(this.callCheckNextFrame);
         }
      }
   }
}
