package net.wg.gui.interfaces
{
   import flash.events.IEventDispatcher;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public interface IGroupedControl extends IEventDispatcher
   {
       
      
      function get selectedItem() : Object;
      
      function get selectedRenderer() : IListItemRenderer;
      
      function get selectedButton() : ISoundButtonEx;
      
      function get data() : Object;
      
      function get name() : String;
   }
}
