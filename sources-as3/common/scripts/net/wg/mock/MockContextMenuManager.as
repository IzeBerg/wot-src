package net.wg.mock
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.infrastructure.managers.IContextMenuManager;
   
   public class MockContextMenuManager implements IContextMenuManager
   {
       
      
      public function MockContextMenuManager()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function as_hide() : void
      {
      }
      
      public function as_setOptions(param1:Object) : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function hide() : void
      {
      }
      
      public function isShown() : Boolean
      {
         return false;
      }
      
      public function onHideS() : void
      {
      }
      
      public function onOptionSelectS(param1:String) : void
      {
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function requestOptionsS(param1:String, param2:Object = null) : void
      {
      }
      
      public function show(param1:String, param2:DisplayObject = null, param3:Object = null) : void
      {
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return false;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function as_forcePopover(param1:String, param2:Object) : void
      {
      }
      
      public function as_show(param1:String, param2:Object) : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return false;
      }
   }
}
