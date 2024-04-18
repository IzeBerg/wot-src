package net.wg.gui.lobby.barracks
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.RolesState;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.data.constants.generated.BARRACKS_CONSTANTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.controls.CloseButton;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.events.CrewEvent;
   import net.wg.gui.lobby.barracks.data.BarracksTankmanVO;
   import net.wg.gui.lobby.barracks.data.BarracksTankmenVO;
   import net.wg.gui.lobby.barracks.data.TankmenDataProvider;
   import net.wg.gui.lobby.components.InfoMessageComponent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.exceptions.TypeCastException;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.controls.ButtonBar;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ListEvent;
   
   public class BarracksForm extends UIComponentEx
   {
      
      private static const INVALIDATE_TANKMEN_FILTER:String = "TankmenFilter";
      
      private static const DEFAULT_LOCATION:int = 3;
      
      private static const RADIO_BUTTON_COUNTER_PROPS:CounterProps = new CounterProps(0,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
      
      private static const DOT_COUNTER_PROPS:CounterProps = new CounterProps(8,3);
      
      private static const INV_COUNTERS:String = "invCounterData";
      
      private static const COUNTERS_CONTAINER_NAME:String = "countersContainer";
       
      
      public var tankmenCountTF:TextField = null;
      
      public var placesCountTF:TextField = null;
      
      public var roleTF:TextField = null;
      
      public var tankTypeTF:TextField = null;
      
      public var locationTF:TextField = null;
      
      public var nationTF:TextField = null;
      
      public var titleBtn:TextFieldShort = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var tankmenTileList:TileList = null;
      
      public var noTankmenCmp:InfoMessageComponent;
      
      public var tank:DropdownMenu = null;
      
      public var nationDDM:DropdownMenu = null;
      
      public var roleButtonBar:ButtonBarEx = null;
      
      public var tankTypeButtonBar:ButtonBarEx = null;
      
      public var locationButtonBar:ButtonBarEx = null;
      
      public var closeButton:CloseButton = null;
      
      private var _nation:Number = 0;
      
      private var _role:String = "";
      
      private var _tankType:String = "";
      
      private var _location:String = "";
      
      private var _nationID:String = "";
      
      private var _tankmenData:BarracksTankmenVO = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _programmaticUpdate:Boolean = false;
      
      private var _tankSelectedIndex:int = 0;
      
      private var _counterMgr:ICounterManager = null;
      
      private var _countersData:Vector.<CountersVo> = null;
      
      private var _visitedCounters:Array;
      
      private var _dataProvider:TankmenDataProvider = null;
      
      public function BarracksForm()
      {
         this._visitedCounters = [];
         super();
         this._toolTipMgr = App.toolTipMgr;
         this._counterMgr = App.utils.counterManager;
         this._dataProvider = new TankmenDataProvider();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tank.addEventListener(ListEvent.INDEX_CHANGE,this.onTankIndexChangeHandler);
         this.roleTF.text = MENU.BARRACKS_MENU_ROLEFILTER_TEXTFIELD;
         this.roleButtonBar.dataProvider = new DataProvider([{
            "label":MENU.BARRACKS_MENU_ROLEFILTER_ALL,
            "data":RolesState.ALL
         },{
            "label":MENU.BARRACKS_MENU_ROLEFILTER_COMMANDER,
            "data":RolesState.COMANDER
         },{
            "label":MENU.BARRACKS_MENU_ROLEFILTER_GUNNER,
            "data":RolesState.GUNNER
         },{
            "label":MENU.BARRACKS_MENU_ROLEFILTER_DRIVER,
            "data":RolesState.DRIVER
         },{
            "label":MENU.BARRACKS_MENU_ROLEFILTER_RADIOMAN,
            "data":RolesState.RADIOMAN
         },{
            "label":MENU.BARRACKS_MENU_ROLEFILTER_LOADER,
            "data":RolesState.LOADER
         }]);
         this.tankTypeTF.text = MENU.BARRACKS_MENU_TANKTYPEFILTER_TEXTFIELD;
         this.tankTypeButtonBar.dataProvider = new DataProvider([{
            "label":MENU.CLASSES_ANYTYPE,
            "data":VehicleTypes.ALL
         },{
            "label":MENU.CLASSES_LIGHTTANK,
            "data":VehicleTypes.LIGHT_TANK
         },{
            "label":MENU.CLASSES_MEDIUMTANK,
            "data":VehicleTypes.MEDIUM_TANK
         },{
            "label":MENU.CLASSES_HEAVYTANK,
            "data":VehicleTypes.HEAVY_TANK
         },{
            "label":MENU.CLASSES_AT_SPG,
            "data":VehicleTypes.AT_SPG
         },{
            "label":MENU.CLASSES_SPG,
            "data":VehicleTypes.SPG
         }]);
         this.locationTF.text = MENU.BARRACKS_MENU_LOCATIONFILTER_TEXTFIELD;
         this.locationButtonBar.dataProvider = new DataProvider([{
            "label":Values.EMPTY_STR,
            "data":Values.EMPTY_STR
         },{
            "label":MENU.BARRACKS_MENU_LOCATIONFILTER_TANKS,
            "data":BARRACKS_CONSTANTS.LOCATION_FILTER_TANKS
         },{
            "label":MENU.BARRACKS_MENU_LOCATIONFILTER_BARRACKS,
            "data":BARRACKS_CONSTANTS.LOCATION_FILTER_BARRACKS
         },{
            "label":MENU.BARRACKS_MENU_LOCATIONFILTER_BARRACKSANDTANKS,
            "data":BARRACKS_CONSTANTS.LOCATION_FILTER_BARRACKS_AND_TANKS
         },{
            "label":MENU.BARRACKS_MENU_LOCATIONFILTER_DISMISSED,
            "data":BARRACKS_CONSTANTS.LOCATION_FILTER_DISMISSED
         },{
            "label":MENU.BARRACKS_MENU_LOCATIONFILTER_NOTRECRUITED,
            "data":BARRACKS_CONSTANTS.LOCATION_FILTER_NOT_RECRUITED
         }]);
         this._dataProvider.addEventListener(Event.CHANGE,this.onTankmanDataChangeHandler);
         this.tankmenTileList.dataProvider = this._dataProvider;
         this.tankmenTileList.addEventListener(ListEvent.ITEM_ROLL_OVER,this.onTankmenTileListItemRollOverHandler);
         this.tankmenTileList.addEventListener(ListEvent.ITEM_ROLL_OUT,this.onTankmenTileListItemRollOutHandler);
         this.tankmenTileList.addEventListener(ListEvent.ITEM_PRESS,this.onTankmenTileListItemPressHandler);
         this.roleButtonBar.addEventListener(Event.COMPLETE,this.onRoleButtonBarCompleteHandler);
         this.tankTypeButtonBar.addEventListener(Event.COMPLETE,this.onTankTypeButtonBarCompleteHandler);
         this.locationButtonBar.addEventListener(Event.COMPLETE,this.onLocationButtonBarCompleteHandler);
      }
      
      override protected function onDispose() : void
      {
         this.hideTooltip();
         this.tankmenTileList.removeEventListener(ListEvent.ITEM_ROLL_OVER,this.onTankmenTileListItemRollOverHandler);
         this.tankmenTileList.removeEventListener(ListEvent.ITEM_ROLL_OUT,this.onTankmenTileListItemRollOutHandler);
         this.tankmenTileList.removeEventListener(ListEvent.ITEM_PRESS,this.onTankmenTileListItemPressHandler);
         this.roleButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onRoleButtonBarIndexChangeHandler);
         this.tankTypeButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTankTypeButtonBarIndexChangeHandler);
         this.tank.removeEventListener(ListEvent.INDEX_CHANGE,this.onTankIndexChangeHandler);
         this.locationButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onLocationButtonBarIndexChangeHandler);
         this.nationDDM.removeEventListener(ListEvent.INDEX_CHANGE,this.onNationDDMIndexChangeHandler);
         this.roleButtonBar.removeEventListener(Event.COMPLETE,this.onRoleButtonBarCompleteHandler);
         this.tankTypeButtonBar.removeEventListener(Event.COMPLETE,this.onTankTypeButtonBarCompleteHandler);
         this.locationButtonBar.removeEventListener(Event.COMPLETE,this.onLocationButtonBarCompleteHandler);
         this.removePlacesCountTfListeners();
         this.roleButtonBar.dispose();
         this.tankTypeButtonBar.dispose();
         this.locationButtonBar.dispose();
         this.tankmenTileList.dispose();
         this.nationDDM.dispose();
         this.tank.dispose();
         this.scrollBar.dispose();
         this.titleBtn.dispose();
         this.closeButton.dispose();
         this.noTankmenCmp.dispose();
         this._dataProvider.removeEventListener(Event.CHANGE,this.onTankmanDataChangeHandler);
         this._dataProvider = null;
         this.scrollBar = null;
         this.titleBtn = null;
         this.tankmenTileList = null;
         this.tank = null;
         this.nationDDM = null;
         this.roleButtonBar = null;
         this.tankTypeButtonBar = null;
         this.locationButtonBar = null;
         this.closeButton = null;
         this.noTankmenCmp = null;
         this.roleTF = null;
         this.tankTypeTF = null;
         this.locationTF = null;
         this.nationTF = null;
         this.tankmenCountTF = null;
         this.placesCountTF = null;
         this._nation = 0;
         this._role = null;
         this._tankType = null;
         this._location = null;
         this._nationID = null;
         this._tankmenData = null;
         this._toolTipMgr = null;
         if(this._countersData)
         {
            this._countersData.splice(0,this._countersData.length);
            this._countersData = null;
         }
         this._visitedCounters.splice(0,this._visitedCounters.length);
         this._visitedCounters = null;
         this._counterMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:DisplayObject = null;
         var _loc7_:ButtonBarEx = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:CountersVo = null;
         super.draw();
         if(isInvalid(INVALIDATE_TANKMEN_FILTER))
         {
            this.updateSelectedIndex(this.nationDDM,this._nation);
            this.updateSelectedIndex(this.roleButtonBar,this._role);
            this.updateSelectedIndex(this.tankTypeButtonBar,this._tankType);
            this.onInvalidateTanksList();
            if(this._nationID)
            {
               this.locationButtonBar.selectedIndex = 0;
               _loc1_ = 0;
               _loc2_ = this.tank.dataProvider.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  if(this.tank.dataProvider[_loc3_].data.typeID == this._location && this.tank.dataProvider[_loc3_].data.nationID == this._nationID)
                  {
                     _loc1_ = _loc3_;
                     break;
                  }
                  _loc3_++;
               }
               this.tank.selectedIndex = _loc1_;
            }
            else
            {
               _loc1_ = DEFAULT_LOCATION;
               _loc4_ = this.locationButtonBar.dataProvider.length;
               _loc5_ = 1;
               while(_loc5_ < _loc4_)
               {
                  if(this.locationButtonBar.dataProvider[_loc5_].data == this._location)
                  {
                     _loc1_ = _loc5_;
                     break;
                  }
                  _loc5_++;
               }
               this.locationButtonBar.selectedIndex = _loc1_;
            }
            if(!this.roleButtonBar.hasEventListener(IndexEvent.INDEX_CHANGE))
            {
               this.roleButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onRoleButtonBarIndexChangeHandler);
            }
            if(!this.tankTypeButtonBar.hasEventListener(IndexEvent.INDEX_CHANGE))
            {
               this.tankTypeButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onTankTypeButtonBarIndexChangeHandler);
            }
            if(!this.tank.hasEventListener(IndexEvent.INDEX_CHANGE))
            {
               this.locationButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onLocationButtonBarIndexChangeHandler);
            }
            if(!this.nationDDM.hasEventListener(ListEvent.INDEX_CHANGE))
            {
               this.nationDDM.addEventListener(ListEvent.INDEX_CHANGE,this.onNationDDMIndexChangeHandler);
            }
            this.checkFilters();
            isInvalid(INV_COUNTERS);
         }
         if(isInvalid(INV_COUNTERS) && this._countersData)
         {
            for each(_loc9_ in this._countersData)
            {
               _loc6_ = getChildByName(_loc9_.componentId);
               if(_loc6_)
               {
                  _loc7_ = _loc6_ as ButtonBarEx;
                  if(_loc7_)
                  {
                     _loc8_ = _loc7_.getButtonAt(_loc9_.selectedIdx);
                     if(_loc8_)
                     {
                        this._counterMgr.setCounter(_loc8_,_loc9_.count,null,RADIO_BUTTON_COUNTER_PROPS);
                        this._counterMgr.setCounter(_loc8_,_loc9_.count,COUNTERS_CONTAINER_NAME,DOT_COUNTER_PROPS);
                     }
                  }
                  else
                  {
                     this._counterMgr.setCounter(_loc6_,_loc9_.count);
                  }
               }
            }
         }
      }
      
      public function getVisitedCounters() : Array
      {
         var _loc2_:CountersVo = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._visitedCounters)
         {
            _loc1_.push(_loc2_);
         }
         this._visitedCounters.splice(0,this._visitedCounters.length);
         return _loc1_;
      }
      
      public function onPopulate() : void
      {
         this.nationDDM.dataProvider = new DataProvider([{
            "label":MENU.NATIONS_ALL,
            "data":-1
         }].concat(App.utils.nations.getNationsData()));
      }
      
      public function setCountersData(param1:Vector.<CountersVo>) : void
      {
         this._countersData = param1;
         invalidate(INV_COUNTERS);
      }
      
      public function setTankmen(param1:BarracksTankmenVO) : void
      {
         this._tankmenData = param1;
         this.tankmenCountTF.htmlText = param1.tankmenCount;
         if(this.tankmenTileList.dataProvider != null)
         {
            this.tankmenTileList.dataProvider.cleanUp();
         }
         this.placesCountTF.htmlText = param1.placesCount;
         if(StringUtils.isNotEmpty(this._tankmenData.placesCountTooltip))
         {
            this.placesCountTF.addEventListener(MouseEvent.ROLL_OVER,this.onPlacesCountTfRollOverHandler);
            this.placesCountTF.addEventListener(MouseEvent.ROLL_OUT,this.onPlacesCountTfRollOutHandler);
         }
         else
         {
            this.removePlacesCountTfListeners();
         }
         this.noTankmenCmp.visible = param1.hasNoInfoData;
         if(param1.hasNoInfoData)
         {
            this.noTankmenCmp.setData(param1.noInfoData);
            this.noTankmenCmp.x = this.tankmenTileList.x + (this.tankmenTileList.width - this.noTankmenCmp.width >> 1) | 0;
            this.noTankmenCmp.y = this.tankmenTileList.y + (this.tankmenTileList.height - this.noTankmenCmp.height >> 1) | 0;
         }
      }
      
      public function setTankmenFilter(param1:Number, param2:String, param3:String, param4:String, param5:String) : void
      {
         this._nation = param1;
         this._role = param2;
         this._tankType = param3;
         this._location = param4;
         this._nationID = param5;
         invalidate(INVALIDATE_TANKMEN_FILTER);
      }
      
      public function switchFilterEnable(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         this.roleButtonBar.enabled = param2;
         this.nationDDM.enabled = param1;
         this.tankTypeButtonBar.enabled = param3;
      }
      
      public function updateTanksList(param1:DataProvider) : void
      {
         this._programmaticUpdate = true;
         this.tank.dataProvider = param1;
         if(param1.length > 0)
         {
            this.tank.selectedIndex = 0;
            this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
         }
         else
         {
            this.tank.selectedIndex = -1;
            this.locationButtonBar.dataProvider[0].data = Values.EMPTY_STR;
         }
         this.tank.validateNow();
         this.tank.enabled = param1.length > 0;
         this._tankSelectedIndex = this.tank.selectedIndex;
         this._programmaticUpdate = false;
      }
      
      private function updateSelectedIndex(param1:Object, param2:Object) : void
      {
         var _loc5_:Boolean = false;
         if(App.instance)
         {
            _loc5_ = param1 is ButtonBar || param1 is DropdownMenu;
            App.utils.asserter.assert(_loc5_,"object in ... must be ButtonBar or DropdownMenu",TypeCastException);
         }
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
      
      private function checkFilters() : void
      {
         var _loc1_:Number = this.nationDDM.dataProvider[this.nationDDM.selectedIndex].data;
         var _loc2_:String = this.roleButtonBar.dataProvider[this.roleButtonBar.selectedIndex].data;
         var _loc3_:String = this.tankTypeButtonBar.dataProvider[this.tankTypeButtonBar.selectedIndex].data;
         var _loc4_:Object = this.locationButtonBar.dataProvider[this.locationButtonBar.selectedIndex].data;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(_loc4_ is String || _loc4_ == null)
         {
            _loc6_ = _loc4_.toString();
         }
         else
         {
            _loc6_ = _loc4_.typeID;
            _loc5_ = _loc4_.nationID;
         }
         var _loc7_:Object = {
            "nation":_loc1_,
            "role":_loc2_,
            "tankType":_loc3_,
            "location":_loc6_,
            "nationID":_loc5_
         };
         dispatchEvent(new CrewEvent(CrewEvent.ON_CHANGE_BARRACKS_FILTER,_loc7_));
      }
      
      private function onInvalidateTanksList() : void
      {
         dispatchEvent(new CrewEvent(CrewEvent.ON_INVALID_TANK_LIST));
      }
      
      private function removePlacesCountTfListeners() : void
      {
         this.placesCountTF.removeEventListener(MouseEvent.ROLL_OVER,this.onPlacesCountTfRollOverHandler);
         this.placesCountTF.removeEventListener(MouseEvent.ROLL_OUT,this.onPlacesCountTfRollOutHandler);
      }
      
      private function deepCheckFilters() : void
      {
         this.checkFilters();
         this.onInvalidateTanksList();
         this.checkFilters();
      }
      
      private function hideTooltip() : void
      {
         this._toolTipMgr.hide();
      }
      
      private function markVisitedCounters(param1:String) : void
      {
         var _loc3_:ButtonBarEx = null;
         var _loc4_:Boolean = false;
         var _loc5_:CountersVo = null;
         if(StringUtils.isEmpty(param1))
         {
            return;
         }
         var _loc2_:DisplayObject = getChildByName(param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_ as ButtonBarEx;
            _loc4_ = _loc3_ != null;
            for each(_loc5_ in this._countersData)
            {
               if(_loc4_ && _loc3_.selectedIndex == _loc5_.selectedIdx)
               {
                  this._visitedCounters.push(_loc5_);
                  break;
               }
               if(!_loc4_ && _loc5_.componentId == param1)
               {
                  this._visitedCounters.push(_loc5_);
                  break;
               }
            }
         }
      }
      
      private function onButtonBarReady() : void
      {
         invalidate(INV_COUNTERS);
      }
      
      public function get dataProvider() : DAAPIDataProvider
      {
         return this._dataProvider;
      }
      
      private function onTankmanDataChangeHandler(param1:Event) : void
      {
         this.tankmenTileList.selectedIndex = -1;
         this.tankmenTileList.invalidateData();
      }
      
      private function onLocationButtonBarCompleteHandler(param1:Event) : void
      {
         this.onButtonBarReady();
      }
      
      private function onTankTypeButtonBarCompleteHandler(param1:Event) : void
      {
         this.onButtonBarReady();
      }
      
      private function onRoleButtonBarCompleteHandler(param1:Event) : void
      {
         this.onButtonBarReady();
      }
      
      private function onRoleButtonBarIndexChangeHandler(param1:Event) : void
      {
         this.markVisitedCounters(this.roleButtonBar.name);
         this.checkFilters();
      }
      
      private function onLocationButtonBarIndexChangeHandler(param1:Event) : void
      {
         this.markVisitedCounters(this.locationButtonBar.name);
         this.checkFilters();
      }
      
      private function onTankTypeButtonBarIndexChangeHandler(param1:Event) : void
      {
         this.markVisitedCounters(this.tankTypeButtonBar.name);
         this.deepCheckFilters();
      }
      
      private function onNationDDMIndexChangeHandler(param1:Event) : void
      {
         this.markVisitedCounters(this.nationDDM.name);
         this.deepCheckFilters();
      }
      
      private function onTankIndexChangeHandler(param1:Event) : void
      {
         if(!this._programmaticUpdate)
         {
            if(this.locationButtonBar.selectedIndex == 0)
            {
               if(this.tank.selectedIndex < 0)
               {
                  this.locationButtonBar.selectedIndex = this.locationButtonBar.dataProvider.length - 1;
               }
            }
            else if(this.tank.selectedIndex >= 0 && this._tankSelectedIndex >= 0)
            {
               this.locationButtonBar.selectedIndex = 0;
            }
            if(this.tank.dataProvider.length > 0)
            {
               this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
            }
            else
            {
               this.locationButtonBar.dataProvider[0].data = Values.EMPTY_STR;
            }
            this.checkFilters();
         }
      }
      
      private function onTankmenTileListItemRollOverHandler(param1:ListEvent) : void
      {
         var _loc3_:String = null;
         this.hideTooltip();
         var _loc2_:BarracksTankmanVO = BarracksTankmanVO(param1.itemData);
         if(_loc2_.empty)
         {
            this._toolTipMgr.showComplex(TOOLTIPS.BARRACKS_ITEM_EMPTY);
         }
         else if(_loc2_.buy)
         {
            this._toolTipMgr.showComplex(TOOLTIPS.BARRACKS_ITEM_BUY);
         }
         else
         {
            _loc3_ = !!_loc2_.notRecruited ? TOOLTIPS_CONSTANTS.TANKMAN_NOT_RECRUITED : TOOLTIPS_CONSTANTS.TANKMAN;
            this._toolTipMgr.showSpecial(_loc3_,null,!!_loc2_.notRecruited ? _loc2_.recruitID : _loc2_.tankmanID,false);
         }
      }
      
      private function onTankmenTileListItemRollOutHandler(param1:ListEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onTankmenTileListItemPressHandler(param1:ListEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onPlacesCountTfRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._tankmenData.placesCountTooltip);
      }
      
      private function onPlacesCountTfRollOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
   }
}
