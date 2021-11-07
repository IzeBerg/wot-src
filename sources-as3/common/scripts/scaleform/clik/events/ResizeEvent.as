package scaleform.clik.events
{
   import flash.events.Event;
   
   public class ResizeEvent extends Event
   {
      
      public static const RESIZE:String = "resize";
      
      public static const SCOPE_ORIGINALS_UPDATE:String = "scopeOriginalsUpdate";
       
      
      public var scaleX:Number = 1;
      
      public var scaleY:Number = 1;
      
      public function ResizeEvent(param1:String, param2:Number, param3:Number)
      {
         super(param1,false,false);
         this.scaleX = param2;
         this.scaleY = param3;
      }
      
      override public function toString() : String
      {
         return formatToString("ResizeEvent","type","scaleX","scaleY");
      }
      
      override public function clone() : Event
      {
         return new ResizeEvent(type,this.scaleX,this.scaleY);
      }
   }
}
