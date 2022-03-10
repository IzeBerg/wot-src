package net.wg.mock
{
   import flash.display.DisplayObject;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   
   public class MockCounterManager implements ICounterManager
   {
       
      
      public function MockCounterManager()
      {
         super();
      }
      
      public function disposeCountersForContainer(param1:String) : Vector.<DisplayObject>
      {
         return null;
      }
      
      public function removeCounter(param1:DisplayObject, param2:String = null) : void
      {
      }
      
      public function setCounter(param1:DisplayObject, param2:String, param3:String = null, param4:ICounterProps = null) : int
      {
         return -1;
      }
      
      public function dispose() : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return false;
      }
   }
}
