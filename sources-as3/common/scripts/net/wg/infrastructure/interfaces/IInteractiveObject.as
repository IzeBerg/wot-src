package net.wg.infrastructure.interfaces
{
   public interface IInteractiveObject extends IDisplayObject
   {
       
      
      function get tabEnabled() : Boolean;
      
      function set tabEnabled(param1:Boolean) : void;
      
      function get tabIndex() : int;
      
      function set tabIndex(param1:int) : void;
      
      function get focusRect() : Object;
      
      function set focusRect(param1:Object) : void;
      
      function get mouseEnabled() : Boolean;
      
      function set mouseEnabled(param1:Boolean) : void;
      
      function get doubleClickEnabled() : Boolean;
      
      function set doubleClickEnabled(param1:Boolean) : void;
   }
}
