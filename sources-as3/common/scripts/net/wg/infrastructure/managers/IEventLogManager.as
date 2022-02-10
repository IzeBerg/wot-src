package net.wg.infrastructure.managers
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.infrastructure.base.meta.IEventLogManagerMeta;
   
   public interface IEventLogManager extends IEventLogManagerMeta
   {
       
      
      function logUIElementDropDown(param1:DisplayObject, param2:String, param3:uint) : void;
      
      function logUIElementTooltip(param1:DisplayObject, param2:String, param3:uint) : void;
      
      function logUIElementViewStack(param1:DisplayObject, param2:String, param3:uint) : void;
      
      function logUIElementLoader(param1:DisplayObject, param2:String, param3:uint) : void;
      
      function logUIEvent(param1:Event, param2:uint) : void;
      
      function logUIEventRenderer(param1:DisplayObject, param2:Event, param3:uint) : void;
      
      function logUIEventHandleInput(param1:String, param2:uint) : void;
      
      function logUIEventContextMenuItem(param1:Event, param2:uint) : void;
      
      function logUIEventContextMenu(param1:DisplayObject, param2:String, param3:uint) : void;
   }
}
