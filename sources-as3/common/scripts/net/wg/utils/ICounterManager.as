package net.wg.utils
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ICounterManager extends IDisposable
   {
       
      
      function disposeCountersForContainer(param1:String) : Vector.<DisplayObject>;
      
      function removeCounter(param1:DisplayObject, param2:String = null) : void;
      
      function setCounter(param1:DisplayObject, param2:String, param3:String = null, param4:ICounterProps = null) : int;
   }
}
