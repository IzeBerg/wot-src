package net.wg.gui.lobby.vehiclePreview.infoPanel
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.POSTPROGRESSION_CONSTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
   import net.wg.gui.components.advanced.ViewStackEx;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.tabs.OrangeTabMenu;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.components.vehPostProgression.EntryPointButton;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.vehiclePreview.data.VPPageVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICommons;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class VPInfoPanel extends UIComponentEx implements IStageSizeDependComponent
   {
      
      private static const NATION_FLAG_ALPHA:Number = 1.6;
      
      private static const NATION_CHANGE_IMG_X_SHIFT:int = -10;
      
      private static const VEH_NAME_SCALE_BIG:Number = 1;
      
      private static const VEH_NAME_SCALE_SMALL:Number = 0.64;
      
      private static const VEH_TYPE_SCALE_BIG:Number = 0.5;
      
      private static const VEH_TYPE_SCALE_SMALL:Number = 0.8;
      
      private static const NATION_FLAG_SCALE_BIG:Number = 1;
      
      private static const NATION_FLAG_SCALE_SMALL:Number = 0.5;
      
      private static const NATION_FLAG_X_BIG:int = -55;
      
      private static const NATION_FLAG_X_SMALL:int = -25;
      
      private static const NATION_FLAG_Y_BIG:int = -45;
      
      private static const NATION_FLAG_Y_SMALL:int = 22;
      
      private static const VEH_TYPE_X_SHIFT_BIG:int = 0;
      
      private static const VEH_TYPE_X_SHIFT_SMALL:int = 4;
      
      private static const VEH_TYPE_X_SHIFT_NOT_ELITE:int = -18;
      
      private static const VEH_TYPE_Y_SHIFT_BIG:int = 4;
      
      private static const VEH_TYPE_Y_SHIFT_SMALL:int = -8;
      
      private static const VEH_NAME_Y_BIG:int = 19;
      
      private static const VEH_NAME_Y_SMALL:int = 54;
      
      private static const NATION_CHANGE_IMG_Y_BIG:int = 18;
      
      private static const NATION_CHANGE_IMG_Y_SMALL:int = 38;
      
      private static const TAB_BAR_Y_SHIFT_BIG:int = 38;
      
      private static const TAB_BAR_Y_SHIFT_SMALL:int = 13;
      
      private static const VIEW_STACK_Y_SHIFT_BIG:int = 85;
      
      private static const VIEW_STACK_Y_SHIFT_SMALL:int = 60;
      
      private static const ROLE_Y_SHIFT_BIG:int = 11;
      
      private static const ROLE_Y_SHIFT_SMALL:int = 6;
      
      private static const VEH_POST_PROGRESSION_BTN_HEIGHT:int = 42;
      
      private static const BULLET_VISIBILITY_INVALID:String = "BULLET_VISIBILITY_INVALID";
      
      private static const VEH_ELITE_STR:String = "_elite";
      
      private static const POST_PROGRESSTION_BTN_Y_OFFSET:int = 20;
      
      private static const POST_POROGRESSION_BTN_MAX_Y:int = 578;
       
      
      public var vehicleTypeIcon:Image = null;
      
      public var nationFlagIcon:Image = null;
      
      public var vehicleLevelTF:TextField = null;
      
      public var vehicleNameTF:TextField = null;
      
      public var nationChangeIcon:Sprite = null;
      
      public var tabButtonBar:OrangeTabMenu = null;
      
      public var viewStack:ViewStackEx = null;
      
      public var roleTF:TextField = null;
      
      public var vehPostProgressionBtn:EntryPointButton = null;
      
      private var _viewStackId:String = "";
      
      private var _bulletTabIdx:int = -1;
      
      private var _isBulletVisible:Boolean = false;
      
      private var _data:VPPageVO = null;
      
      private var _counterManager:ICounterManager;
      
      private var _isSmallWidth:Boolean = false;
      
      private var _isSmallHeight:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _commons:ICommons;
      
      public function VPInfoPanel()
      {
         this._counterManager = App.utils.counterManager;
         this._toolTipMgr = App.toolTipMgr;
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         this.tabButtonBar.autoSize = TextFieldAutoSize.LEFT;
         this.tabButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         this.vehicleLevelTF.mouseEnabled = this.vehicleLevelTF.mouseWheelEnabled = false;
         this.vehicleLevelTF.autoSize = TextFieldAutoSize.LEFT;
         this.vehicleLevelTF.wordWrap = false;
         this.vehicleNameTF.mouseEnabled = this.vehicleNameTF.mouseWheelEnabled = false;
         this.vehicleNameTF.autoSize = TextFieldAutoSize.LEFT;
         this.vehicleNameTF.wordWrap = false;
         this.vehicleTypeIcon.smoothing = true;
         this.vehicleTypeIcon.mouseEnabled = this.vehicleTypeIcon.mouseChildren = false;
         this.vehicleTypeIcon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.nationFlagIcon.mouseEnabled = this.nationFlagIcon.mouseChildren = false;
         this.nationFlagIcon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.nationFlagIcon.alpha = NATION_FLAG_ALPHA;
         this.roleTF.addEventListener(MouseEvent.ROLL_OVER,this.onRoleTFRollOverHandler);
         this.roleTF.addEventListener(MouseEvent.ROLL_OUT,this.onRoleTFRollOutHandler);
         this.roleTF.visible = false;
         this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
         this.vehPostProgressionBtn.isSoundEnabled = true;
         this.vehPostProgressionBtn.addEventListener(MouseEvent.CLICK,this.onVehPostProgressionBtnClickHandler);
         this.vehPostProgressionBtn.state = POSTPROGRESSION_CONSTS.RESEARCH_STATE_UNLOCKED;
         this.vehPostProgressionBtn.tooltip = VEH_POST_PROGRESSION.VEHICLEPREVIEWPAGE_BUTTON_ENTRYPOINT_TOOLTIP;
         this.vehPostProgressionBtn.height = VEH_POST_PROGRESSION_BTN_HEIGHT;
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         this._counterManager.removeCounter(this.tabButtonBar.getButtonAt(this._bulletTabIdx));
         this._counterManager = null;
         this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
         this.viewStack.dispose();
         this.viewStack = null;
         this.tabButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         this.tabButtonBar.dispose();
         this.tabButtonBar = null;
         this.vehPostProgressionBtn.removeEventListener(MouseEvent.CLICK,this.onVehPostProgressionBtnClickHandler);
         this.vehPostProgressionBtn.dispose();
         this.vehPostProgressionBtn = null;
         this.vehicleLevelTF = null;
         this.vehicleNameTF = null;
         this.nationChangeIcon = null;
         this.roleTF.removeEventListener(MouseEvent.ROLL_OVER,this.onRoleTFRollOverHandler);
         this.roleTF.removeEventListener(MouseEvent.ROLL_OUT,this.onRoleTFRollOutHandler);
         this.roleTF = null;
         this.vehicleTypeIcon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.vehicleTypeIcon.dispose();
         this.vehicleTypeIcon = null;
         this.nationFlagIcon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.nationFlagIcon.dispose();
         this.nationFlagIcon = null;
         this._data = null;
         this._toolTipMgr = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.vehicleLevelTF.htmlText = this._data.vehicleLevel;
               this.vehicleNameTF.htmlText = this._data.vehicleName;
               this.nationChangeIcon.visible = this._data.isMultinational;
               this.nationFlagIcon.source = this._data.nationFlagIcon;
               this.roleTF.visible = StringUtils.isNotEmpty(this._data.roleText);
               if(this.roleTF.visible)
               {
                  this.roleTF.htmlText = this._data.roleText;
                  this._commons.updateTextFieldSize(this.roleTF,true,false);
               }
               this.updatePostProgressionVisibility();
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc1_ = !!this._data.isVehicleElite ? VEH_ELITE_STR : "";
               if(this._isSmallHeight)
               {
                  this.vehicleTypeIcon.source = RES_ICONS.getVehicleTypeLargeIcon(this._data.vehicleType,_loc1_);
               }
               else
               {
                  this.vehicleTypeIcon.source = RES_ICONS.getVehicleTypeHugeIcon(this._data.vehicleType,_loc1_);
               }
               this.vehicleNameTF.scaleX = this.vehicleNameTF.scaleY = !!this._isSmallHeight ? Number(VEH_NAME_SCALE_SMALL) : Number(VEH_NAME_SCALE_BIG);
               this.vehicleLevelTF.scaleX = this.vehicleLevelTF.scaleY = !!this._isSmallHeight ? Number(VEH_NAME_SCALE_SMALL) : Number(VEH_NAME_SCALE_BIG);
               this.vehicleTypeIcon.scaleX = this.vehicleTypeIcon.scaleY = !!this._isSmallHeight ? Number(VEH_TYPE_SCALE_SMALL) : Number(VEH_TYPE_SCALE_BIG);
               this.nationFlagIcon.scaleX = this.nationFlagIcon.scaleY = !!this._isSmallHeight ? Number(NATION_FLAG_SCALE_SMALL) : Number(NATION_FLAG_SCALE_BIG);
               this.nationFlagIcon.x = !!this._isSmallHeight ? Number(NATION_FLAG_X_SMALL) : Number(NATION_FLAG_X_BIG);
               this.nationFlagIcon.y = !!this._isSmallHeight ? Number(NATION_FLAG_Y_SMALL) : Number(NATION_FLAG_Y_BIG);
               this.vehicleNameTF.y = this.vehicleLevelTF.y = !!this._isSmallHeight ? Number(VEH_NAME_Y_SMALL) : Number(VEH_NAME_Y_BIG);
               this.nationChangeIcon.y = !!this._isSmallHeight ? Number(NATION_CHANGE_IMG_Y_SMALL) : Number(NATION_CHANGE_IMG_Y_BIG);
               _loc2_ = !!this._isSmallHeight ? int(VEH_TYPE_Y_SHIFT_SMALL) : int(VEH_TYPE_Y_SHIFT_BIG);
               this.vehicleTypeIcon.y = this.vehicleLevelTF.y + _loc2_ >> 0;
               _loc3_ = !!this._isSmallHeight ? int(VEH_TYPE_X_SHIFT_SMALL) : int(VEH_TYPE_X_SHIFT_BIG);
               _loc3_ += !!this._data.isVehicleElite ? 0 : VEH_TYPE_X_SHIFT_NOT_ELITE;
               this.vehicleTypeIcon.x = this.vehicleLevelTF.width + _loc3_ >> 0;
               this.vehicleNameTF.x = this.vehicleTypeIcon.x + this.vehicleTypeIcon.width + _loc3_ >> 0;
               this.nationChangeIcon.x = this.vehicleNameTF.x + this.vehicleNameTF.width + NATION_CHANGE_IMG_X_SHIFT >> 0;
               _loc4_ = 0;
               if(this.roleTF.visible)
               {
                  _loc4_ = !!this._isSmallHeight ? int(ROLE_Y_SHIFT_SMALL) : int(ROLE_Y_SHIFT_BIG);
                  this.roleTF.y = this.vehicleNameTF.y + this.vehicleNameTF.height + _loc4_ >> 0;
                  _loc4_ += this.roleTF.height;
               }
               _loc5_ = !!this._isSmallHeight ? int(TAB_BAR_Y_SHIFT_SMALL) : int(TAB_BAR_Y_SHIFT_BIG);
               this.tabButtonBar.y = this.vehicleNameTF.y + this.vehicleNameTF.height + _loc5_ + _loc4_ >> 0;
               this.tabButtonBar.width = App.appWidth >> 1;
               this.tabButtonBar.validateNow();
               _loc6_ = !!this._isSmallHeight ? int(VIEW_STACK_Y_SHIFT_SMALL) : int(VIEW_STACK_Y_SHIFT_BIG);
               this.viewStack.y = this.tabButtonBar.y + _loc6_ >> 0;
               this.viewStack.setSize(this.width,height - this.viewStack.y);
               if(this.vehPostProgressionBtn.visible)
               {
                  _loc7_ = this.viewStack.y + this.viewStack.currentView.height + (!!this._isSmallHeight ? 0 : POST_PROGRESSTION_BTN_Y_OFFSET);
                  this.vehPostProgressionBtn.isSmall = this._isSmallWidth;
                  this.vehPostProgressionBtn.y = !!this._isSmallWidth ? Number(Math.min(POST_POROGRESSION_BTN_MAX_Y,_loc7_)) : Number(_loc7_);
               }
            }
         }
         if(isInvalid(BULLET_VISIBILITY_INVALID))
         {
            this.updateBulletVisibility();
         }
      }
      
      public function setBulletVisibility(param1:int, param2:Boolean) : void
      {
         this._bulletTabIdx = param1;
         this._isBulletVisible = param2;
         invalidate(BULLET_VISIBILITY_INVALID);
      }
      
      public function setData(param1:VPPageVO) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._isSmallWidth = param1 < StageSizeBoundaries.WIDTH_1280;
         this._isSmallHeight = param2 <= StageSizeBoundaries.HEIGHT_900;
         invalidateSize();
      }
      
      public function setTabsData(param1:DataProvider) : void
      {
         this.tabButtonBar.dataProvider = param1;
         invalidateSize();
      }
      
      private function updatePostProgressionVisibility() : void
      {
         var _loc1_:Boolean = this._viewStackId == VEHPREVIEW_CONSTANTS.MODULES_LINKAGE;
         this.vehPostProgressionBtn.visible = this._data && this._data.showPostProgressionBtn && _loc1_;
      }
      
      private function updateBulletVisibility() : void
      {
         var _loc1_:Button = this.tabButtonBar.getButtonAt(this._bulletTabIdx);
         if(_loc1_ != null && this._isBulletVisible)
         {
            if(this.tabButtonBar.selectedIndex != this._bulletTabIdx)
            {
               this._counterManager.setCounter(_loc1_," ",null,new CounterProps(-10,-3));
            }
            else
            {
               this._counterManager.removeCounter(_loc1_);
               this._isBulletVisible = false;
            }
         }
      }
      
      override public function get width() : Number
      {
         return this.tabButtonBar.getWidth();
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         this.tabButtonBar.visible = param1;
         if(param1)
         {
            this.updatePostProgressionVisibility();
         }
         else
         {
            this.vehPostProgressionBtn.visible = false;
         }
      }
      
      private function onVehPostProgressionBtnClickHandler(param1:MouseEvent) : void
      {
         if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_POST_PROGRESSION));
         }
      }
      
      private function onViewStackViewChangedHandler(param1:ViewStackEvent) : void
      {
         this._viewStackId = param1.viewId;
         this.updatePostProgressionVisibility();
         invalidateSize();
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onTabIndexChangeHandler(param1:IndexEvent) : void
      {
         invalidate(BULLET_VISIBILITY_INVALID);
      }
      
      private function onRoleTFRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data.roleId > 0)
         {
            this._toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.VEHICLE_ROLES,this._data.vehicleCD);
         }
      }
      
      private function onRoleTFRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
