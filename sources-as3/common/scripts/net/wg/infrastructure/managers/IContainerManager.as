package net.wg.infrastructure.managers
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   import net.wg.infrastructure.interfaces.IView;
   
   public interface IContainerManager extends IEventDispatcher
   {
       
      
      function registerContainer(param1:ISimpleManagedContainer) : void;
      
      function updateStage(param1:Number, param2:Number) : void;
      
      function updateFocus(param1:Object = null) : void;
      
      function isModalViewsExisting() : Boolean;
      
      function getContainer(param1:uint) : ISimpleManagedContainer;
      
      function getContainersFocusOrder() : Array;
      
      function getFocusPriority(param1:int) : Number;
      
      function setVisibleContainers(param1:Boolean, param2:Vector.<int>) : void;
      
      function storeVisibleContainers() : void;
      
      function set loader(param1:ILoaderManager) : void;
      
      function get lastFocusedView() : IView;
      
      function set lastFocusedView(param1:IView) : void;
      
      function get cursorContainer() : ISimpleManagedContainer;
   }
}
