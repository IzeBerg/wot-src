package net.wg.gui.lobby.profile.pages.technique
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.SortingInfo;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.components.advanced.SortingButton;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.SortableScrollingList;
   import net.wg.gui.events.SortingEvent;
   import net.wg.gui.events.TechniqueListComponentEvent;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.controls.ScrollIndicator;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.motion.Tween;
   
   public class TechniqueListComponent extends UIComponentEx
   {
      
      public static const SELECTED_INDEX_CHANGED:String = "selectedIndexChanged";
      
      private static const LIST_DATA_INVALIDATED:String = "ldInv";
      
      private static const ANIM_SPEED:uint = 1000;
      
      private static const DEFAULT_SORTING:String = "defaultSorting";
      
      private static const DEFAULT_SORTING_ID:uint = 4;
       
      
      public var lowerShadow:MovieClip = null;
      
      public var upperShadow:MovieClip = null;
      
      public var sortableButtonBar:SortableHeaderButtonBar = null;
      
      public var techniqueList:TechniqueList = null;
      
      public var bg:MovieClip = null;
      
      public var scrollBar:ScrollBar = null;
      
      private var _tweenManager:ExcludeTweenManager;
      
      private var _vehicles:DataProvider = null;
      
      private var _selectedColumn:int = 4;
      
      private var _selectedColumnSorting:String = "descending";
      
      private var _isInitialSorting:Boolean = true;
      
      public function TechniqueListComponent()
      {
         this._tweenManager = new ExcludeTweenManager();
         super();
         this.techniqueList.addEventListener(TechniqueList.SELECTED_INDEX_CHANGE,this.onTechniqueListSelectedIndexChangeHandler);
         this.techniqueList.addEventListener(SortableScrollingList.DATA_INVALIDATED,this.onTechniqueListDataInvalidatedHandler);
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         var _loc3_:Number = this.techniqueList.rowHeight;
         var _loc4_:int = _height / _loc3_;
         _loc4_ = _loc4_ != -1 ? int(_loc4_) : int(0);
         this.techniqueList.rowCount = _loc4_;
         var _loc5_:uint = _loc3_ * _loc4_;
         this.techniqueList.setSize(this.techniqueList.width,_loc5_);
         this.techniqueList.invalidateSize();
         this.techniqueList.validateNow();
         this.bg.height = _loc5_ - this.bg.y;
         this.scrollBar.setActualSize(this.scrollBar.width,_loc5_ - this.scrollBar.y);
         this.scrollBar.validateNow();
         this.lowerShadow.y = _loc5_ - this.lowerShadow.height;
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ScrollIndicator = null;
         var _loc5_:Number = NaN;
         if(this._vehicles == null)
         {
            return;
         }
         super.draw();
         if(isInvalid(LIST_DATA_INVALIDATED))
         {
            _loc1_ = this.techniqueList.dataProvider.length;
            _loc2_ = this.techniqueList.renderersCount;
            if(_loc1_ <= _loc2_)
            {
               this._tweenManager.registerAndLaunch(ANIM_SPEED,this.upperShadow,{"alpha":0},this.getAnimTweenSet());
               this._tweenManager.registerAndLaunch(ANIM_SPEED,this.lowerShadow,{"alpha":0},this.getAnimTweenSet());
            }
            else
            {
               _loc3_ = _loc1_ - _loc2_;
               _loc4_ = ScrollIndicator(this.techniqueList.scrollBar);
               _loc5_ = Boolean(_loc4_) ? Number(_loc4_.position) : Number(0);
               if(_loc5_ == 0)
               {
                  this._tweenManager.registerAndLaunch(ANIM_SPEED,this.upperShadow,{"alpha":0},this.getAnimTweenSet());
                  this._tweenManager.registerAndLaunch(ANIM_SPEED,this.lowerShadow,{"alpha":1},this.getAnimTweenSet());
               }
               else if(_loc5_ == _loc3_)
               {
                  this._tweenManager.registerAndLaunch(ANIM_SPEED,this.upperShadow,{"alpha":1},this.getAnimTweenSet());
                  this._tweenManager.registerAndLaunch(ANIM_SPEED,this.lowerShadow,{"alpha":0},this.getAnimTweenSet());
               }
               else
               {
                  this._tweenManager.registerAndLaunch(ANIM_SPEED,this.upperShadow,{"alpha":1},this.getAnimTweenSet());
                  this._tweenManager.registerAndLaunch(ANIM_SPEED,this.lowerShadow,{"alpha":1},this.getAnimTweenSet());
               }
            }
         }
         if(isInvalid(DEFAULT_SORTING))
         {
            this.applyDefaultSorting();
         }
      }
      
      override protected function onDispose() : void
      {
         this._tweenManager.dispose();
         this._tweenManager = null;
         if(this._vehicles)
         {
            this._vehicles.splice(0,this._vehicles.length);
            this._vehicles = null;
         }
         if(this.techniqueList)
         {
            this.techniqueList.removeEventListener(TechniqueList.SELECTED_INDEX_CHANGE,this.onTechniqueListSelectedIndexChangeHandler);
            this.techniqueList.removeEventListener(SortableScrollingList.DATA_INVALIDATED,this.onTechniqueListDataInvalidatedHandler);
            this.techniqueList.dispose();
            this.techniqueList = null;
         }
         if(this.sortableButtonBar)
         {
            this.sortableButtonBar.removeEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.onSortableButtonBarSortDirectionChangedHandler);
            this.sortableButtonBar.dispose();
            this.sortableButtonBar = null;
         }
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.lowerShadow = null;
         this.upperShadow = null;
         this.bg = null;
         super.onDispose();
      }
      
      public function getSelectedItem() : TechniqueListVehicleVO
      {
         return TechniqueListVehicleVO(this.techniqueList.selectedItem);
      }
      
      public function selectVehicleById(param1:int) : void
      {
         this.techniqueList.selectedVehicleById(param1);
      }
      
      public function setSelectedTableColumn(param1:int, param2:String) : void
      {
         if(param1 < 0 || param1 >= this.sortableButtonBar.dataProvider.length)
         {
            param1 = DEFAULT_SORTING_ID;
         }
         this._selectedColumn = param1;
         this._selectedColumnSorting = param2;
         this._isInitialSorting = true;
         this.applyDefaultSorting();
      }
      
      private function applyDefaultSorting() : void
      {
         this.sortableButtonBar.validateNow();
         var _loc1_:SortingButton = this.sortableButtonBar.getButtonAt(this._selectedColumn) as SortingButton;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:int = this.sortableButtonBar.dataProvider.indexOf(_loc1_.data);
         if(_loc2_ == -1)
         {
            invalidate(DEFAULT_SORTING);
            return;
         }
         if(!_loc1_.enabled)
         {
            this._selectedColumn = DEFAULT_SORTING_ID;
         }
         _loc1_.sortDirection = this._selectedColumnSorting;
         this.sortableButtonBar.selectedIndex = this._selectedColumn;
      }
      
      private function getAnimTweenSet() : Object
      {
         return {
            "ease":Strong.easeOut,
            "onComplete":this.onTweenComplete
         };
      }
      
      private function onTweenComplete(param1:Tween) : void
      {
         if(this._tweenManager)
         {
            this._tweenManager.unregister(param1);
         }
      }
      
      public function set headerDataProvider(param1:IDataProvider) : void
      {
         this.sortableButtonBar.dataProvider = param1;
         this.lowerShadow.mouseEnabled = this.upperShadow.mouseEnabled = false;
         this.sortableButtonBar.addEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.onSortableButtonBarSortDirectionChangedHandler,false,0,true);
         this.techniqueList.columnsData = this.sortableButtonBar.dataProvider;
         this.techniqueList.smartScrollBar = true;
         this.sortableButtonBar.updateButtonsEnabledState(true);
      }
      
      public function set vehicles(param1:DataProvider) : void
      {
         this._vehicles = param1;
         this.techniqueList.dataProvider = this._vehicles;
         var _loc2_:String = this.sortableButtonBar.dataProvider.requestItemAt(this._selectedColumn).id;
         this.techniqueList.sortByField(_loc2_,this._selectedColumnSorting == SortingInfo.ASCENDING_SORT,_loc2_ == TechniqueList.ELITE_LEVEL_COLUMN_ID);
         invalidate();
      }
      
      private function onTechniqueListDataInvalidatedHandler(param1:Event) : void
      {
         invalidate(LIST_DATA_INVALIDATED);
      }
      
      private function onTechniqueListSelectedIndexChangeHandler(param1:Event) : void
      {
         dispatchEvent(new Event(SELECTED_INDEX_CHANGED));
      }
      
      private function onSortableButtonBarSortDirectionChangedHandler(param1:SortingEvent) : void
      {
         var _loc2_:SortingButton = null;
         var _loc5_:Boolean = false;
         _loc2_ = SortingButton(param1.target);
         var _loc3_:int = this.sortableButtonBar.dataProvider.indexOf(_loc2_.data);
         var _loc4_:String = _loc2_.id;
         if(_loc3_ != -1 && _loc2_.sortDirection != SortingInfo.WITHOUT_SORT)
         {
            _loc5_ = !isInvalid(DEFAULT_SORTING);
            if(_loc5_)
            {
               this._selectedColumn = _loc3_;
               this._selectedColumnSorting = _loc2_.sortDirection;
            }
            this.techniqueList.sortByField(_loc4_,_loc2_.sortDirection == SortingInfo.ASCENDING_SORT,_loc4_ == TechniqueList.ELITE_LEVEL_COLUMN_ID);
            if(_loc5_)
            {
               if(this._isInitialSorting)
               {
                  this._isInitialSorting = false;
                  this.techniqueList.validateNow();
               }
               dispatchEvent(new TechniqueListComponentEvent(TechniqueListComponentEvent.SELECTED_COLUMN_CHANGE,this._selectedColumn,this._selectedColumnSorting));
            }
         }
      }
   }
}
