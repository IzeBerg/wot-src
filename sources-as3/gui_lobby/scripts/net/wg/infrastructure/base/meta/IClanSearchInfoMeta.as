package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanSearchInfoMeta extends IEventDispatcher
   {
       
      
      function sendRequestS() : void;
      
      function openClanProfileS() : void;
      
      function requestDataS(param1:Number) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setStateData(param1:Object) : void;
      
      function as_setEmblem(param1:String) : void;
      
      function as_setWaitingVisible(param1:Boolean) : void;
      
      function as_setDummy(param1:Object) : void;
      
      function as_setDummyVisible(param1:Boolean) : void;
   }
}
