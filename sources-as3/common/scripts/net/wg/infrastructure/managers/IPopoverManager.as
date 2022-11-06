package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.interfaces.IClosePopoverCallback;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IPopoverManager extends IDisposable
   {
       
      
      function show(param1:IPopOverCaller, param2:String, param3:Object = null, param4:IClosePopoverCallback = null) : void;
      
      function hide() : void;
      
      function isPopover(param1:IView) : Boolean;
      
      function get popoverCaller() : IPopOverCaller;
      
      function set popoverCaller(param1:IPopOverCaller) : void;
   }
}
