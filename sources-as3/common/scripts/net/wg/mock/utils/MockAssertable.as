package net.wg.mock.utils
{
   import flash.display.MovieClip;
   import net.wg.utils.IAssertable;
   
   public class MockAssertable implements IAssertable
   {
       
      
      public function MockAssertable()
      {
         super();
      }
      
      public function assert(param1:Boolean, param2:String, param3:Class = null) : void
      {
      }
      
      public function assertFrameExists(param1:String, param2:MovieClip, param3:Class = null) : void
      {
      }
      
      public function assertNotNull(param1:Object, param2:String, param3:Class = null) : void
      {
      }
      
      public function assertNull(param1:Object, param2:String, param3:Class = null) : void
      {
      }
      
      public function enableErrorLogging(param1:Boolean) : void
      {
      }
   }
}
