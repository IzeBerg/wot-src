package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanSearchWindowMeta extends IEventDispatcher
   {
       
      
      function searchS(param1:String) : void;
      
      function previousPageS() : void;
      
      function nextPageS() : void;
      
      function dummyButtonPressS() : void;
      
      function as_getDP() : Object;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setStateData(param1:Object) : void;
      
      function as_setDummy(param1:Object) : void;
      
      function as_setDummyVisible(param1:Boolean) : void;
   }
}
