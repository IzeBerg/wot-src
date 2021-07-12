package net.wg.mock.utils
{
   import net.wg.utils.IScheduler;
   
   public class MockScheduler implements IScheduler
   {
       
      
      public function MockScheduler()
      {
         super();
      }
      
      public function cancelAll() : void
      {
      }
      
      public function cancelTask(param1:Function) : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function isEmpty() : Boolean
      {
         return false;
      }
      
      public function scheduleNonCancelableTask(param1:Function, param2:Number, ... rest) : void
      {
      }
      
      public function scheduleOnNextFrame(param1:Function, ... rest) : void
      {
      }
      
      public function scheduleRepeatableTask(param1:Function, param2:Number, param3:int = 1, ... rest) : void
      {
      }
      
      public function scheduleTask(param1:Function, param2:Number, ... rest) : void
      {
      }
   }
}
