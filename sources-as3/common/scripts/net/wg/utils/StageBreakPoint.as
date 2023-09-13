package net.wg.utils
{
   public class StageBreakPoint
   {
       
      
      private var _name:String = "";
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      public function StageBreakPoint(param1:String, param2:int, param3:int)
      {
         super();
         this._name = param1;
         this._width = param2;
         this._height = param3;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function get height() : int
      {
         return this._height;
      }
   }
}
