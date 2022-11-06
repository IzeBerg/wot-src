package scaleform.clik.events
{
   import flash.events.Event;
   import scaleform.clik.controls.Button;
   
   public class ButtonBarEvent extends Event
   {
      
      public static const BUTTON_SELECT:String = "buttonSelect";
       
      
      public var index:int = -1;
      
      public var renderer:Button;
      
      public function ButtonBarEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:int = -1, param5:Button = null)
      {
         super(param1,param2,param3);
         this.index = param4;
         this.renderer = param5;
      }
      
      override public function clone() : Event
      {
         return new ButtonBarEvent(type,bubbles,cancelable,this.index,this.renderer);
      }
      
      override public function toString() : String
      {
         return formatToString("ButtonBarEvent","type","bubbles","cancelable","index","renderer");
      }
   }
}
