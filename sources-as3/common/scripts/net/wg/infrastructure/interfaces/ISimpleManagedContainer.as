package net.wg.infrastructure.interfaces
{
   public interface ISimpleManagedContainer extends IUIComponentEx
   {
       
      
      function get layer() : int;
      
      function get layerName() : String;
      
      function get manageFocus() : Boolean;
      
      function get manageSize() : Boolean;
      
      function set manageSize(param1:Boolean) : void;
   }
}
