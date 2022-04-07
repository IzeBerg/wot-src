package net.wg.gui.lobby.battleResults.data
{
   import flash.utils.Dictionary;
   import net.wg.gui.components.advanced.SortingButtonVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ColumnCollection implements IDisposable
   {
       
      
      private var _dict:Dictionary;
      
      private var _list:Vector.<ColumnData>;
      
      private var _isLeft:Boolean;
      
      private var _headerData:Array;
      
      private var _disposed:Boolean = false;
      
      public function ColumnCollection(param1:Boolean)
      {
         super();
         this._dict = new Dictionary();
         this._list = new Vector.<ColumnData>();
         this._isLeft = param1;
      }
      
      public function get isLeft() : Boolean
      {
         return this._isLeft;
      }
      
      public function add(param1:String, param2:String, param3:String, param4:int) : ColumnData
      {
         var _loc5_:ColumnData = new ColumnData(this._list.length,param1,param3,param2,param4,this._isLeft);
         this._list.push(_loc5_);
         this._dict[param1] = _loc5_;
         return _loc5_;
      }
      
      public function cleanUp() : void
      {
         var _loc1_:ColumnData = null;
         App.utils.data.cleanupDynamicObject(this._dict);
         for each(_loc1_ in this._list)
         {
            _loc1_.dispose();
         }
         this._list.splice(0,this._list.length);
      }
      
      public function dispose() : void
      {
         var _loc1_:SortingButtonVO = null;
         this._disposed = true;
         this.cleanUp();
         this._dict = null;
         this._list = null;
         if(this._headerData != null)
         {
            for each(_loc1_ in this._headerData)
            {
               _loc1_.dispose();
            }
            this._headerData.splice(0,this._headerData);
            this._headerData = null;
         }
      }
      
      public function getById(param1:String) : ColumnData
      {
         return this._dict[param1];
      }
      
      public function getByIndex(param1:int) : ColumnData
      {
         return this._list[param1];
      }
      
      public function getHeaderData() : Array
      {
         var _loc3_:SortingButtonVO = null;
         if(this._headerData != null)
         {
            for each(_loc3_ in this._headerData)
            {
               _loc3_.dispose();
            }
            this._headerData.splice(0,this._headerData);
         }
         var _loc1_:int = this._list.length;
         this._headerData = new Array(_loc1_);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._headerData[_loc2_] = this._list[_loc2_].newSortingButtonInfo();
            _loc2_++;
         }
         return this._headerData;
      }
      
      public function initSorting(param1:String, param2:Array, param3:Boolean, param4:String) : void
      {
         var _loc5_:ColumnData = this._dict[param1] as ColumnData;
         App.utils.asserter.assertNotNull(_loc5_,"Could not set soring - no data for key " + param1);
         if(_loc5_ != null)
         {
            _loc5_.setSorting(param2,param3,param4);
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
