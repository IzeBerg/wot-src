package scaleform.clik.events
{
   import flash.events.Event;
   
   public class IndexEvent extends Event
   {
      
      public static const INDEX_CHANGE:String = "clikIndexChange";
       
      
      public var index:int = -1;
      
      public var lastIndex:int = -1;
      
      public var data:Object;
      
      public function IndexEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:int = -1, param5:int = -1, param6:Object = null)
      {
         super(param1,param2,param3);
         this.index = param4;
         this.lastIndex = param5;
         this.data = param6;
      }
      
      override public function clone() : Event
      {
         return new IndexEvent(type,bubbles,cancelable,this.index,this.lastIndex,this.data);
      }
      
      override public function toString() : String
      {
         return formatToString("IndexEvent","type","bubbles","cancelable","index","lastIndex","data");
      }
   }
}
