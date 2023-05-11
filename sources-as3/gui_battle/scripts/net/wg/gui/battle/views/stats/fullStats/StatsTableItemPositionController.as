package net.wg.gui.battle.views.stats.fullStats
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StatsTableItemPositionController implements IDisposable
   {
      
      private static const DEFAULT_ITEM_HEIGHT:Number = 25;
       
      
      private var _objectsPositions:Dictionary = null;
      
      private var _row:int = 0;
      
      private var _colunm:int;
      
      private var _itemHeight:Number = NaN;
      
      private var _columns:Dictionary = null;
      
      private var _disposed:Boolean = false;
      
      public function StatsTableItemPositionController(param1:Number, param2:Number, param3:int, param4:int, ... rest)
      {
         var _loc6_:DisplayObject = null;
         var _loc7_:Object = null;
         super();
         this._colunm = param3;
         this._row = param4;
         this._itemHeight = DEFAULT_ITEM_HEIGHT;
         this._objectsPositions = new Dictionary();
         this._columns = new Dictionary();
         for each(_loc7_ in rest)
         {
            if(_loc7_ is DisplayObject)
            {
               _loc6_ = DisplayObject(_loc7_);
               this._objectsPositions[_loc7_] = new Point(_loc6_.x - param1,_loc6_.y - param2);
            }
         }
      }
      
      public function get row() : int
      {
         return this._row;
      }
      
      public function set row(param1:int) : void
      {
         var _loc2_:* = null;
         if(this._row == param1)
         {
            return;
         }
         for(_loc2_ in this._objectsPositions)
         {
            DisplayObject(_loc2_).y = param1 * this._itemHeight + this._objectsPositions[_loc2_].y;
         }
         this._row = param1;
      }
      
      public function get colunm() : int
      {
         return this._colunm;
      }
      
      public function set colunm(param1:int) : void
      {
         var _loc3_:* = null;
         if(this._colunm == param1)
         {
            return;
         }
         var _loc2_:Number = this._columns[param1];
         if(!isNaN(_loc2_))
         {
            for(_loc3_ in this._objectsPositions)
            {
               DisplayObject(_loc3_).x = _loc2_ + this._objectsPositions[_loc3_].x;
            }
         }
         this._colunm = param1;
      }
      
      public function setItemHeight(param1:Number) : void
      {
         this._itemHeight = DEFAULT_ITEM_HEIGHT;
      }
      
      public function setColumnPosition(param1:int, param2:Number) : void
      {
         this._columns[param1] = param2;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         App.utils.data.cleanupDynamicObject(this._objectsPositions);
         App.utils.data.cleanupDynamicObject(this._columns);
         this._objectsPositions = null;
         this._columns = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
