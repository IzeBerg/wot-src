package net.wg.gui.lobby.techtree.data.vo
{
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.utils.ILocale;
   
   public class NationGridDisplaySettings implements IValueObject
   {
      
      private static const MIN_SOURCE_ARRAY_LEN:uint = 6;
      
      private static const SOURCE_ARRAY_ROWS_INDEX:uint = 4;
      
      private static const SOURCE_ARRAY_COLUMNS_INDEX:uint = 5;
      
      private static const SOURCE_ARRAY_STARTX_INDEX:uint = 0;
      
      private static const SOURCE_ARRAY_STARTY_INDEX:uint = 1;
      
      private static const SOURCE_ARRAY_STEPX_INDEX:uint = 2;
      
      private static const SOURCE_ARRAY_STEPY_INDEX:uint = 3;
       
      
      private var _numRows:int = 0;
      
      private var _numColumns:int = 0;
      
      private var _start:Point = null;
      
      private var _step:Point = null;
      
      private var _disposed:Boolean = false;
      
      public function NationGridDisplaySettings()
      {
         super();
      }
      
      public function cleanUp() : void
      {
         this._numColumns = Values.ZERO;
         this._numRows = Values.ZERO;
         this._step = null;
         this._start = null;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.cleanUp();
      }
      
      public function fromArray(param1:Array, param2:ILocale) : void
      {
         this.cleanUp();
         if(param1.length >= MIN_SOURCE_ARRAY_LEN)
         {
            this._numRows = int(param1[SOURCE_ARRAY_ROWS_INDEX]);
            this._numColumns = int(param1[SOURCE_ARRAY_COLUMNS_INDEX]);
            this._start = new Point(int(param1[SOURCE_ARRAY_STARTX_INDEX]),int(param1[SOURCE_ARRAY_STARTY_INDEX]));
            this._step = new Point(int(param1[SOURCE_ARRAY_STEPX_INDEX]),int(param1[SOURCE_ARRAY_STEPY_INDEX]));
         }
      }
      
      public function fromObject(param1:Object, param2:ILocale) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.size != null && param1.size != undefined)
         {
            this._numRows = param1.size[0];
            this._numColumns = param1.size[1];
         }
         if(param1.start != null && param1.start != undefined)
         {
            this._start = new Point(param1.start[0],param1.start[1]);
         }
         if(param1.step != null && param1.step != undefined)
         {
            this._step = new Point(param1.step[0],param1.step[1]);
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function isFilled() : Boolean
      {
         return this._numColumns > 0 && this._numRows > 0;
      }
      
      public function toString() : String
      {
         return "[NationGridDisplaySettings: rows = " + this._numRows + ", columns = " + this._numColumns + ", start: " + this._start + ", step: " + this._step + " ]";
      }
      
      public function get rows() : int
      {
         return this._numRows;
      }
      
      public function get columns() : int
      {
         return this._numColumns;
      }
      
      public function get step() : Point
      {
         return this._step;
      }
      
      public function get start() : Point
      {
         return this._start;
      }
   }
}
