package scaleform.gfx
{
   import flash.events.TextEvent;
   
   public final class TextEventEx extends TextEvent
   {
      
      public static const LINK_MOUSE_OVER:String = "linkMouseOver";
      
      public static const LINK_MOUSE_OUT:String = "linkMouseOut";
       
      
      public var controllerIdx:uint = 0;
      
      public var buttonIdx:uint = 0;
      
      public function TextEventEx(param1:String)
      {
         super(param1);
      }
   }
}
