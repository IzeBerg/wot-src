package net.wg.data.VO
{
   public class ProgressSimpleInfo
   {
       
      
      public var min:Number;
      
      public var current:Number;
      
      public var max:Number;
      
      public function ProgressSimpleInfo(param1:Number, param2:Number, param3:Number)
      {
         super();
         this.min = param1;
         this.current = param2;
         this.max = param3;
      }
      
      public function isEquals(param1:ProgressSimpleInfo) : Boolean
      {
         return this.min == param1.min && this.current == param1.current && this.max == param1.max;
      }
   }
}
