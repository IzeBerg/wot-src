package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventRadialMenuMeta extends IEventDispatcher
   {
       
      
      function showHandCursorS() : void;
      
      function hideHandCursorS() : void;
      
      function leaveRadialModeS() : void;
      
      function as_showWithName(param1:String, param2:Array, param3:Array, param4:String) : void;
   }
}
