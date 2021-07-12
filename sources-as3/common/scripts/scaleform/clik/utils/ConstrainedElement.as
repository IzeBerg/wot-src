package scaleform.clik.utils
{
   import flash.display.DisplayObject;
   
   public class ConstrainedElement
   {
       
      
      public var clip:DisplayObject;
      
      public var edges:uint;
      
      public var left:Number;
      
      public var top:Number;
      
      public var right:Number;
      
      public var bottom:Number;
      
      public var scaleX:Number;
      
      public var scaleY:Number;
      
      public function ConstrainedElement(param1:DisplayObject, param2:uint, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number)
      {
         super();
         this.clip = param1;
         this.edges = param2;
         this.left = param3;
         this.top = param4;
         this.right = param5;
         this.bottom = param6;
         this.scaleX = param7;
         this.scaleY = param8;
      }
      
      public function toString() : String
      {
         return "[ConstrainedElement " + this.clip + ", edges=" + this.edges + ", left=" + this.left + ", right=" + this.right + ", top=" + this.top + ", bottom=" + this.bottom + ", scaleX=" + this.scaleX + ", scaleY=" + this.scaleY + "]";
      }
   }
}
