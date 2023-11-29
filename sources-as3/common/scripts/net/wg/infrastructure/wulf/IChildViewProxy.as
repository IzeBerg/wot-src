package net.wg.infrastructure.wulf
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IChildViewProxy extends IDisposable
   {
       
      
      function insertWrapper(param1:String, param2:uint, param3:uint = 0, param4:Boolean = false) : IViewWrapper;
      
      function removeWrapper(param1:IViewWrapper = null, param2:uint = 0) : void;
      
      function focusWrapper(param1:IViewWrapper = null, param2:uint = 0) : void;
      
      function getManageSize(param1:uint = 0) : Boolean;
      
      function getContainerWidth(param1:uint = 0) : uint;
      
      function getContainerHeight(param1:uint = 0) : uint;
      
      function setWindowPosition(param1:IViewWrapper, param2:Number, param3:Number) : void;
   }
}
