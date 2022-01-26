package net.wg.gui.lobby.techtree.data.vo
{
   import flash.geom.Point;
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.utils.ILocale;
   
   public class NTDisplayInfo implements IValueObject
   {
      
      private static const MIN_SOURCE_ARRAY_LEN:uint = 4;
      
      private static const SOURCE_ARRAY_ROW_INDEX:uint = 0;
      
      private static const SOURCE_ARRAY_COLUMN_INDEX:uint = 1;
      
      private static const SOURCE_ARRAY_POSITION_INDEX:uint = 2;
      
      private static const SOURCE_ARRAY_LINES_INDEX:uint = 3;
      
      private static const POSITION_ARRAY_X_INDEX:uint = 0;
      
      private static const POSITION_ARRAY_Y_INDEX:uint = 1;
       
      
      private var _row:int;
      
      private var _column:int;
      
      private var _position:Point;
      
      private var _lines:Array;
      
      public function NTDisplayInfo(param1:int = -1, param2:int = -1, param3:Point = null, param4:Array = null)
      {
         super();
         this._row = param1;
         this._column = param2;
         this._position = param3;
         this._lines = param4;
      }
      
      public function dispose() : void
      {
         this._position = null;
         if(this._lines != null)
         {
            this._lines.splice(0,this._lines.length);
            this._lines = null;
         }
      }
      
      public function fromArray(param1:Array, param2:ILocale) : void
      {
         var _loc3_:Array = null;
         if(param1.length >= MIN_SOURCE_ARRAY_LEN)
         {
            this._row = int(param1[SOURCE_ARRAY_ROW_INDEX]);
            this._column = int(param1[SOURCE_ARRAY_COLUMN_INDEX]);
            _loc3_ = param1[SOURCE_ARRAY_POSITION_INDEX];
            this._position = new Point(_loc3_[POSITION_ARRAY_X_INDEX],_loc3_[POSITION_ARRAY_Y_INDEX]);
            this._lines = param1[SOURCE_ARRAY_LINES_INDEX];
         }
      }
      
      public function fromObject(param1:Object, param2:ILocale) : void
      {
         var _loc3_:Array = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.row != null)
         {
            this._row = int(param1.row);
         }
         if(param1.column != null)
         {
            this._column = int(param1.column);
         }
         if(param1.position != null)
         {
            _loc3_ = param1.position;
            this._position = new Point(_loc3_[0],_loc3_[1]);
         }
         if(param1.lines != null)
         {
            this._lines = param1.lines;
         }
      }
      
      public function toString() : String
      {
         return "[NTDisplayInfo: row = " + this._row + ", column = " + this._column + ", position = " + this._position + ", lines = " + this._lines + " ]";
      }
      
      public function get row() : int
      {
         return this._row;
      }
      
      public function get column() : int
      {
         return this._column;
      }
      
      public function get position() : Point
      {
         return this._position;
      }
      
      public function get lines() : Array
      {
         return this._lines;
      }
   }
}
