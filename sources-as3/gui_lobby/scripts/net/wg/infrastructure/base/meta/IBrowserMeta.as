package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBrowserMeta extends IEventDispatcher
   {
       
      
      function browserActionS(param1:String) : void;
      
      function browserMoveS(param1:int, param2:int, param3:int) : void;
      
      function browserDownS(param1:int, param2:int, param3:int) : void;
      
      function browserUpS(param1:int, param2:int, param3:int) : void;
      
      function browserFocusOutS() : void;
      
      function onBrowserShowS(param1:Boolean) : void;
      
      function onBrowserHideS() : void;
      
      function invalidateViewS() : void;
      
      function setBrowserSizeS(param1:int, param2:int, param3:Number) : void;
      
      function as_loadBitmap(param1:String) : void;
      
      function as_loadingStart(param1:Boolean) : void;
      
      function as_loadingStop() : void;
      
      function as_showServiceView(param1:String, param2:String) : void;
      
      function as_hideServiceView() : void;
      
      function as_changeTitle(param1:String) : void;
      
      function as_showContextMenu(param1:String, param2:Object) : void;
   }
}
