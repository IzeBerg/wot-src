package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IContainerManagerMeta extends IEventDispatcher
   {
       
      
      function isModalViewsIsExistsS() : Boolean;
      
      function as_getView(param1:String) : Boolean;
      
      function as_show(param1:String, param2:int, param3:int) : Boolean;
      
      function as_registerContainer(param1:int, param2:String) : void;
      
      function as_unregisterContainer(param1:int) : void;
      
      function as_closePopUps() : void;
      
      function as_isOnTop(param1:int, param2:String) : Boolean;
      
      function as_bringToFront(param1:int, param2:String) : void;
      
      function as_showContainers(param1:Array, param2:int) : void;
      
      function as_hideContainers(param1:Array, param2:int) : void;
      
      function as_isContainerShown(param1:int) : Boolean;
      
      function as_getVisibleLayers() : Array;
      
      function as_setVisibleLayers(param1:Array) : void;
   }
}
