package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IProfileTabNavigatorMeta extends IEventDispatcher
   {
       
      
      function onTabChangeS(param1:String) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setBtnTabCounters(param1:Array) : void;
   }
}
