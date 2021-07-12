package net.wg.gui.components.controls
{
   import flash.events.Event;
   import net.wg.gui.components.advanced.SortingButtonVO;
   import net.wg.gui.components.controls.events.SortableScrollingListEvent;
   import net.wg.infrastructure.interfaces.IDAAPISortable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class SortableScrollingList extends ScrollingListEx
   {
      
      public static const DATA_INVALIDATED:String = "dataInvalidated";
      
      protected static const SORTING_INVALID:String = "sortingInv";
      
      protected static const COLUMNS_INVALID:String = "columnsInv";
       
      
      protected var _sortProps:Array;
      
      private var _columnsData:IDataProvider;
      
      private var _optionsDict:Object;
      
      private var _sortingOrder:Array;
      
      private var _sortingTypes:Object;
      
      private var _sortingDefaults:Object;
      
      private var _isRowHeightFixed:Boolean = false;
      
      public function SortableScrollingList()
      {
         this._sortProps = [];
         this._optionsDict = {};
         this._sortingOrder = [];
         this._sortingTypes = {};
         this._sortingDefaults = {};
         super();
      }
      
      override public function invalidateData() : void
      {
         super.invalidateData();
         dispatchEvent(new Event(DATA_INVALIDATED,true));
      }
      
      override protected function draw() : void
      {
         if(isInvalid(SORTING_INVALID))
         {
            this.applySorting(this._sortProps);
         }
         if(isInvalid(COLUMNS_INVALID) && this._columnsData != null)
         {
            this.invalidateColumnsData();
         }
         super.draw();
      }
      
      override protected function drawLayout() : void
      {
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight;
         var _loc3_:Number = availableWidth - padding.horizontal;
         var _loc4_:Number = margin + padding.left;
         var _loc5_:Number = margin + padding.top;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc7_);
            _loc8_.x = Math.round(_loc4_);
            _loc8_.y = Math.round(_loc5_ + _loc7_ * _loc2_);
            if(_widthAutoResize)
            {
               _loc8_.width = _loc3_;
            }
            if(this._isRowHeightFixed)
            {
               _loc8_.height = _loc2_;
            }
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         drawScrollBar();
      }
      
      override protected function onDispose() : void
      {
         if(this._columnsData)
         {
            this._columnsData.cleanUp();
            this._columnsData = null;
         }
         if(this._sortProps)
         {
            this._sortProps.splice(0,this._sortProps.length);
         }
         this._sortProps = null;
         if(this._sortingOrder)
         {
            this._sortingOrder.splice(0,this._sortingOrder.length);
         }
         this._sortingOrder = null;
         this._sortingTypes = null;
         this._sortingDefaults = null;
         this._optionsDict = null;
         super.onDispose();
      }
      
      public function sortByField(param1:String, param2:Boolean = true) : void
      {
         this.setFieldOption(param1,param2);
         this.invalidateSorting(param1);
      }
      
      protected function invalidateSorting(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(param1 is Array)
         {
            this._sortProps = param1 as Array;
         }
         else
         {
            _loc2_ = this._sortingOrder.slice();
            _loc3_ = _loc2_.indexOf(param1);
            if(_loc3_ > -1)
            {
               _loc2_.splice(_loc3_,1);
            }
            _loc2_.unshift(param1);
            this._sortProps = _loc2_;
         }
         invalidate(SORTING_INVALID);
      }
      
      protected function applySorting(param1:Array) : void
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:SortableScrollingListEvent = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         if(dataProvider)
         {
            _loc2_ = [];
            for each(_loc3_ in param1)
            {
               if(_loc2_.length == 0)
               {
                  _loc2_.push(this._optionsDict[_loc3_]);
               }
               else
               {
                  _loc2_.push(this._optionsDict[_loc3_] | this._sortingDefaults[_loc3_]);
               }
            }
            _loc4_ = param1 != null ? int(param1.length) : int(0);
            if(_loc4_ > 0 && _loc2_ && _loc4_ == _loc2_.length)
            {
               if(dataProvider is IDAAPISortable)
               {
                  _loc6_ = [];
                  _loc7_ = 0;
                  while(_loc7_ < _loc4_)
                  {
                     _loc6_.push(!Boolean(_loc2_[_loc7_] ^ this._sortingTypes[param1[_loc7_]]));
                     _loc7_++;
                  }
                  (dataProvider as IDAAPISortable).DAAPIsortOn(param1,_loc6_);
               }
               else if(dataProvider is Array)
               {
                  (dataProvider as Array).sortOn(param1,_loc2_);
               }
            }
            _loc5_ = new SortableScrollingListEvent(SortableScrollingListEvent.SORT_APPLIED);
            dispatchEvent(_loc5_);
            this.invalidateData();
         }
      }
      
      private function setFieldOption(param1:String, param2:Boolean) : void
      {
         var _loc3_:uint = !!param2 ? uint(0) : uint(Array.DESCENDING);
         this._optionsDict = App.utils.data.cloneObject(this._sortingTypes);
         this._optionsDict[param1] = (!!this._sortingTypes.hasOwnProperty(param1) ? this._sortingTypes[param1] : 0) | _loc3_;
      }
      
      private function invalidateColumnsData() : void
      {
         var _loc3_:Object = null;
         var _loc4_:SortingButtonVO = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         this._sortingOrder.splice(0,this._sortingOrder.length);
         this._sortingTypes = {};
         this._sortingDefaults = {};
         if(this._columnsData)
         {
            _loc9_ = 0;
            for each(_loc3_ in this._columnsData)
            {
               _loc4_ = _loc3_ as SortingButtonVO;
               if(_loc4_)
               {
                  _loc5_ = _loc4_.id;
                  _loc6_ = _loc4_.dataSortType;
                  _loc7_ = _loc4_.defaultSortDir;
                  _loc8_ = _loc4_.sortOrder;
               }
               else
               {
                  _loc5_ = !!_loc3_.hasOwnProperty("iconId") ? _loc3_.iconId : "column" + _loc9_;
                  _loc6_ = !!_loc3_.hasOwnProperty("dataSortType") ? uint(_loc3_.dataSortType) : uint(Array.NUMERIC);
                  _loc7_ = !!_loc3_.hasOwnProperty("defaultSortDir") ? uint(_loc3_.defaultSortDir) : uint(0);
                  _loc8_ = !!_loc3_.hasOwnProperty("sortOrder") ? int(_loc3_.sortOrder) : int(_loc9_);
               }
               if(_loc8_ >= 0)
               {
                  this._sortingOrder[_loc8_] = _loc5_;
                  this._sortingTypes[_loc5_] = _loc6_;
                  this._sortingDefaults[_loc5_] = _loc7_;
               }
            }
         }
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         if(this._sortProps && this._sortProps.length > 0 && this._sortProps.length != this._sortingOrder.length)
         {
            _loc2_ = this._sortProps[0];
            this._sortProps = this._sortingOrder.slice();
            if(this._sortingOrder.indexOf(_loc2_) > -1)
            {
               this.invalidateSorting(_loc2_);
            }
            _loc1_ = this._optionsDict[_loc2_];
         }
         else
         {
            this._sortProps = this._sortingOrder.slice();
         }
         this._optionsDict = App.utils.data.cloneObject(this._sortingTypes);
         if(_loc2_)
         {
            this._optionsDict[_loc2_] = _loc1_ | this._sortingTypes[_loc2_];
         }
      }
      
      public function set columnsData(param1:IDataProvider) : void
      {
         this._columnsData = param1;
         invalidate(COLUMNS_INVALID);
      }
      
      public function get isRowHeightFixed() : Boolean
      {
         return this._isRowHeightFixed;
      }
      
      public function set isRowHeightFixed(param1:Boolean) : void
      {
         this._isRowHeightFixed = param1;
      }
   }
}
