package net.wg.gui.components.tooltips.VO
{
   public class Dimension
   {
       
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      public function Dimension()
      {
         super();
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set width(param1:Number) : void
      {
         this._width = param1;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(param1:Number) : void
      {
         this._height = param1;
      }
   }
}
