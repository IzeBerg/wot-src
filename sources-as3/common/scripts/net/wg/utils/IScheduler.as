package net.wg.utils
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IScheduler extends IDisposable
   {
       
      
      function scheduleTask(param1:Function, param2:Number, ... rest) : void;
      
      function scheduleRepeatableTask(param1:Function, param2:Number, param3:int = 1, ... rest) : void;
      
      function scheduleNonCancelableTask(param1:Function, param2:Number, ... rest) : void;
      
      function scheduleOnNextFrame(param1:Function, ... rest) : void;
      
      function cancelTask(param1:Function) : void;
      
      function cancelAll() : void;
      
      function isEmpty() : Boolean;
   }
}
