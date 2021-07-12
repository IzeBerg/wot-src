package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.infrastructure.managers.IEventLogManager;
   
   public class MockEventLogManager implements IEventLogManager
   {
       
      
      public function MockEventLogManager()
      {
         super();
      }
      
      public function logUIElementDropDown(param1:DisplayObject, param2:String, param3:uint) : void
      {
      }
      
      public function logUIElementTooltip(param1:DisplayObject, param2:String, param3:uint) : void
      {
      }
      
      public function logUIElementViewStack(param1:DisplayObject, param2:String, param3:uint) : void
      {
      }
      
      public function logUIElementLoader(param1:DisplayObject, param2:String, param3:uint) : void
      {
      }
      
      public function logUIEvent(param1:Event, param2:uint) : void
      {
      }
      
      public function logUIEventRenderer(param1:DisplayObject, param2:Event, param3:uint) : void
      {
      }
      
      public function logUIEventHandleInput(param1:String, param2:uint) : void
      {
      }
      
      public function logUIEventContextMenuItem(param1:Event, param2:uint) : void
      {
      }
      
      public function logUIEventContextMenu(param1:DisplayObject, param2:String, param3:uint) : void
      {
      }
      
      public function logEventS(param1:int, param2:String, param3:int, param4:int) : void
      {
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return false;
      }
      
      public function as_setSystemEnabled(param1:Boolean) : void
      {
      }
   }
}
