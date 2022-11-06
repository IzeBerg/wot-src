package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMissionsViewBaseMeta extends IEventDispatcher
   {
       
      
      function dummyClickedS(param1:String) : void;
      
      function as_showDummy(param1:Object) : void;
      
      function as_hideDummy() : void;
      
      function as_setWaitingVisible(param1:Boolean) : void;
      
      function as_setBackground(param1:String) : void;
   }
}
