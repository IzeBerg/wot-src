package net.wg.gui.lobby.vehicleInfo
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.TankIcon;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoButtonDataVO;
   import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoDataVO;
   import net.wg.infrastructure.base.meta.IVehicleInfoMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleInfoMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class VehicleInfo extends VehicleInfoMeta implements IVehicleInfoMeta
   {
      
      private static const VEHICLE_INFO_PROPS:String = "VehicleInfoPropsUI";
      
      private static const VEHICLE_INFO_BASE:String = "VehicleInfoBaseUI";
      
      private static const VEHICLE_INFO_CREW:String = "VehicleInfoCrewUI";
      
      private static const VEHICLE_INFO_ABILITY:String = "VehicleInfoAbilityUI";
      
      private static const INV_COMPARE_DATA:String = "InvCompareData";
      
      private static const INV_CHANGE_NATION_DATA:String = "InvChangeNationData";
      
      private static const COUNTER_PROPS:CounterProps = new CounterProps(3,-3);
      
      private static const DESCRIPTION_MAX_HEIGHT:int = 82;
       
      
      public var vehicleIcon:TankIcon;
      
      public var moduleName:TextField;
      
      public var descriptionField:TextAreaSimple;
      
      public var tabs:ButtonBarEx;
      
      public var view:ViewStack;
      
      public var changeNationBtn:ISoundButtonEx;
      
      public var compareBtn:ISoundButtonEx;
      
      public var closeBtn:ISoundButtonEx;
      
      public var tankRoleTF:TextField;
      
      private var _compareData:VehicleInfoButtonDataVO;
      
      private var _changeNationData:VehicleInfoButtonDataVO;
      
      private var _data:VehicleInfoDataVO;
      
      private var _counterManager:ICounterManager;
      
      private var _closeBtnOffset:Number;
      
      public function VehicleInfo()
      {
         super();
         showWindowBgForm = false;
         this._counterManager = App.utils.counterManager;
      }
      
      private static function initButton(param1:ISoundButtonEx, param2:VehicleInfoButtonDataVO) : void
      {
         param1.visible = param2.visible;
         if(param2.visible)
         {
            param1.enabled = param2.enabled;
            param1.label = param2.label;
            param1.tooltip = param2.tooltip;
         }
      }
      
      override protected function setCompareButtonData(param1:VehicleInfoButtonDataVO) : void
      {
         this._compareData = param1;
         invalidate(INV_COMPARE_DATA);
      }
      
      override protected function setChangeNationButtonData(param1:VehicleInfoButtonDataVO) : void
      {
         this._changeNationData = param1;
         invalidate(INV_CHANGE_NATION_DATA);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
         this.compareBtn.mouseEnabledOnDisabled = true;
         this.compareBtn.addEventListener(ButtonEvent.CLICK,this.onCompareBtnClickHandler);
         this.changeNationBtn.mouseEnabledOnDisabled = true;
         this.changeNationBtn.addEventListener(ButtonEvent.CLICK,this.onChangeNationBtnClickHandler);
         this.closeBtn.label = MENU.MODULEINFO_CLOSEBTN;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this._closeBtnOffset = this.compareBtn.x - this.changeNationBtn.x - this.changeNationBtn.width;
      }
      
      override protected function draw() : void
      {
         var _loc1_:DataProvider = null;
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = new DataProvider([{
               "label":MENU.VEHICLEINFO_TABS_PROPERTIES,
               "linkage":VEHICLE_INFO_PROPS,
               "viewId":VEHICLE_INFO_PROPS
            },{
               "label":MENU.VEHICLEINFO_TABS_BASE,
               "linkage":VEHICLE_INFO_BASE,
               "viewId":VEHICLE_INFO_BASE
            },{
               "label":MENU.VEHICLEINFO_TABS_CREW,
               "linkage":VEHICLE_INFO_CREW,
               "viewId":VEHICLE_INFO_CREW
            }]);
            if(this._data.abilityData)
            {
               _loc1_.push({
                  "label":MENU.VEHICLEINFO_TABS_ABILITY,
                  "linkage":VEHICLE_INFO_ABILITY,
                  "viewId":VEHICLE_INFO_ABILITY
               });
            }
            this.tabs.dataProvider = _loc1_;
            _loc2_ = this._data.roleStr != Values.EMPTY_STR;
            _loc3_ = this._data.vehicleName;
            this.window.title = _loc3_;
            this.moduleName.htmlText = _loc3_;
            this.descriptionField.text = this._data.vehicleDescription;
            if(!_loc2_)
            {
               this.descriptionField.y = this.tankRoleTF.y;
               this.descriptionField.height = DESCRIPTION_MAX_HEIGHT;
            }
            else
            {
               this.tankRoleTF.htmlText = this._data.roleStr;
            }
            this.tankRoleTF.visible = _loc2_;
            this.vehicleIcon.image = this._data.vehicleImage;
            this.vehicleIcon.level = this._data.vehicleLevel;
            this.vehicleIcon.nation = this._data.vehicleNation;
            this.vehicleIcon.isElite = this._data.vehicleElite;
            this.vehicleIcon.tankType = this._data.vehicleType;
            this.tabs.selectedIndex = 0;
         }
         if(this._changeNationData && isInvalid(INV_CHANGE_NATION_DATA))
         {
            initButton(this.changeNationBtn,this._changeNationData);
            if(this._changeNationData.visible)
            {
               if(this._changeNationData.isNew)
               {
                  this._counterManager.setCounter(this.changeNationBtn as DisplayObject,CounterManager.EXCLAMATION_COUNTER_VALUE,null,COUNTER_PROPS);
               }
               this.compareBtn.x = this.changeNationBtn.x + this.changeNationBtn.width + this._closeBtnOffset;
            }
            else
            {
               this._counterManager.removeCounter(this.changeNationBtn as DisplayObject);
               this.compareBtn.x = this.changeNationBtn.x;
            }
         }
         if(this._compareData && isInvalid(INV_COMPARE_DATA))
         {
            initButton(this.compareBtn,this._compareData);
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         getVehicleInfoS();
         var _loc1_:Padding = new Padding(window.formBgPadding.top,window.formBgPadding.right,window.formBgPadding.bottom + 1,window.formBgPadding.left);
         window.contentPadding = _loc1_;
         window.titleUseHtml = true;
      }
      
      override protected function onDispose() : void
      {
         this.view.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
         this.view.dispose();
         this.view = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.compareBtn.removeEventListener(ButtonEvent.CLICK,this.onCompareBtnClickHandler);
         this.compareBtn.dispose();
         this.compareBtn = null;
         this._counterManager.removeCounter(this.changeNationBtn as DisplayObject);
         this.changeNationBtn.removeEventListener(ButtonEvent.CLICK,this.onChangeNationBtnClickHandler);
         this.changeNationBtn.dispose();
         this.changeNationBtn = null;
         this.tabs.dispose();
         this.tabs = null;
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this.descriptionField.dispose();
         this.descriptionField = null;
         this.tankRoleTF = null;
         this.moduleName = null;
         this._compareData = null;
         this._data = null;
         this._counterManager = null;
         this._changeNationData = null;
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(InteractiveObject(this.closeBtn));
      }
      
      override protected function setVehicleInfo(param1:VehicleInfoDataVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onCompareBtnClickHandler(param1:ButtonEvent) : void
      {
         addToCompareS();
      }
      
      private function onViewNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:IViewStackContent = param1.view;
         var _loc3_:String = param1.viewId;
         if(VEHICLE_INFO_PROPS == _loc3_)
         {
            _loc2_.update(this._data.propsData);
         }
         else if(VEHICLE_INFO_CREW == _loc3_)
         {
            _loc2_.update(this._data.crewData);
         }
         else if(VEHICLE_INFO_BASE == _loc3_)
         {
            _loc2_.update(this._data.baseData);
         }
         else if(VEHICLE_INFO_ABILITY == _loc3_)
         {
            _loc2_.update(this._data.abilityData);
         }
         else
         {
            App.utils.asserter.assert(false,Errors.BAD_LINKAGE + _loc3_);
         }
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         onCancelClickS();
      }
      
      private function onChangeNationBtnClickHandler(param1:ButtonEvent) : void
      {
         changeNationS();
      }
   }
}
