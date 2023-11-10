package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanProfileBaseViewMeta extends IEventDispatcher
   {
       
      
      function onHeaderButtonClickS(param1:String) : void;
      
      function viewSizeS(param1:Number, param2:Number) : void;
      
      function as_setClanInfo(param1:Object) : void;
      
      function as_setHeaderState(param1:Object) : void;
      
      function as_setClanEmblem(param1:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_showWaiting(param1:Boolean) : void;
      
      function as_showDummy(param1:Object) : void;
      
      function as_hideDummy() : void;
      
      function as_loadBrowser() : void;
   }
}
