package net.wg.gui.lobby.recruitWindow
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import net.wg.data.constants.IconsTypes;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TankmanTrainingButton;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.lobby.hangar.crew.TankmanVO;
   import net.wg.infrastructure.base.meta.IRecruitWindowMeta;
   import net.wg.infrastructure.base.meta.impl.RecruitWindowMeta;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.utils.Constraints;
   
   public class RecruitWindow extends RecruitWindowMeta implements IRecruitWindowMeta
   {
      
      public static const GROUP_NAME:String = "recruitTypeGroup";
       
      
      public var nationDropdown:DropdownMenu = null;
      
      public var roleDropdown:DropdownMenu = null;
      
      public var vehicleClassDropdown:DropdownMenu = null;
      
      public var vehicleTypeDropdown:DropdownMenu = null;
      
      public var btnRecruit:SoundButtonEx = null;
      
      public var btnCancel:SoundButtonEx = null;
      
      public var btnAcademy:TankmanTrainingButton = null;
      
      public var btnScool:TankmanTrainingButton = null;
      
      public var btnCourses:TankmanTrainingButton = null;
      
      protected var btnGroup:ButtonGroup = null;
      
      private var _data:Object = null;
      
      private var _studyType:Number = 0;
      
      private var _menuEnabled:Boolean = false;
      
      private var _tankmanVO:TankmanVO = null;
      
      public function RecruitWindow()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnGroup = new ButtonGroup(GROUP_NAME,this);
         this.btnGroup.addButton(this.btnAcademy);
         this.btnGroup.addButton(this.btnScool);
         this.btnGroup.addButton(this.btnCourses);
         this.btnAcademy.groupName = GROUP_NAME;
         this.btnScool.groupName = GROUP_NAME;
         this.btnCourses.groupName = GROUP_NAME;
         this.btnGroup.addEventListener(Event.CHANGE,this.buttonStudySelectHandler);
         this.btnAcademy.doubleClickEnabled = true;
         this.btnAcademy.allowDeselect = false;
         this.btnAcademy.addEventListener(MouseEvent.DOUBLE_CLICK,this.studyTypeDoubleClickHandler);
         this.btnScool.doubleClickEnabled = true;
         this.btnScool.allowDeselect = false;
         this.btnScool.addEventListener(MouseEvent.DOUBLE_CLICK,this.studyTypeDoubleClickHandler);
         this.btnCourses.doubleClickEnabled = true;
         this.btnCourses.allowDeselect = false;
         this.btnCourses.addEventListener(MouseEvent.DOUBLE_CLICK,this.studyTypeDoubleClickHandler);
         this.btnCourses.selected = true;
         this.btnCancel.addEventListener(ButtonEvent.CLICK,this.closeBtnClickHandler);
         this.btnRecruit.addEventListener(ButtonEvent.CLICK,this.recruitTankmanClickHandler);
         this.nationDropdown.dataProvider = new DataProvider([{
            "label":MENU.NATIONS_ALL,
            "data":null
         }]);
         this.vehicleClassDropdown.dataProvider = new DataProvider([{
            "label":DIALOGS.RECRUITWINDOW_MENUEMPTYROW,
            "data":null
         }]);
         this.vehicleTypeDropdown.dataProvider = new DataProvider([{
            "label":DIALOGS.RECRUITWINDOW_MENUEMPTYROW,
            "data":null
         }]);
         this.roleDropdown.dataProvider = new DataProvider([{
            "label":DIALOGS.RECRUITWINDOW_MENUEMPTYROW,
            "data":null
         }]);
         this.nationDropdown.selectedIndex = 0;
         this.vehicleClassDropdown.selectedIndex = 0;
         this.vehicleTypeDropdown.selectedIndex = 0;
         this.roleDropdown.selectedIndex = 0;
         this.nationDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheckHandler);
         this.vehicleClassDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheckHandler);
         this.vehicleTypeDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheckHandler);
         this.roleDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheckHandler);
         this.setDefaultSelection();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ActionPriceVO = null;
         var _loc2_:ActionPriceVO = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.nationDropdown.validateNow();
            this.vehicleClassDropdown.validateNow();
            _loc1_ = null;
            if(this._data.academyUpgradeActionPriceData)
            {
               _loc1_ = new ActionPriceVO(this._data.academyUpgradeActionPriceData);
            }
            this.btnAcademy.updatePrice(this._data.academyUpgradePrice,IconsTypes.GOLD,_loc1_);
            this.vehicleTypeDropdown.validateNow();
            this.roleDropdown.validateNow();
            _loc2_ = null;
            if(this._data.schoolUpgradeActionPriceData)
            {
               _loc2_ = new ActionPriceVO(this._data.schoolUpgradeActionPriceData);
            }
            this.btnScool.updatePrice(this._data.schoolUpgradePrice,IconsTypes.CREDITS,_loc2_);
            this.btnCourses.updatePrice(0,"");
            if(!this._menuEnabled)
            {
               this.btnAcademy.nation = this._tankmanVO.currentRole.nationID;
               this.btnScool.nation = this._tankmanVO.currentRole.nationID;
               this.btnCourses.nation = this._tankmanVO.currentRole.nationID;
               this.btnAcademy.validateNow();
               this.btnCourses.validateNow();
               this.btnScool.validateNow();
               updateAllDropdownsS(this._tankmanVO.currentRole.nationID,this._tankmanVO.currentRole.tankType,this._tankmanVO.currentRole.typeID,this._tankmanVO.currentRole.roleType);
            }
            else
            {
               this.nationDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.changeNationHandler);
               this.vehicleClassDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.changeVehicleClassHandler);
               this.vehicleTypeDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.changeVehicleTypeHandler);
               updateNationDropdownS();
               this.btnRecruit.enabled = false;
            }
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
         this.window.title = DIALOGS.RECRUITWINDOW_TITLE;
      }
      
      override protected function preInitialize() : void
      {
         constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
      }
      
      override protected function onDispose() : void
      {
         this.nationDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheckHandler);
         if(this.nationDropdown.hasEventListener(ListEvent.INDEX_CHANGE))
         {
            this.nationDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.changeNationHandler);
         }
         this.nationDropdown.dispose();
         this.nationDropdown = null;
         this.roleDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheckHandler);
         this.roleDropdown.dispose();
         this.roleDropdown = null;
         this.vehicleClassDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheckHandler);
         if(this.vehicleClassDropdown.hasEventListener(ListEvent.INDEX_CHANGE))
         {
            this.vehicleClassDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.changeVehicleClassHandler);
         }
         this.vehicleClassDropdown.dispose();
         this.vehicleClassDropdown = null;
         this.vehicleTypeDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheckHandler);
         if(this.vehicleTypeDropdown.hasEventListener(ListEvent.INDEX_CHANGE))
         {
            this.vehicleTypeDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.changeVehicleTypeHandler);
         }
         this.vehicleTypeDropdown.dispose();
         this.vehicleTypeDropdown = null;
         this.btnRecruit.removeEventListener(ButtonEvent.CLICK,this.recruitTankmanClickHandler);
         this.btnRecruit.dispose();
         this.btnRecruit = null;
         this.btnCancel.removeEventListener(ButtonEvent.CLICK,this.closeBtnClickHandler);
         this.btnCancel.dispose();
         this.btnCancel = null;
         this.btnAcademy.removeEventListener(MouseEvent.DOUBLE_CLICK,this.studyTypeDoubleClickHandler);
         this.btnAcademy.dispose();
         this.btnAcademy = null;
         this.btnScool.removeEventListener(MouseEvent.DOUBLE_CLICK,this.studyTypeDoubleClickHandler);
         this.btnScool.dispose();
         this.btnScool = null;
         this.btnCourses.removeEventListener(MouseEvent.DOUBLE_CLICK,this.studyTypeDoubleClickHandler);
         this.btnCourses.dispose();
         this.btnCourses = null;
         this.btnGroup.removeEventListener(Event.CHANGE,this.buttonStudySelectHandler);
         this.btnGroup.dispose();
         this.btnGroup = null;
         this._data = null;
         this._tankmanVO = null;
         super.onDispose();
      }
      
      public function as_initData(param1:Object) : void
      {
         this._data = param1;
         this._tankmanVO = TankmanVO(this._data.data);
         this._menuEnabled = param1.menuEnabled;
         invalidateData();
      }
      
      public function as_setRecruitButtonsEnableState(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         this.btnAcademy.enabled = param1;
         this.btnScool.enabled = param2;
         this.btnCourses.enabled = param3;
      }
      
      override protected function setAllDropdowns(param1:DataProvider, param2:DataProvider, param3:DataProvider, param4:DataProvider) : void
      {
         as_setNations(param1);
         as_setVehicleClassDropdown(param2);
         as_setVehicleTypeDropdown(param3);
         as_setRoleDropdown(param4);
      }
      
      override protected function setNations(param1:DataProvider) : void
      {
         var _loc2_:* = null;
         this.nationDropdown.dataProvider = param1;
         this.nationDropdown.selectedIndex = 0;
         if(!this._menuEnabled)
         {
            this.nationDropdown.enabled = false;
            for(_loc2_ in this.nationDropdown.dataProvider)
            {
               if(this.nationDropdown.dataProvider[_loc2_].id == this._tankmanVO.currentRole.nationID)
               {
                  this.nationDropdown.selectedIndex = Number(_loc2_);
                  break;
               }
            }
            setFocus(this.btnRecruit);
         }
         else
         {
            this.vehicleClassDropdown.enabled = false;
            this.vehicleTypeDropdown.enabled = false;
            this.roleDropdown.enabled = false;
         }
      }
      
      override protected function setRoleDropdown(param1:DataProvider) : void
      {
         var _loc2_:* = null;
         this.roleDropdown.dataProvider = param1;
         this.roleDropdown.selectedIndex = 0;
         if(!this._menuEnabled)
         {
            for(_loc2_ in this.roleDropdown.dataProvider)
            {
               if(this.roleDropdown.dataProvider[_loc2_].id == this._tankmanVO.currentRole.roleType)
               {
                  this.roleDropdown.selectedIndex = Number(_loc2_);
                  break;
               }
            }
            this.roleDropdown.enabled = false;
         }
      }
      
      override protected function setVehicleClassDropdown(param1:DataProvider) : void
      {
         var _loc2_:* = null;
         this.vehicleClassDropdown.dataProvider = param1;
         this.vehicleClassDropdown.selectedIndex = 0;
         if(this.vehicleClassDropdown.selectedIndex == 0)
         {
            this.vehicleTypeDropdown.selectedIndex = 0;
            this.roleDropdown.selectedIndex = 0;
         }
         this.vehicleTypeDropdown.enabled = this.vehicleClassDropdown.selectedIndex != 0;
         this.roleDropdown.enabled = this.vehicleClassDropdown.selectedIndex != 0;
         if(!this._menuEnabled)
         {
            for(_loc2_ in this.vehicleClassDropdown.dataProvider)
            {
               if(this.vehicleClassDropdown.dataProvider[_loc2_].id == this._tankmanVO.currentRole.tankType)
               {
                  this.vehicleClassDropdown.selectedIndex = Number(_loc2_);
                  break;
               }
            }
            this.vehicleClassDropdown.enabled = false;
         }
      }
      
      override protected function setVehicleTypeDropdown(param1:DataProvider) : void
      {
         var _loc2_:* = null;
         this.vehicleTypeDropdown.dataProvider = param1;
         this.vehicleTypeDropdown.selectedIndex = 0;
         if(this.vehicleTypeDropdown.selectedIndex == 0)
         {
            this.roleDropdown.selectedIndex = 0;
         }
         this.roleDropdown.enabled = this.vehicleTypeDropdown.selectedIndex != 0;
         if(!this._data.menuEnabled)
         {
            for(_loc2_ in this.vehicleTypeDropdown.dataProvider)
            {
               if(this.vehicleTypeDropdown.dataProvider[_loc2_].id == this._tankmanVO.currentRole.typeID)
               {
                  this.vehicleTypeDropdown.selectedIndex = Number(_loc2_);
                  break;
               }
            }
            this.vehicleTypeDropdown.enabled = false;
         }
      }
      
      private function setDefaultSelection() : void
      {
         if(this.nationDropdown.enabled && this.nationDropdown.visible)
         {
            setFocus(this.nationDropdown);
         }
         else if(this.vehicleClassDropdown.enabled && this.vehicleClassDropdown.visible)
         {
            setFocus(this.vehicleClassDropdown);
         }
         else if(this.vehicleTypeDropdown.enabled && this.vehicleTypeDropdown.visible)
         {
            setFocus(this.vehicleTypeDropdown);
         }
         else if(this.roleDropdown.enabled && this.roleDropdown.visible)
         {
            setFocus(this.roleDropdown);
         }
         else
         {
            setFocus(this.btnCourses);
         }
      }
      
      public function buttonStudySelectHandler(param1:Event) : void
      {
         switch(this.btnGroup.selectedButton)
         {
            case this.btnAcademy:
               this._studyType = 2;
               break;
            case this.btnScool:
               this._studyType = 1;
               break;
            case this.btnCourses:
               this._studyType = 0;
               break;
            default:
               this._studyType = 0;
         }
      }
      
      public function studyTypeDoubleClickHandler(param1:MouseEvent) : void
      {
         IEventDispatcher(param1.target).dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
         if(App.utils.commons.isLeftButton(param1))
         {
            this.recruitTankmanClickHandler(param1);
         }
      }
      
      private function changeNationHandler(param1:ListEvent) : void
      {
         var _loc2_:Number = this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
         this.vehicleClassDropdown.enabled = !(isNaN(_loc2_) || !this._menuEnabled);
         this.btnAcademy.nation = this.btnScool.nation = this.btnCourses.nation = _loc2_;
         this.updateVehicleClassDropdownS(_loc2_);
      }
      
      private function changeVehicleClassHandler(param1:ListEvent) : void
      {
         var _loc2_:Number = this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
         var _loc3_:String = this.vehicleClassDropdown.dataProvider[this.vehicleClassDropdown.selectedIndex].id;
         this.vehicleTypeDropdown.enabled = !(!this.vehicleClassDropdown.enabled || _loc3_ == null || !_loc3_);
         if(!this.vehicleClassDropdown.enabled || _loc3_ == null || !_loc3_)
         {
            this.vehicleTypeDropdown.selectedIndex = 0;
         }
         this.updateVehicleTypeDropdownS(_loc2_,_loc3_);
      }
      
      private function changeVehicleTypeHandler(param1:ListEvent) : void
      {
         var _loc2_:Number = this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
         var _loc3_:String = this.vehicleClassDropdown.dataProvider[this.vehicleClassDropdown.selectedIndex].id;
         var _loc4_:Number = this.vehicleTypeDropdown.dataProvider[this.vehicleTypeDropdown.selectedIndex].id;
         this.roleDropdown.enabled = !(!this.vehicleTypeDropdown.enabled || isNaN(_loc4_));
         if(!this.vehicleTypeDropdown.enabled || isNaN(_loc4_) || !_loc4_)
         {
            this.roleDropdown.selectedIndex = 0;
         }
         this.updateRoleDropdownS(_loc2_,_loc3_,_loc4_);
      }
      
      private function closeBtnClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function recruitTankmanClickHandler(param1:Event) : void
      {
         var _loc2_:Number = this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
         var _loc3_:Number = this.vehicleTypeDropdown.dataProvider[this.vehicleTypeDropdown.selectedIndex].id;
         var _loc4_:String = this.roleDropdown.dataProvider[this.roleDropdown.selectedIndex].id;
         var _loc5_:Number = this._tankmanVO != null ? Number(this._tankmanVO.currentRole.slot) : Number(-1);
         if(!isNaN(_loc2_) && !isNaN(_loc3_) && !isNaN(_loc5_) && _loc4_)
         {
            buyTankmanS(_loc2_,_loc3_,_loc4_,this._studyType,_loc5_);
         }
      }
      
      private function recruitButtonCheckHandler(param1:ListEvent) : void
      {
         this.btnRecruit.enabled = !(this.nationDropdown.selectedIndex == 0 || this.vehicleClassDropdown.selectedIndex == 0 || this.vehicleTypeDropdown.selectedIndex == 0 || this.roleDropdown.selectedIndex == 0);
      }
   }
}
