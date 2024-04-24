package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SortingInfo;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropDownImageText;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.events.ResizableBlockEvent;
   import net.wg.gui.lobby.profile.pages.technique.ProfileSortingButton;
   import net.wg.gui.lobby.questsWindow.data.QuestVehicleRendererVO;
   import net.wg.gui.lobby.questsWindow.data.VehiclesSortingBlockVO;
   import net.wg.infrastructure.interfaces.ISortable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.utils.Padding;
   
   public class VehiclesSortingBlock extends AbstractResizableContent implements ISortable
   {
      
      private static const FILTERS_PADDING:int = 54;
      
      private static const VEHICLE_RENDERER_HEIGHT:int = 35;
      
      private static const MAX_VEHICLE_RENDERERS:int = 5;
      
      private static const DEFAULT_WIDTH:int = 375;
      
      private static const BOTTOM_PADDING:int = 10;
      
      private static const INV_AVAILABLE_WIDTH:String = "invAvailableWidth";
       
      
      public var sortCheckBox:CheckBox;
      
      public var nationFilter:DropDownImageText;
      
      public var tankFilter:DropDownImageText;
      
      public var levelFilter:DropDownImageText;
      
      public var vehiclesList:ScrollingListEx;
      
      public var buttonBar:SortableHeaderButtonBar;
      
      public var data:VehiclesSortingBlockVO = null;
      
      private var _tableID:String = "";
      
      private var _sortingFunction:Function = null;
      
      public function VehiclesSortingBlock()
      {
         super();
      }
      
      private static function updateSelectedIndex(param1:DropDownImageText, param2:Object) : void
      {
         var _loc3_:int = param1.dataProvider.length;
         param1.selectedIndex = 0;
         var _loc4_:Number = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1.dataProvider[_loc4_].data == param2)
            {
               param1.selectedIndex = _loc4_;
               return;
            }
            _loc4_++;
         }
      }
      
      private static function setupDataProvider(param1:Array) : IDataProvider
      {
         var _loc3_:Object = null;
         var _loc2_:DataProvider = new DataProvider();
         for each(_loc3_ in param1)
         {
            _loc2_.push(new QuestVehicleRendererVO(_loc3_));
         }
         return _loc2_;
      }
      
      override public function setData(param1:Object) : void
      {
         if(this.data)
         {
            this.data.dispose();
         }
         this.data = new VehiclesSortingBlockVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.sortCheckBox.label = QUESTS.QUESTS_TABLE_INHANGAR;
         this.vehiclesList.sbPadding = new Padding(5,4,5,1);
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this.sortCheckBox.dispose();
         this.sortCheckBox = null;
         this.nationFilter.dispose();
         this.nationFilter = null;
         this.tankFilter.dispose();
         this.tankFilter = null;
         this.levelFilter.dispose();
         this.levelFilter = null;
         this.vehiclesList.dispose();
         this.vehiclesList = null;
         this.buttonBar.dispose();
         this.buttonBar = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         this._sortingFunction = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         var _loc5_:ProfileSortingButton = null;
         if(isInvalid(InvalidationType.DATA) && this.data)
         {
            this.buttonBar.dataProvider = this.data.tableHeader;
            if(this.data.hasHeader)
            {
               this.nationFilter.visible = this.tankFilter.visible = this.levelFilter.visible = true;
               this.buttonBar.y = FILTERS_PADDING;
            }
            else
            {
               this.nationFilter.visible = this.tankFilter.visible = this.levelFilter.visible = false;
               this.buttonBar.y = this.nationFilter.y;
            }
            this.nationFilter.dataProvider = new DataProvider(this.data.nationFilterData);
            this.tankFilter.dataProvider = new DataProvider(this.data.tankFilterData);
            this.levelFilter.dataProvider = new DataProvider(this.data.levelFilterData);
            updateSelectedIndex(this.nationFilter,this.data.selectedNation);
            updateSelectedIndex(this.tankFilter,this.data.selectedVehType);
            updateSelectedIndex(this.levelFilter,this.data.selectedLvl);
            _loc1_ = this.buttonBar.renderersCount;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc5_ = this.buttonBar.getButtonAt(_loc2_) as ProfileSortingButton;
               App.utils.asserter.assertNotNull(_loc5_,"button" + Errors.CANT_NULL);
               if(_loc5_.id == this.data.selectedBtnID)
               {
                  this.buttonBar.selectedIndex = _loc2_;
                  _loc5_.sortDirection = this.data.sortDirection;
               }
               _loc2_++;
            }
            this._tableID = this.data.tableID;
            if(this.data.showNotInHangarCB)
            {
               this.sortCheckBox.label = QUESTS.QUESTS_TABLE_NOTINHANGAR;
            }
            this.sortCheckBox.visible = this.data.hasHeader && (this.data.showInHangarCB || this.data.showNotInHangarCB);
            this.sortCheckBox.selected = this.data.cbSelected;
            this.vehiclesList.y = this.buttonBar.y + this.buttonBar.height;
            _loc3_ = this._sortingFunction(this.getSortingObject());
            _loc1_ = _loc3_.length > 0 ? int(_loc3_.length) : int(1);
            this.vehiclesList.height = VEHICLE_RENDERER_HEIGHT * Math.min(MAX_VEHICLE_RENDERERS,_loc1_);
            this.vehiclesList.dataProvider = setupDataProvider(_loc3_);
            this.isReadyForLayout = true;
            _loc4_ = Math.round(this.vehiclesList.y + this.vehiclesList.height);
            setSize(this.width,_loc4_ + BOTTOM_PADDING);
         }
         if(isInvalid(INV_AVAILABLE_WIDTH))
         {
            this.x = availableWidth - DEFAULT_WIDTH;
         }
      }
      
      private function addListeners() : void
      {
         this.nationFilter.addEventListener(ListEvent.INDEX_CHANGE,this.onUpdateSortedDataHandler);
         this.tankFilter.addEventListener(ListEvent.INDEX_CHANGE,this.onUpdateSortedDataHandler);
         this.levelFilter.addEventListener(ListEvent.INDEX_CHANGE,this.onUpdateSortedDataHandler);
         this.sortCheckBox.addEventListener(Event.SELECT,this.onUpdateSortedDataHandler);
         this.buttonBar.addEventListener(ButtonEvent.CLICK,this.onUpdateSortedDataHandler);
      }
      
      private function removeListeners() : void
      {
         this.nationFilter.removeEventListener(ListEvent.INDEX_CHANGE,this.onUpdateSortedDataHandler);
         this.tankFilter.removeEventListener(ListEvent.INDEX_CHANGE,this.onUpdateSortedDataHandler);
         this.levelFilter.removeEventListener(ListEvent.INDEX_CHANGE,this.onUpdateSortedDataHandler);
         this.sortCheckBox.removeEventListener(Event.SELECT,this.onUpdateSortedDataHandler);
         this.buttonBar.removeEventListener(ButtonEvent.CLICK,this.onUpdateSortedDataHandler);
      }
      
      private function getSortingObject() : Object
      {
         var _loc1_:Number = this.nationFilter.dataProvider[this.nationFilter.selectedIndex].data;
         var _loc2_:String = String(this.tankFilter.dataProvider[this.tankFilter.selectedIndex].data);
         var _loc3_:Number = this.levelFilter.dataProvider[this.levelFilter.selectedIndex].data;
         var _loc4_:Boolean = this.sortCheckBox.selected;
         var _loc5_:ProfileSortingButton = this.buttonBar.getButtonAt(this.buttonBar.selectedIndex) as ProfileSortingButton;
         var _loc6_:String = Boolean(_loc5_) ? _loc5_.sortDirection : SortingInfo.WITHOUT_SORT;
         var _loc7_:String = Boolean(_loc5_) ? _loc5_.id : "";
         return {
            "nation":_loc1_,
            "vehType":_loc2_,
            "level":_loc3_,
            "cbSelected":_loc4_,
            "sortingDirection":_loc6_,
            "buttonID":_loc7_,
            "isAction":this.data.showNotInHangarCB,
            "tableID":this._tableID
         };
      }
      
      private function setSortedData(param1:Array) : void
      {
         var _loc2_:int = param1.length > 0 ? int(param1.length) : int(1);
         var _loc3_:Number = VEHICLE_RENDERER_HEIGHT * Math.min(MAX_VEHICLE_RENDERERS,_loc2_);
         this.vehiclesList.dataProvider = setupDataProvider(param1);
         this.vehiclesList.height = _loc3_;
         this.setSize(this.width,this.vehiclesList.y + this.vehiclesList.height + BOTTOM_PADDING);
         dispatchEvent(new ResizableBlockEvent(ResizableBlockEvent.CONTETNT_WAS_CHANGED,true));
      }
      
      override public function set availableWidth(param1:Number) : void
      {
         super.availableWidth = param1;
         invalidate(INV_AVAILABLE_WIDTH);
      }
      
      override public function set isReadyForLayout(param1:Boolean) : void
      {
         super.isReadyForLayout = param1;
         if(param1)
         {
            this.addListeners();
         }
         else
         {
            this.removeListeners();
         }
      }
      
      public function get sortingFunction() : Function
      {
         return this._sortingFunction;
      }
      
      public function set sortingFunction(param1:Function) : void
      {
         this._sortingFunction = param1;
      }
      
      private function onUpdateSortedDataHandler(param1:Event) : void
      {
         var _loc2_:Object = this.getSortingObject();
         var _loc3_:Array = this._sortingFunction(_loc2_);
         this.setSortedData(_loc3_);
      }
   }
}
