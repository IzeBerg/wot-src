package net.wg.gui.lobby.tankman
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.VO.TankmanCardVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.TankmanCard;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.carousels.CarouselBase;
   import net.wg.gui.components.carousels.SkillsCarousel;
   import net.wg.gui.components.controls.ActionPriceBg;
   import net.wg.gui.components.controls.TabButton;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.tankman.vo.PersonalCaseTabNameVO;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ILocale;
   import net.wg.utils.IUtils;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.StatusIndicator;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.utils.Padding;
   
   public class PersonalCase extends PersonalCaseBase
   {
      
      private static const MODIFIER_COLOR_NORMAL:String = "#FFFFFF";
      
      private static const MODIFIER_COLOR_ALERT:String = "#b70000";
      
      private static const MODIFIER_TEXT_SIZE:uint = 16;
      
      private static const MODIFIER_HEADER_TEXT_SIZE:uint = 16;
      
      private static const MODIFIER_ADDITIONAL_HEIGHT:uint = 5;
      
      private static const UPDATE_SCROLLING_LIST:String = "updateScrollingList";
      
      private static const SKILLS_CAROUSEL_ITEM_SIDE:uint = 60;
      
      private static const SKILLS_CAROUSEL_ITEM_MARGIN:uint = 3;
      
      private static const SKILLS_CAROUSEL_POSITION:Point = new Point(21,399);
      
      private static const SPECIALIZATION_MARGIN:Number = 4;
      
      private static const WINDOW_PADDING_TOP:uint = 32;
      
      private static const WINDOW_PADDING_BOTTOM:uint = 18;
      
      private static const WINDOW_PADDING_LEFT:uint = 11;
      
      private static const TABS_BUTTON_WIDTH:uint = 100;
      
      private static const MAX_SPECIALIZATION_LEVEL:uint = 100;
      
      private static const BR_TAG:String = "<br/>";
       
      
      public var tabButtonVisibleFalse:TabButton;
      
      public var role:TextField;
      
      public var levelValue:TextField;
      
      public var tankmanCard:TankmanCard;
      
      public var tabs:ButtonBarEx;
      
      public var view:ViewStack;
      
      public var skills_mc:SkillsCarousel;
      
      public var specialization:PersonalCaseSpecialization;
      
      public var modifiersHeaders:TextField;
      
      public var modifiersValues:TextField;
      
      public var modifiersNames:TextField;
      
      public var unloadBtn:ISoundButtonEx;
      
      public var dismissBtn:ISoundButtonEx;
      
      public var closeBtn:ISoundButtonEx;
      
      public var alertIcon:UILoaderAlt;
      
      public var accTeachingOfSkillBtn:ISoundButtonEx;
      
      public var usingLevelLoadingBar:StatusIndicator;
      
      public var roleIcon:MovieClip;
      
      public var skillsBtn:MovieClip;
      
      public var dropSkillsButton:ISoundButtonEx;
      
      public var changeRoleBtn:ISoundButtonEx;
      
      public var changeRoleDiscountIcon:ActionPriceBg;
      
      public var descrSkillButton:TextField;
      
      private var _currentView:IViewStackContent;
      
      private var _currentNation:String = "";
      
      private var _isUpdateList:Boolean = false;
      
      private var _tankmanInBattle:Boolean = false;
      
      private var _tabnames:Array;
      
      private var _crewSkinTabBtnWithCounter:Button = null;
      
      private var _counterManager:ICounterManager = null;
      
      public function PersonalCase()
      {
         super();
         showWindowBgForm = false;
         this._counterManager = App.utils.counterManager;
      }
      
      override protected function setCommonData(param1:PersonalCaseModel) : void
      {
         super.setCommonData(param1);
         if(isFirtsRun)
         {
            this.tabs.selectedIndex = autoSelectTab;
            isFirtsRun = false;
         }
      }
      
      override protected function onDispose() : void
      {
         App.toolTipMgr.hide();
         removeEventListener(PersonalCaseEvent.CHANGE_TAB_ON_TWO,this.onChangeTabToTwoHandler);
         removeEventListener(PersonalCaseEvent.APPLY_RETRAINING,this.onApplyRetrainingHandler);
         removeEventListener(PersonalCaseEvent.GET_TANKMAN_ID,this.onGetTankmanIdHandler);
         removeEventListener(PersonalCaseEvent.TRAINING_SKILL,this.onTrainingSkillHandler);
         removeEventListener(PersonalCaseEvent.CHANGE_PASSPORT,this.onChangePassportHandler);
         removeEventListener(PersonalCaseEvent.EQUIP_CREW_SKIN,this.onEquipCrewSkinHandler);
         removeEventListener(PersonalCaseEvent.UNEQUIP_CREW_SKIN,this.onUnequipCrewSkinHandler);
         removeEventListener(PersonalCaseEvent.TAKE_OFF_NEW_MARK,this.onTakeOffNewMarkFromCrewSkinHandler);
         removeEventListener(PersonalCaseEvent.CHANGE_CREW_SKIN_HISTORICALLY_ACCURATE,this.onChangeHistoricallyAccurateHandler);
         removeEventListener(PersonalCaseEvent.PLAY_CREW_SKIN_SOUND,this.onPlayCrewSkinSoundHandler);
         if(this._crewSkinTabBtnWithCounter != null)
         {
            this._counterManager.removeCounter(this._crewSkinTabBtnWithCounter);
            this._crewSkinTabBtnWithCounter = null;
         }
         this.unloadBtn.removeEventListener(ButtonEvent.CLICK,this.onUnloadBtnClickHandler);
         this.unloadBtn.dispose();
         this.unloadBtn = null;
         this.dismissBtn.removeEventListener(ButtonEvent.CLICK,this.onDismissBtnClickHandler);
         this.dismissBtn.dispose();
         this.dismissBtn = null;
         this.skillsBtn.removeEventListener(ButtonEvent.CLICK,this.onSkillsBtnClickHandler);
         this.skillsBtn = null;
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsClickIndexChangeHandler);
         this.tabs.dispose();
         this.tabs = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.dropSkillsButton.removeEventListener(ButtonEvent.CLICK,this.onDropSkillsButtonClickHandler);
         this.dropSkillsButton.dispose();
         this.dropSkillsButton = null;
         this.changeRoleBtn.removeEventListener(ButtonEvent.CLICK,this.onChangeRoleBtnClickHandler);
         this.changeRoleBtn.dispose();
         this.changeRoleBtn = null;
         this.changeRoleDiscountIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onRoleDiscountOver);
         this.changeRoleDiscountIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onRoleDiscountOut);
         this.changeRoleDiscountIcon = null;
         if(this.view.currentView)
         {
            this.view.currentView.removeEventListener(PersonalCaseEvent.CHANGE_RETRAIN_VEHICLE,this.onChangeRetrainVehicleHandler);
         }
         this.view.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
         this.view.dispose();
         this.view = null;
         this.skills_mc.removeEventListener(PersonalCaseEvent.CHANGE_TAB_ON_TWO,this.onChangeTabToTwoHandler);
         this.skills_mc.dispose();
         this.skills_mc = null;
         this.tabButtonVisibleFalse.dispose();
         this.tabButtonVisibleFalse = null;
         this.tankmanCard.dispose();
         this.tankmanCard = null;
         this.specialization.dispose();
         this.specialization = null;
         this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onAlertIconRollOverHandler);
         this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onAlertIconRollOutHandler);
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.accTeachingOfSkillBtn.removeEventListener(ButtonEvent.CLICK,this.onTeachSkillBtnClickHandler);
         this.accTeachingOfSkillBtn.dispose();
         this.accTeachingOfSkillBtn = null;
         this.usingLevelLoadingBar.dispose();
         this.usingLevelLoadingBar = null;
         if(this._tabnames)
         {
            this._tabnames.splice(0,this._tabnames.length);
            this._tabnames = null;
         }
         this._currentView = null;
         this.roleIcon = null;
         this.role = null;
         this.levelValue = null;
         this.modifiersHeaders = null;
         this.modifiersValues = null;
         this.modifiersNames = null;
         this.descrSkillButton = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isUpdateList && isInvalid(UPDATE_SCROLLING_LIST))
         {
            this.skills_mc.dataProvider = new DataProvider(data.skills);
            this.skills_mc.invalidate(CarouselBase.INIT_CAROUSEL);
            this._isUpdateList = false;
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         var _loc1_:Padding = window.contentPadding as Padding;
         App.utils.asserter.assertNotNull(_loc1_,"windowPadding" + Errors.CANT_NULL);
         _loc1_.top = WINDOW_PADDING_TOP;
         _loc1_.bottom = WINDOW_PADDING_BOTTOM;
         _loc1_.left = WINDOW_PADDING_LEFT;
         window.contentPadding = _loc1_;
         window.useBottomBtns = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tabButtonVisibleFalse.visible = false;
         this.view.targetGroup = "tabs";
         this.unloadBtn.label = MENU.BARRACKS_BTNUNLOAD;
         this.dismissBtn.label = MENU.BARRACKS_BTNDISSMISS;
         this.closeBtn.label = MENU.TANKMANPERSONALCASE_CLOSEBTN;
         this.unloadBtn.addEventListener(ButtonEvent.CLICK,this.onUnloadBtnClickHandler);
         this.dismissBtn.addEventListener(ButtonEvent.CLICK,this.onDismissBtnClickHandler);
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.changeRoleBtn.label = MENU.TANKMANPERSONALCASE_CHANGEROLEBTN;
         this.changeRoleBtn.addEventListener(ButtonEvent.CLICK,this.onChangeRoleBtnClickHandler);
         this.changeRoleDiscountIcon.visible = false;
         this.changeRoleDiscountIcon.state = ACTION_PRICE_CONSTANTS.STATE_ALIGN_TOP;
         this.tabs.buttonWidth = TABS_BUTTON_WIDTH;
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsClickIndexChangeHandler);
         this.accTeachingOfSkillBtn.visible = false;
         this.accTeachingOfSkillBtn.enabled = false;
         this.dropSkillsButton.addEventListener(ButtonEvent.CLICK,this.onDropSkillsButtonClickHandler);
         this.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
         addEventListener(PersonalCaseEvent.CHANGE_TAB_ON_TWO,this.onChangeTabToTwoHandler);
         addEventListener(PersonalCaseEvent.APPLY_RETRAINING,this.onApplyRetrainingHandler,true);
         addEventListener(PersonalCaseEvent.GET_TANKMAN_ID,this.onGetTankmanIdHandler);
         addEventListener(PersonalCaseEvent.TRAINING_SKILL,this.onTrainingSkillHandler);
         addEventListener(PersonalCaseEvent.CHANGE_PASSPORT,this.onChangePassportHandler);
         addEventListener(PersonalCaseEvent.EQUIP_CREW_SKIN,this.onEquipCrewSkinHandler);
         addEventListener(PersonalCaseEvent.UNEQUIP_CREW_SKIN,this.onUnequipCrewSkinHandler);
         addEventListener(PersonalCaseEvent.TAKE_OFF_NEW_MARK,this.onTakeOffNewMarkFromCrewSkinHandler);
         addEventListener(PersonalCaseEvent.CHANGE_CREW_SKIN_HISTORICALLY_ACCURATE,this.onChangeHistoricallyAccurateHandler);
         addEventListener(PersonalCaseEvent.PLAY_CREW_SKIN_SOUND,this.onPlayCrewSkinSoundHandler);
         this.alertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTICON;
         this.modifiersValues.text = COMMON.COMMON_DASH;
         this.unloadBtn.mouseEnabledOnDisabled = true;
         this.dismissBtn.mouseEnabledOnDisabled = true;
         this.changeRoleBtn.mouseEnabledOnDisabled = true;
         this.accTeachingOfSkillBtn.mouseEnabledOnDisabled = true;
         this.dropSkillsButton.mouseEnabledOnDisabled = true;
         getDossierDataS();
         getCommonDataS();
         getRetrainingDataS();
         getSkillsDataS();
         getDocumentsDataS();
         getCrewSkinsDataS();
      }
      
      override protected function updateCommonElements() : void
      {
         var _loc1_:IUtils = App.utils;
         this._currentNation = _loc1_.nations.getNationName(data.nationID);
         data.wg_freeXpToTankman = App.globalVarsMgr.isFreeXpToTankmanS();
         this._tankmanInBattle = data.currentVehicle != null && data.currentVehicle.currentVehicleLocked;
         this.initializeSkillBtn(this._tankmanInBattle);
         if(!this.skillsBtn.visible)
         {
            this.initSkillsCarousel();
         }
         else
         {
            this.skills_mc.visible = false;
         }
         this.dropSkillsButton.enabled = this.isEnableDropSkillsButton();
         if(this.dropSkillsButton.enabled)
         {
            this.dropSkillsButton.tooltip = TOOLTIPS.PERSONAL_CASE_SKILLS_DROPSKILLSBUTTON;
         }
         else
         {
            this.dropSkillsButton.tooltip = TOOLTIPS.PERSONAL_CASE_SKILLS_DROPSKILLSBUTTON_NOSKILL;
         }
         this.initializeGeneralProperties();
         if(window)
         {
            window.title = data.fullName + ", " + data.role + " - " + _loc1_.locale.makeString(MENU.TANKMANPERSONALCASE_TITLE);
         }
         this.initializeTabButton();
         validateNow();
      }
      
      override protected function updateSkillsRelatedElements() : void
      {
         this.alertIcon.visible = false;
         if(data.wg_freeXpToTankman)
         {
            this.accTeachingOfSkillBtn.visible = true;
            this.accTeachingOfSkillBtn.tooltip = TOOLTIPS.PERSONAL_CASE_SKILLS_ACCTEACHINGOFSKILLBTN;
            if(this.isTeachingButtonEnable())
            {
               this.accTeachingOfSkillBtn.enabled = !this._tankmanInBattle;
               this.accTeachingOfSkillBtn.addEventListener(ButtonEvent.CLICK,this.onTeachSkillBtnClickHandler);
            }
            else
            {
               this.accTeachingOfSkillBtn.enabled = false;
               if(!data.enoughFreeXPForTeaching)
               {
                  this.accTeachingOfSkillBtn.tooltip = TOOLTIPS.PERSONAL_CASE_SKILLS_ACCTEACHINGOFSKILLBTN_NOTENOUGHFREEXP;
                  this.alertIcon.visible = true;
                  this.alertIcon.addEventListener(MouseEvent.ROLL_OVER,this.onAlertIconRollOverHandler);
                  this.alertIcon.addEventListener(MouseEvent.ROLL_OUT,this.onAlertIconRollOutHandler);
               }
               else
               {
                  this.accTeachingOfSkillBtn.tooltip = TOOLTIPS.PERSONAL_CASE_SKILLS_ACCTEACHINGOFSKILLBTN_SELECTSKILL;
               }
            }
         }
         else
         {
            this.accTeachingOfSkillBtn.visible = false;
         }
      }
      
      override protected function runtimeUpdateByModel(param1:Class, param2:Object) : void
      {
         if(this._currentView is param1)
         {
            this._currentView.update(param2);
         }
      }
      
      protected function initializeTabButton() : void
      {
         if(!this._tabnames)
         {
            this._tabnames = data.tabsData;
         }
         if(data.currentVehicle == null || !data.currentVehicle.currentVehicleLocked)
         {
            if(this.tabs.dataProvider.length <= 1)
            {
               this.tabs.dataProvider = new DataProvider(this._tabnames);
            }
         }
         else
         {
            this.tabs.dataProvider = new DataProvider(this._tabnames.slice(0,1));
         }
         if(this.tabs.selectedIndex == -1)
         {
            this.tabs.selectedIndex = 0;
            this.tabs.validateNow();
         }
         else
         {
            this.runtimeShowByIndex();
         }
      }
      
      override protected function updateCrewSkinTabCount(param1:int) : void
      {
         var _loc2_:PersonalCaseTabNameVO = null;
         var _loc5_:Button = null;
         var _loc3_:String = param1 > 0 ? String(param1) : null;
         var _loc4_:int = data.tabsData.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc2_ = data.tabsData[_loc6_];
            if(_loc2_.linkage == Linkages.PERSONAL_CASE_CREW_SKINS)
            {
               _loc5_ = this.tabs.getButtonAt(_loc6_);
               if(_loc5_)
               {
                  this._crewSkinTabBtnWithCounter = _loc5_;
                  this._counterManager.setCounter(_loc5_,_loc3_,null,new CounterProps(3,-3));
               }
               break;
            }
            _loc6_++;
         }
      }
      
      private function initSkillsCarousel() : void
      {
         if(!this.skills_mc.visible)
         {
            this.skills_mc.visible = true;
            this.skills_mc.slotImageHeight = SKILLS_CAROUSEL_ITEM_SIDE;
            this.skills_mc.slotImageWidth = SKILLS_CAROUSEL_ITEM_SIDE;
            this.skills_mc.margin = SKILLS_CAROUSEL_ITEM_MARGIN;
            this.addChild(this.skills_mc);
            this.skills_mc.x = SKILLS_CAROUSEL_POSITION.x;
            this.skills_mc.y = SKILLS_CAROUSEL_POSITION.y;
            this.skills_mc.addEventListener(PersonalCaseEvent.CHANGE_TAB_ON_TWO,this.onChangeTabToTwoHandler);
         }
         this._isUpdateList = true;
         invalidate(UPDATE_SCROLLING_LIST);
      }
      
      private function initializeGeneralProperties() : void
      {
         this.role.text = data.role;
         this.levelValue.text = data.specializationLevel.toString() + "%";
         this.specialization.setData(data.nativeVehicle.userName,data.nativeVehicle.contourIconFile);
         this.usingLevelLoadingBar.maximum = MAX_SPECIALIZATION_LEVEL;
         this.usingLevelLoadingBar.minimum = 0;
         this.usingLevelLoadingBar.position = data.specializationLevel;
         this.roleIcon.gotoAndStop(data.roleType);
         this.descrSkillButton.visible = true;
         this.descrSkillButton.text = App.utils.locale.makeString(DIALOGS.ADDSKILLWINDOW_LABEL);
         var _loc1_:TankmanCardVO = new TankmanCardVO({});
         _loc1_.name = data.fullName;
         _loc1_.nation = this._currentNation;
         _loc1_.rank = data.rank;
         _loc1_.vehicle = Boolean(data.currentVehicle) ? data.currentVehicle.currentVehicleName + " " + App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.ERROR_TEXT,data.currentVehicle.currentVehicleLockMessage) : Values.EMPTY_STR;
         _loc1_.faceIcon = data.iconFile;
         _loc1_.rankIcon = data.rankIconFile;
         this.tankmanCard.model = _loc1_;
         this.tankmanCard.isVehicleLocked = data.currentVehicle && data.currentVehicle.currentVehicleLockMessage;
         this.dismissBtn.tooltip = data.tooltipDismiss;
         this.unloadBtn.tooltip = data.tooltipUnload;
         this.changeRoleBtn.tooltip = data.tooltipChangeRole;
         var _loc2_:ActionPriceVO = data.actionChangeRole;
         this.changeRoleDiscountIcon.visible = _loc2_.useAction;
         if(this.changeRoleDiscountIcon.visible)
         {
            this.changeRoleDiscountIcon.addEventListener(MouseEvent.ROLL_OVER,this.onRoleDiscountOver);
            this.changeRoleDiscountIcon.addEventListener(MouseEvent.ROLL_OUT,this.onRoleDiscountOut);
         }
         this.unloadBtn.enabled = data.inTank && !this._tankmanInBattle;
         this.changeRoleBtn.enabled = !this._tankmanInBattle;
         if(data.inTank)
         {
            this.dismissBtn.enabled = !data.currentVehicle.currentVehicleLocked && !data.currentVehicle.currentVehicleBroken;
         }
         else
         {
            this.dismissBtn.enabled = true;
         }
         this.dismissBtn.enabled = data.dismissEnabled && this.dismissBtn.enabled;
         this.unloadBtn.enabled = data.unloadEnabled && this.unloadBtn.enabled;
         this.changeRoleBtn.enabled = data.changeRoleEnabled && this.changeRoleBtn.enabled;
         this.updateModifiers();
      }
      
      private function updateModifiers() : void
      {
         var _loc5_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:Object = null;
         var _loc9_:Boolean = false;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc1_:ILocale = App.utils.locale;
         this.modifiersHeaders.htmlText = _loc1_.makeString(MENU.TANKMANPERSONALCASE_MODIFIERSHEADER);
         this.modifiersValues.htmlText = Values.EMPTY_STR;
         this.modifiersNames.htmlText = Values.EMPTY_STR;
         var _loc2_:Number = 0;
         var _loc3_:String = Values.EMPTY_STR;
         var _loc4_:Boolean = false;
         var _loc6_:Array = data.modifiers;
         if(_loc6_ && _loc6_.length > 0)
         {
            _loc7_ = _loc6_.length;
            _loc9_ = false;
            _loc10_ = 0;
            while(_loc10_ < _loc7_)
            {
               _loc8_ = _loc6_[_loc10_];
               if(_loc8_.val != 0)
               {
                  _loc4_ = true;
                  if(_loc8_.val > 0)
                  {
                     _loc3_ = "+";
                     _loc5_ = MODIFIER_COLOR_NORMAL;
                  }
                  else
                  {
                     _loc3_ = Values.EMPTY_STR;
                     _loc5_ = MODIFIER_COLOR_ALERT;
                     _loc9_ = true;
                  }
                  _loc2_ += _loc8_.val;
                  if(_loc10_ != _loc6_.length - 1)
                  {
                     this.modifiersHeaders.htmlText += BR_TAG;
                  }
                  this.modifiersValues.htmlText += "<font color=\"" + _loc5_ + "\">" + _loc3_ + _loc8_.val + "%</font>" + BR_TAG;
                  this.modifiersNames.htmlText += _loc1_.makeString(MENU.tankmanpersonalcase_modifiers(_loc8_.id)) + BR_TAG;
                  while(this.modifiersNames.numLines > this.modifiersValues.numLines)
                  {
                     this.modifiersHeaders.htmlText += BR_TAG;
                     this.modifiersValues.htmlText += BR_TAG;
                  }
               }
               _loc10_++;
            }
            if(_loc4_)
            {
               this.modifiersHeaders.htmlText += "<font size=\"" + MODIFIER_HEADER_TEXT_SIZE + "\"> </font>" + _loc1_.makeString(MENU.TANKMANPERSONALCASE_MODIFIERSRESULT);
               _loc11_ = !!_loc9_ ? MODIFIER_COLOR_ALERT : MODIFIER_COLOR_NORMAL;
               this.modifiersValues.htmlText += "<font color=\"" + _loc11_ + "\" size=\"" + MODIFIER_TEXT_SIZE + "\">" + (data.specializationLevel + _loc2_).toString() + "%</font>";
            }
            else
            {
               this.addNoModifiersInfo();
            }
         }
         else
         {
            this.addNoModifiersInfo();
         }
         this.modifiersHeaders.height = Math.max(this.modifiersNames.textHeight,Math.max(this.modifiersHeaders.textHeight,this.modifiersValues.textHeight)) + MODIFIER_ADDITIONAL_HEIGHT;
         this.modifiersValues.height = this.modifiersHeaders.height;
         this.modifiersNames.height = this.modifiersHeaders.height;
         this.specialization.y = this.modifiersHeaders.y + this.modifiersHeaders.height + SPECIALIZATION_MARGIN | 0;
      }
      
      private function addNoModifiersInfo() : void
      {
         this.modifiersValues.htmlText = "-";
         this.modifiersNames.htmlText = MENU.TANKMANPERSONALCASE_NOMODIFIERS;
         var _loc1_:TextFormat = this.modifiersNames.getTextFormat();
         _loc1_.leading = 0;
         this.modifiersNames.setTextFormat(_loc1_);
      }
      
      private function isTeachingButtonEnable() : Boolean
      {
         return data.skills.length > 0 && data.skillsCountForLearn == 0 && (this.isLearningSomething() || skillsModel.length > 0) && data.specializationLevel == MAX_SPECIALIZATION_LEVEL && data.enoughFreeXPForTeaching;
      }
      
      private function isLearningSomething() : Boolean
      {
         var _loc1_:CarouselTankmanSkillsModel = null;
         var _loc2_:uint = data.skills.length;
         if(_loc2_ > 0)
         {
            _loc1_ = CarouselTankmanSkillsModel(data.skills[_loc2_ - 1]);
            assertNotNull(_loc1_);
            return _loc1_ && _loc1_.level < MAX_SPECIALIZATION_LEVEL;
         }
         return false;
      }
      
      private function isEnableDropSkillsButton() : Boolean
      {
         var _loc3_:Object = null;
         if(data.currentVehicle && data.currentVehicle.currentVehicleLocked)
         {
            return false;
         }
         var _loc1_:uint = data.skills.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = data.skills[_loc2_];
            if(!_loc3_.isNewSkill && !_loc3_.isPermanent)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function initializeSkillBtn(param1:Boolean) : void
      {
         this.skillsBtn.visible = data.skills.length == 0;
         this.skillsBtn.enabled = !param1;
         this.skillsBtn.bg.flag_switcher.gotoAndPlay(this._currentNation);
         this.skillsBtn.addEventListener(ButtonEvent.CLICK,this.onSkillsBtnClickHandler);
      }
      
      private function runtimeUpdateByInstance(param1:IViewStackContent = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is PersonalCaseStats && stats)
         {
            param1.update(stats);
         }
         else if(param1 is CrewTankmanRetraining && rentainingTabUpdated)
         {
            param1.update(retrainingData);
            rentainingTabUpdated = false;
         }
         else if(param1 is PersonalCaseSkills && skillsModel)
         {
            param1.update(new PersonalCaseSkillsModel(skillsModel,data.isBootcamp));
         }
         else if(param1 is PersonalCaseDocs && documentsData)
         {
            param1.update(documentsData);
         }
         else if(param1 is PersonalCaseCrewSkins && crewSkinsData)
         {
            param1.update(crewSkinsData);
         }
      }
      
      private function runtimeShowByIndex() : void
      {
         var _loc2_:Boolean = false;
         if(this.view.currentView)
         {
            this.view.currentView.removeEventListener(PersonalCaseEvent.CHANGE_RETRAIN_VEHICLE,this.onChangeRetrainVehicleHandler);
         }
         var _loc1_:PersonalCaseTabNameVO = PersonalCaseTabNameVO(this.tabs.selectedItem);
         if(_loc1_ != null)
         {
            _loc2_ = data.inTank && !data.currentVehicle.currentVehicleLocked;
            if(_loc1_.index == 0 || _loc2_)
            {
               this.view.show(_loc1_.linkage,_loc1_.linkage);
            }
         }
         this._currentView = this.view.currentView;
         this._currentView.addEventListener(PersonalCaseEvent.CHANGE_RETRAIN_VEHICLE,this.onChangeRetrainVehicleHandler);
         this.runtimeUpdateByInstance(this._currentView);
      }
      
      private function onRoleDiscountOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onRoleDiscountOver(param1:MouseEvent) : void
      {
         var _loc2_:ActionPriceVO = data.actionChangeRole;
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,_loc2_.type,_loc2_.key,_loc2_.newPrices,_loc2_.oldPrices,_loc2_.isBuying,_loc2_.forCredits,_loc2_.rentPackage);
      }
      
      private function onChangeRoleBtnClickHandler(param1:ButtonEvent) : void
      {
         openChangeRoleWindowS();
      }
      
      private function onTeachSkillBtnClickHandler(param1:ButtonEvent) : void
      {
         openExchangeFreeToTankmanXpWindowS();
      }
      
      private function onViewNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         if(!this._currentView || this._currentView && this._currentView != param1.view)
         {
            this._currentView = IViewStackContent(param1.view);
         }
         this.runtimeUpdateByInstance(this._currentView);
      }
      
      private function onApplyRetrainingHandler(param1:PersonalCaseEvent) : void
      {
         retrainingTankmanS(param1.retrainingTankmanData.inventoryID,param1.retrainingTankmanData.tankmanCostTypeIndex);
      }
      
      private function onTrainingSkillHandler(param1:PersonalCaseEvent) : void
      {
         addTankmanSkillS(data.inventoryID,param1.trainingSkillName);
      }
      
      private function onTabsClickIndexChangeHandler(param1:IndexEvent) : void
      {
         this.runtimeShowByIndex();
      }
      
      private function onDropSkillsButtonClickHandler(param1:ButtonEvent) : void
      {
         dropSkillsS();
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onAlertIconRollOutHandler(param1:Event) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onAlertIconRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.PERSONAL_CASE_SKILLS_ACCTEACHINGOFSKILLBTN_NOTENOUGHFREEXP);
      }
      
      private function onUnloadBtnClickHandler(param1:ButtonEvent) : void
      {
         unloadTankmanS(data.inventoryID,data.currentVehicle.inventoryID);
      }
      
      private function onDismissBtnClickHandler(param1:ButtonEvent) : void
      {
         dismissTankmanS(data.inventoryID);
      }
      
      private function onSkillsBtnClickHandler(param1:ButtonEvent) : void
      {
         this.onChangeTabToTwoHandler();
      }
      
      private function onChangePassportHandler(param1:PersonalCaseEvent) : void
      {
         changeTankmanPassportS(data.inventoryID,param1.newTankmanFirstName.id,param1.newTankmanFirstName.group,param1.newTankmanLastName.id,param1.newTankmanLastName.group,param1.newIcon.id,param1.newIcon.group);
      }
      
      private function onChangeTabToTwoHandler(param1:PersonalCaseEvent = null) : void
      {
         var _loc2_:Boolean = !data.currentVehicle || data.currentVehicle && !data.currentVehicle.currentVehicleLocked;
         if(this.tabs.selectedIndex != 2 && _loc2_ && this.tabs.dataProvider.length > 1)
         {
            this.tabs.selectedIndex = 2;
         }
      }
      
      private function onGetTankmanIdHandler(param1:PersonalCaseEvent) : void
      {
         if(data.skills.length > 0)
         {
            param1.tankmanIdDelegate(data.inventoryID,data.skills[data.skills.length - 1].name);
         }
         else
         {
            param1.tankmanIdDelegate(data.inventoryID,"empty");
         }
      }
      
      private function onChangeRetrainVehicleHandler(param1:PersonalCaseEvent) : void
      {
         changeRetrainVehicleS(param1.vehicleId);
      }
      
      private function onEquipCrewSkinHandler(param1:PersonalCaseEvent) : void
      {
         equipCrewSkinS(param1.crewSkinID);
      }
      
      private function onUnequipCrewSkinHandler(param1:PersonalCaseEvent) : void
      {
         unequipCrewSkinS();
      }
      
      private function onTakeOffNewMarkFromCrewSkinHandler(param1:PersonalCaseEvent) : void
      {
         takeOffNewMarkFromCrewSkinS(param1.crewSkinID);
      }
      
      private function onChangeHistoricallyAccurateHandler(param1:PersonalCaseEvent) : void
      {
         changeHistoricallyAccurateS(param1.historicallyAccurate);
      }
      
      private function onPlayCrewSkinSoundHandler(param1:PersonalCaseEvent) : void
      {
         playCrewSkinSoundS(param1.crewSkinID);
      }
   }
}
