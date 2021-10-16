package net.wg.utils.helpLayout
{
   import flash.events.IEventDispatcher;
   
   public interface IHelpLayoutComponent extends IEventDispatcher
   {
       
      
      function getLayoutProperties() : Vector.<HelpLayoutVO>;
   }
}
