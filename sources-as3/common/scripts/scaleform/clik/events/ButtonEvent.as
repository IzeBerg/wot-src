package scaleform.clik.events
{
   import flash.events.Event;
   
   public class ButtonEvent extends Event
   {
      
      public static const PRESS:String = "buttonPress";
      
      public static const CLICK:String = "buttonClick";
      
      public static const DRAG_OVER:String = "dragOver";
      
      public static const DRAG_OUT:String = "dragOut";
      
      public static const RELEASE_OUTSIDE:String = "releaseOutside";
       
      
      public var controllerIdx:uint = 0;
      
      public var buttonIdx:uint = 0;
      
      public var isKeyboard:Boolean = false;
      
      public var isRepeat:Boolean = false;
      
      public function ButtonEvent(param1:String, param2:Boolean = true, param3:Boolean = false, param4:uint = 0, param5:uint = 0, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param2,param3);
         this.controllerIdx = param4;
         this.buttonIdx = param5;
         this.isKeyboard = param6;
         this.isRepeat = param7;
      }
      
      override public function clone() : Event
      {
         return new ButtonEvent(type,bubbles,cancelable,this.controllerIdx,this.buttonIdx,this.isKeyboard,this.isRepeat);
      }
      
      override public function toString() : String
      {
         return formatToString("ButtonEvent","type","bubbles","cancelable","controllerIdx","buttonIdx","isKeyboard","isRepeat");
      }
   }
}
