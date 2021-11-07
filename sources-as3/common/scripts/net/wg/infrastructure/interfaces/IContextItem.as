package net.wg.infrastructure.interfaces
{
   public interface IContextItem
   {
       
      
      function get id() : String;
      
      function get label() : String;
      
      function get submenu() : Vector.<IContextItem>;
      
      function get linkage() : String;
      
      function get initData() : Object;
      
      function get iconType() : String;
   }
}
