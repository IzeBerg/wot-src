package scaleform.clik.ui
{
   public class InputDetails
   {
       
      
      public var type:String;
      
      public var code:Number;
      
      public var value;
      
      public var navEquivalent:String;
      
      public var controllerIndex:uint;
      
      public var ctrlKey:Boolean;
      
      public var altKey:Boolean;
      
      public var shiftKey:Boolean;
      
      public function InputDetails(param1:String, param2:Number, param3:*, param4:String = null, param5:uint = 0, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false)
      {
         super();
         this.type = param1;
         this.code = param2;
         this.value = param3;
         this.navEquivalent = param4;
         this.controllerIndex = param5;
         this.ctrlKey = param6;
         this.altKey = param7;
         this.shiftKey = param8;
      }
      
      public function toString() : String
      {
         return "[InputDetails code=" + this.code + ", type=" + this.type + " value=" + this.value + ", navEquivalent=" + this.navEquivalent + ", controllerIndex=" + this.controllerIndex + ", ctrlKey=" + this.ctrlKey + ", altKey=" + this.altKey + ", shiftKey=" + this.shiftKey + "]";
      }
   }
}
