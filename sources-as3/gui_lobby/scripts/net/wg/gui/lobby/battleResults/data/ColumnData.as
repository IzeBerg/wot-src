package net.wg.gui.lobby.battleResults.data
{
   import net.wg.gui.components.advanced.SortingButtonVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ColumnData implements IDisposable
   {
       
      
      public var sortDirection:String;
      
      private var _index:int;
      
      private var _columnId:String;
      
      private var _iconSource:String;
      
      private var _tooltipId:String;
      
      private var _sortingKeys:Array;
      
      private var _isNumeric:Boolean;
      
      private var _columnWidth:int;
      
      private var _disposed:Boolean = false;
      
      private var _isLeft:Boolean;
      
      public function ColumnData(param1:int, param2:String, param3:String, param4:String, param5:int, param6:Boolean)
      {
         super();
         this._index = param1;
         this._columnId = param2;
         this._iconSource = param3;
         this._tooltipId = param4;
         this._columnWidth = param5;
         this._isLeft = param6;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         if(this._sortingKeys != null)
         {
            this._sortingKeys.splice(0);
            this._sortingKeys = null;
         }
      }
      
      public function newSortingButtonInfo() : SortingButtonVO
      {
         var _loc1_:int = 30;
         var _loc2_:SortingButtonVO = new SortingButtonVO({});
         _loc2_.id = this._columnId;
         _loc2_.iconSource = this._iconSource;
         _loc2_.ascendingIconSource = RES_ICONS.MAPS_ICONS_BUTTONS_TAB_SORT_BUTTON_ASCENDINGSORTARROW;
         _loc2_.descendingIconSource = RES_ICONS.MAPS_ICONS_BUTTONS_TAB_SORT_BUTTON_DESCENDINGSORTARROW;
         _loc2_.toolTip = this._tooltipId;
         _loc2_.buttonWidth = this._columnWidth;
         _loc2_.buttonHeight = _loc1_;
         _loc2_.enabled = this._sortingKeys != null;
         _loc2_.mouseEnabledOnDisabled = true;
         _loc2_.defaultSortDirection = this.sortDirection;
         return _loc2_;
      }
      
      public function setSorting(param1:Array, param2:Boolean, param3:String) : void
      {
         this._sortingKeys = param1;
         this._isNumeric = param2;
         this.sortDirection = param3;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function get isNumeric() : Boolean
      {
         return this._isNumeric;
      }
      
      public function get sortingKeys() : Array
      {
         return this._sortingKeys;
      }
      
      public function get columnId() : String
      {
         return this._columnId;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get isLeft() : Boolean
      {
         return this._isLeft;
      }
   }
}
