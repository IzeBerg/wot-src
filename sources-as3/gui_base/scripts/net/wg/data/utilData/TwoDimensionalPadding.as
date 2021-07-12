package net.wg.data.utilData
{
   import flash.geom.Point;
   
   public class TwoDimensionalPadding
   {
       
      
      public var top:Point;
      
      public var bottom:Point;
      
      public var left:Point;
      
      public var right:Point;
      
      public function TwoDimensionalPadding(param1:Point = null, param2:Point = null, param3:Point = null, param4:Point = null)
      {
         this.top = new Point();
         this.bottom = new Point();
         this.left = new Point();
         this.right = new Point();
         super();
         if(param1)
         {
            this.top = param1;
         }
         if(param2)
         {
            this.right = param2;
         }
         if(param3)
         {
            this.bottom = param3;
         }
         if(param4)
         {
            this.left = param4;
         }
      }
   }
}
