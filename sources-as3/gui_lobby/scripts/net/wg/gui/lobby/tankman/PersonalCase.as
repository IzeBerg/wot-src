package net.wg.gui.lobby.tankman
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.TankmanCardVO;
   import net.wg.data.VO.TankmanSkillsVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
   import net.wg.data.constants.generated.PERSONALCASECONST;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.TankmanCard;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.controls.ActionPriceBg;
   import net.wg.gui.components.controls.TabButton;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.tankman.vo.PersonalCaseTabNameVO;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IUtils;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.utils.Padding;
   
   public class PersonalCase extends PersonalCaseBase
   {
      
      private static const INFO_BLOCKS_MARGIN:Number = 4;
      
      private static const WINDOW_PADDING_TOP:uint = 32;
      
      private static const WINDOW_PADDING_BOTTOM:uint = 18;
      
      private static const WINDOW_PADDING_LEFT:uint = 11;
      
      private static const TABS_PADDING_HORIZONTAL:uint = 9;
       
      
      public var tabButtonVisibleFalse:TabButton;
      
      public var role:TextField;
      
      public var tankmanCard:TankmanCard;
      
      public var tabs:ButtonBarEx;
      
      public var view:ViewStack;
      
      public var commanderFeature:PersonalCaseCommanderFeature;
      
      public var usingLevel:PersonalCaseUsingLevel;
      
      public var modifiers:PersonalCaseModifiers;
      
      public var specialization:PersonalCaseSpecialization;
      
      public var freeSkillsBlock:PersonalCaseFreeSkillsBlock;
      
      public var skillsBlock:PersonalCaseSkillsBlock;
      
      public var unloadBtn:ISoundButtonEx;
      
      public var dismissBtn:ISoundButtonEx;
      
      public var closeBtn:ISoundButtonEx;
      
      public var roleIcon:MovieClip;
      
      public var changeRoleBtn:ISoundButtonEx;
      
      public var changeRoleDiscountIcon:ActionPriceBg;
      
      private var _currentView:IViewStackContent;
      
      private var _currentNation:String = "";
      
      private var _tankmanInBattle:Boolean = false;
      
      private var _tabnames:Array;
      
      private var _crewSkinTabBtnWithCounter:Button = null;
      
      private var _counterManager:ICounterManager = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _tabsMaxWidth:Number = 0;
      
      public function PersonalCase()
      {
         super();
         showWindowBgForm = false;
         this._counterManager = App.utils.counterManager;
         this._toolTipMgr = App.toolTipMgr;
      }
      
      override protected function setCommonData(param1:PersonalCaseModel) : void
      {
         super.setCommonData(param1);
         this.openTabByID(param1.tabID);
      }
      
      override protected function onDispose() : void
      {
         this._toolTipMgr.hide();
         this._toolTipMgr = null;
         removeEventListener(PersonalCaseEvent.CHANGE_TAB,this.onChangeTabHandler);
         removeEventListener(PersonalCaseEvent.APPLY_RETRAINING,this.onApplyRetrainingHandler);
         removeEventListener(PersonalCaseEvent.GET_TANKMAN_ID,this.onGetTankmanIdHandler);
         removeEventListener(PersonalCaseEvent.TRAINING_SKILL,this.onTrainingSkillHandler);
         removeEventListener(PersonalCaseEvent.TRAINING_FREE_SKILL,this.onTrainingFreeSkillHandler);
         removeEventListener(PersonalCaseEvent.CHANGE_PASSPORT,this.onChangePassportHandler);
         removeEventListener(PersonalCaseEvent.EQUIP_CREW_SKIN,this.onEquipCrewSkinHandler);
         removeEventListener(PersonalCaseEvent.UNEQUIP_CREW_SKIN,this.onUnequipCrewSkinHandler);
         removeEventListener(PersonalCaseEvent.TAKE_OFF_NEW_MARK,this.onTakeOffNewMarkFromCrewSkinHandler);
         removeEventListener(PersonalCaseEvent.CHANGE_CREW_SKIN_HISTORICALLY_ACCURATE,this.onChangeHistoricallyAccurateHandler);
         removeEventListener(PersonalCaseEvent.PLAY_CREW_SKIN_SOUND,this.onPlayCrewSkinSoundHandler);
         removeEventListener(PersonalCaseEvent.TEACH_SKILL,this.onTeachSkillsHandler);
         removeEventListener(PersonalCaseEvent.DROP_SKILL,this.onDropSkillsHandler);
         removeEventListener(PersonalCaseEvent.INFO_BTN_CLICK,this.onInfoHandler);
         this.removeCrewSkinTabCount();
         this.unloadBtn.removeEventListener(ButtonEvent.CLICK,this.onUnloadBtnClickHandler);
         this.unloadBtn.dispose();
         this.unloadBtn = null;
         this.dismissBtn.removeEventListener(ButtonEvent.CLICK,this.onDismissBtnClickHandler);
         this.dismissBtn.dispose();
         this.dismissBtn = null;
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsClickIndexChangeHandler);
         this.tabs.dispose();
         this.tabs = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
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
         this.tabButtonVisibleFalse.dispose();
         this.tabButtonVisibleFalse = null;
         this.tankmanCard.dispose();
         this.tankmanCard = null;
         this.commanderFeature.dispose();
         this.commanderFeature = null;
         this.usingLevel.dispose();
         this.usingLevel = null;
         this.modifiers.dispose();
         this.modifiers = null;
         this.specialization.dispose();
         this.specialization = null;
         this.freeSkillsBlock.dispose();
         this.freeSkillsBlock = null;
         this.skillsBlock.dispose();
         this.skillsBlock = null;
         if(this._tabnames)
         {
            this._tabnames.splice(0,this._tabnames.length);
            this._tabnames = null;
         }
         this._currentView = null;
         this.roleIcon = null;
         this.role = null;
         super.onDispose();
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
         this.commanderFeature.visible = false;
         this._tabsMaxWidth = this.tabs.width;
         this.tabs.paddingHorizontal = TABS_PADDING_HORIZONTAL;
         this.tabs.enableOversize = true;
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsClickIndexChangeHandler);
         this.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
         addEventListener(PersonalCaseEvent.CHANGE_TAB,this.onChangeTabHandler);
         addEventListener(PersonalCaseEvent.APPLY_RETRAINING,this.onApplyRetrainingHandler,true);
         addEventListener(PersonalCaseEvent.GET_TANKMAN_ID,this.onGetTankmanIdHandler);
         addEventListener(PersonalCaseEvent.TRAINING_SKILL,this.onTrainingSkillHandler);
         addEventListener(PersonalCaseEvent.TRAINING_FREE_SKILL,this.onTrainingFreeSkillHandler);
         addEventListener(PersonalCaseEvent.CHANGE_PASSPORT,this.onChangePassportHandler);
         addEventListener(PersonalCaseEvent.EQUIP_CREW_SKIN,this.onEquipCrewSkinHandler);
         addEventListener(PersonalCaseEvent.UNEQUIP_CREW_SKIN,this.onUnequipCrewSkinHandler);
         addEventListener(PersonalCaseEvent.TAKE_OFF_NEW_MARK,this.onTakeOffNewMarkFromCrewSkinHandler);
         addEventListener(PersonalCaseEvent.CHANGE_CREW_SKIN_HISTORICALLY_ACCURATE,this.onChangeHistoricallyAccurateHandler);
         addEventListener(PersonalCaseEvent.PLAY_CREW_SKIN_SOUND,this.onPlayCrewSkinSoundHandler);
         addEventListener(PersonalCaseEvent.TEACH_SKILL,this.onTeachSkillsHandler);
         addEventListener(PersonalCaseEvent.DROP_SKILL,this.onDropSkillsHandler);
         addEventListener(PersonalCaseEvent.INFO_BTN_CLICK,this.onInfoHandler);
         this.unloadBtn.mouseEnabledOnDisabled = true;
         this.dismissBtn.mouseEnabledOnDisabled = true;
         this.changeRoleBtn.mouseEnabledOnDisabled = true;
         getDossierDataS();
         getCommonDataS();
         getRetrainingDataS();
         getFreeSkillsDataS();
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
         this.initializeGeneralProperties();
         if(window)
         {
            window.title = data.fullName + ", " + data.role + " - " + _loc1_.locale.makeString(MENU.TANKMANPERSONALCASE_TITLE);
         }
         this.initializeTabButton();
         validateNow();
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
         var _loc3_:PersonalCaseTabNameVO = null;
         var _loc4_:LabelData = null;
         var _loc6_:String = null;
         if(!this._tabnames || this._tabnames.length != data.tabsData.length)
         {
            this._tabnames = data.tabsData;
         }
         var _loc1_:Number = 0;
         var _loc2_:Array = [];
         this.tabButtonVisibleFalse.autoSize = TextFieldAutoSize.LEFT;
         this.tabButtonVisibleFalse.paddingHorizontal = this.tabs.paddingHorizontal;
         this.tabs.autoSize = TextFieldAutoSize.LEFT;
         var _loc5_:int = 0;
         while(_loc5_ < this._tabnames.length)
         {
            _loc3_ = this._tabnames[_loc5_];
            this.tabButtonVisibleFalse.label = App.utils.locale.makeString(_loc3_.label);
            this.tabButtonVisibleFalse.validateNow();
            _loc1_ += this.tabButtonVisibleFalse.width;
            _loc4_ = new LabelData();
            _loc4_.tabVO = _loc3_;
            _loc4_.label = App.utils.locale.makeString(_loc3_.label);
            _loc4_.width = this.tabButtonVisibleFalse.width;
            _loc2_[_loc2_.length] = _loc4_;
            _loc5_++;
         }
         if(_loc1_ > this._tabsMaxWidth)
         {
            while(_loc1_ > this._tabsMaxWidth)
            {
               _loc2_.sortOn(["width"],Array.NUMERIC | Array.DESCENDING);
               _loc4_ = _loc2_[0];
               _loc6_ = _loc4_.label;
               _loc1_ -= _loc4_.width;
               _loc4_.label = _loc6_.substr(0,_loc6_.length - 3) + Values.TWO_DOTS;
               this.tabButtonVisibleFalse.label = _loc4_.label;
               this.tabButtonVisibleFalse.validateNow();
               _loc4_.width = this.tabButtonVisibleFalse.width;
               _loc1_ += _loc4_.width;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc5_];
               _loc3_ = _loc4_.tabVO;
               _loc3_.label = _loc4_.label;
               _loc5_++;
            }
         }
         if(data.currentVehicle == null || !data.currentVehicle.currentVehicleLocked)
         {
            this.tabs.dataProvider = new DataProvider(this._tabnames);
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
         this.removeCrewSkinTabCount();
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
      
      private function removeCrewSkinTabCount() : void
      {
         if(this._crewSkinTabBtnWithCounter != null)
         {
            this._counterManager.removeCounter(this._crewSkinTabBtnWithCounter);
            this._crewSkinTabBtnWithCounter = null;
         }
      }
      
      private function initializeGeneralProperties() : void
      {
         var _loc4_:TankmanSkillsVO = null;
         this.role.text = data.role;
         this.roleIcon.gotoAndStop(data.roleType);
         var _loc1_:TankmanCardVO = new TankmanCardVO({});
         _loc1_.name = data.fullName;
         _loc1_.nation = this._currentNation;
         _loc1_.rank = data.rank;
         _loc1_.vehicle = Boolean(data.currentVehicle) ? data.currentVehicle.currentVehicleName + " " + App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.ERROR_TEXT,data.currentVehicle.currentVehicleLockMessage) : Values.EMPTY_STR;
         _loc1_.faceIcon = data.iconFile;
         _loc1_.rankIcon = data.rankIconFile;
         this.tankmanCard.model = _loc1_;
         this.tankmanCard.isVehicleLocked = data.currentVehicle && data.currentVehicle.currentVehicleLockMessage;
         var _loc2_:TankmanSkillsVO = new TankmanSkillsVO({});
         _loc2_.skills = data.skills;
         _loc2_.wg_freeXpToTankman = data.wg_freeXpToTankman;
         _loc2_.enoughFreeXPForTeaching = data.enoughFreeXPForTeaching;
         _loc2_.skillsCountForLearn = data.skillsCountForLearn;
         _loc2_.lastNewSkillExp = data.lastNewSkillExp;
         _loc2_.specializationLevel = data.specializationLevel;
         _loc2_.currentVehicle = data.currentVehicle;
         _loc2_.currentNation = this._currentNation;
         _loc2_.tankmanInBattle = this._tankmanInBattle;
         this.skillsBlock.model = _loc2_;
         if(data.freeSkills.length > 0)
         {
            _loc4_ = new TankmanSkillsVO({});
            _loc4_.skills = data.freeSkills;
            this.freeSkillsBlock.model = _loc4_;
            this.freeSkillsBlock.visible = true;
         }
         else
         {
            this.freeSkillsBlock.visible = false;
         }
         this.dismissBtn.tooltip = data.tooltipDismiss;
         this.unloadBtn.tooltip = data.tooltipUnload;
         this.changeRoleBtn.tooltip = data.tooltipChangeRole;
         var _loc3_:ActionPriceVO = data.actionChangeRole;
         this.changeRoleDiscountIcon.visible = _loc3_.useAction;
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
         this.usingLevel.setData(data.specializationLevel);
         this.modifiers.setData(data.modifiers,data.specializationLevel);
         this.specialization.setData(data.nativeVehicle.userName,data.nativeVehicle.contourIconFile);
         this.updateLayouts();
      }
      
      private function updateLayouts() : void
      {
         if(data.hasCommanderFeature)
         {
            this.usingLevel.y = Math.round(this.commanderFeature.y + this.commanderFeature.actualHeight + INFO_BLOCKS_MARGIN);
            this.commanderFeature.visible = true;
         }
         else
         {
            this.usingLevel.y = this.commanderFeature.y;
            this.commanderFeature.visible = false;
         }
         this.modifiers.y = Math.round(this.usingLevel.y + this.usingLevel.actualHeight + INFO_BLOCKS_MARGIN);
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
            param1.update(new PersonalCaseSkillsModel(skillsModel,data.isBootcamp,data.specializationLevel));
         }
         else if(param1 is PersonalCaseFreeSkills && freeSkillsModel)
         {
            param1.update(new PersonalCaseSkillsModel(freeSkillsModel,data.isBootcamp));
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
            _loc2_ = !data.currentVehicle || !data.currentVehicle.currentVehicleLocked;
            if(_loc1_.id == PERSONALCASECONST.STATS_TAB_ID || _loc2_)
            {
               this.view.show(_loc1_.linkage,_loc1_.linkage);
            }
         }
         this.skillsBlock.selectedTab = _loc1_.id;
         if(data.freeSkills.length > 0)
         {
            this.freeSkillsBlock.selectedTab = _loc1_.id;
         }
         this._currentView = this.view.currentView;
         this._currentView.addEventListener(PersonalCaseEvent.CHANGE_RETRAIN_VEHICLE,this.onChangeRetrainVehicleHandler);
         this.runtimeUpdateByInstance(this._currentView);
      }
      
      override protected function openTabByID(param1:String) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.tabs.dataProvider.length)
         {
            if(PersonalCaseTabNameVO(this.tabs.dataProvider[_loc2_]).id == param1)
            {
               this.tabs.selectedIndex = _loc2_;
               updateOpenedTabIDS(param1);
               break;
            }
            _loc2_++;
         }
      }
      
      private function onRoleDiscountOut(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onRoleDiscountOver(param1:MouseEvent) : void
      {
         var _loc2_:ActionPriceVO = data.actionChangeRole;
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,_loc2_.type,_loc2_.key,_loc2_.newPrices,_loc2_.oldPrices,_loc2_.isBuying,_loc2_.forCredits,_loc2_.rentPackage);
      }
      
      private function onChangeRoleBtnClickHandler(param1:ButtonEvent) : void
      {
         openChangeRoleWindowS();
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
      
      private function onTrainingFreeSkillHandler(param1:PersonalCaseEvent) : void
      {
         addTankmanFreeSkillS(data.inventoryID,param1.trainingSkillName);
      }
      
      private function onTabsClickIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:PersonalCaseTabNameVO = PersonalCaseTabNameVO(this.tabs.selectedItem);
         updateOpenedTabIDS(_loc2_.id);
         this.runtimeShowByIndex();
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onUnloadBtnClickHandler(param1:ButtonEvent) : void
      {
         unloadTankmanS(data.inventoryID,data.currentVehicle.inventoryID);
      }
      
      private function onDismissBtnClickHandler(param1:ButtonEvent) : void
      {
         dismissTankmanS(data.inventoryID);
      }
      
      private function onChangePassportHandler(param1:PersonalCaseEvent) : void
      {
         changeTankmanPassportS(data.inventoryID,param1.newTankmanFirstName.id,param1.newTankmanFirstName.group,param1.newTankmanLastName.id,param1.newTankmanLastName.group,param1.newIcon.id,param1.newIcon.group);
      }
      
      private function onChangeTabHandler(param1:PersonalCaseEvent = null) : void
      {
         var _loc2_:Boolean = !data.currentVehicle || data.currentVehicle && !data.currentVehicle.currentVehicleLocked;
         if(PersonalCaseTabNameVO(this.tabs.selectedItem).id != param1.relatedTabId && _loc2_ && this.tabs.dataProvider.length > 1)
         {
            this.openTabByID(param1.relatedTabId);
         }
         if(param1.scrollSkillsToLastItem && data.skills.length > 0)
         {
            this.skillsBlock.scrollListToLastItem();
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
      
      private function onTeachSkillsHandler(param1:PersonalCaseEvent) : void
      {
         openExchangeFreeToTankmanXpWindowS();
      }
      
      private function onDropSkillsHandler(param1:PersonalCaseEvent) : void
      {
         dropSkillsS();
      }
      
      private function onInfoHandler(param1:PersonalCaseEvent) : void
      {
         showFreeSkillsInfoS();
      }
   }
}

import net.wg.gui.lobby.tankman.vo.PersonalCaseTabNameVO;

class LabelData
{
    
   
   public var tabVO:PersonalCaseTabNameVO;
   
   public var label:String;
   
   public var width:Number;
   
   function LabelData()
   {
      super();
   }
}
