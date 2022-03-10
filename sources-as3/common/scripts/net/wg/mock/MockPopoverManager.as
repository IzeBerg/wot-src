package net.wg.mock
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.IClosePopoverCallback;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.managers.IPopoverManager;
   
   public class MockPopoverManager implements IPopoverManager
   {
       
      
      public function MockPopoverManager()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function hide() : void
      {
      }
      
      public function isPopover(param1:IView) : Boolean
      {
         return false;
      }
      
      public function show(param1:IPopOverCaller, param2:String, param3:Object = null, param4:IClosePopoverCallback = null) : void
      {
      }
      
      public function showDirectly(param1:DisplayObject, param2:DisplayObject, param3:String, param4:Object = null, param5:IClosePopoverCallback = null) : void
      {
      }
      
      public function get popoverCaller() : IPopOverCaller
      {
         return null;
      }
      
      public function set popoverCaller(param1:IPopOverCaller) : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return false;
      }
   }
}
