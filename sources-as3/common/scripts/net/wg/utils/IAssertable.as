package net.wg.utils
{
   import flash.display.MovieClip;
   
   public interface IAssertable
   {
       
      
      function assert(param1:Boolean, param2:String, param3:Class = null) : void;
      
      function assertNotNull(param1:Object, param2:String, param3:Class = null) : void;
      
      function assertNull(param1:Object, param2:String, param3:Class = null) : void;
      
      function assertFrameExists(param1:String, param2:MovieClip, param3:Class = null) : void;
      
      function enableErrorLogging(param1:Boolean) : void;
   }
}
