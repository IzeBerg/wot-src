package scaleform.gfx
{
   import flash.events.KeyboardEvent;
   
   public final class KeyboardEventEx extends KeyboardEvent
   {
       
      
      public var controllerIdx:uint = 0;
      
      public function KeyboardEventEx(param1:String)
      {
         super(param1);
      }
   }
}
