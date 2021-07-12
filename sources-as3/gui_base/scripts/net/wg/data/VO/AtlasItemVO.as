package net.wg.data.VO
{
   import net.wg.infrastructure.interfaces.IAtlasItemVO;
   
   public class AtlasItemVO implements IAtlasItemVO
   {
       
      
      private var _x:int = -1;
      
      private var _y:int = -1;
      
      private var _width:int = -1;
      
      private var _height:int = -1;
      
      private var _name:String = "";
      
      public function AtlasItemVO()
      {
         super();
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get height() : int
      {
         return this._height;
      }
      
      public function set height(param1:int) : void
      {
         this._height = param1;
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function set width(param1:int) : void
      {
         this._width = param1;
      }
      
      public function get x() : int
      {
         return this._x;
      }
      
      public function set x(param1:int) : void
      {
         this._x = param1;
      }
      
      public function get y() : int
      {
         return this._y;
      }
      
      public function set y(param1:int) : void
      {
         this._y = param1;
      }
      
      public function dispose() : void
      {
      }
   }
}
