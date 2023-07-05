package net.wg.gui.cyberSport.views.respawn
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class UnitSlotButtonProperties extends DAAPIDataClass
   {
       
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _width:Number;
      
      private var _height:Number;
      
      public function UnitSlotButtonProperties(param1:Object)
      {
         super(param1);
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(param1:Number) : void
      {
         this._x = param1;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
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
