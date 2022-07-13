package net.wg.gui.lobby.tankman
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.SKILLS_CONSTANTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TankmanTrainingSmallButton;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.lobby.tankman.vo.RetrainButtonVO;
   import net.wg.infrastructure.base.meta.ISkillDropMeta;
   import net.wg.infrastructure.base.meta.impl.SkillDropMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.uilogger.epic_battle.EPIC_BATTLE_LOGGER_CONSTANTS;
   import net.wg.infrastructure.uilogger.epic_battle.SkillDropPageLogger;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.events.ButtonEvent;
   
   public class SkillDropWindow extends SkillDropMeta implements ISkillDropMeta
   {
      
      private static const SAVE_MODE_GROUP:String = "savingModeGroup";
      
      private static const MAX_SKILL:int = 100;
      
      private static const RECERTIFICATION_HIDDEN:int = 518;
      
      private static const RECERTIFICATION_VISIBLE:int = 625;
      
      private static const BLANKS_TEXT_SHIFT:int = 366;
      
      private static const BLANKS_DESCR_TEXT_SHIFT:int = 390;
      
      private static const BLANKS_TEXTS_GAP:int = 3;
      
      private static const BLANK_TOOLTIP_ID:int = 13461;
       
      
      public var beforeBlock:TankmanSkillsInfoBlock;
      
      public var afterBlock:TankmanSkillsInfoBlock;
      
      public var buttonCancel:SoundButtonEx;
      
      public var buttonDrop:SoundButtonEx;
      
      public var blankButton:TankmanTrainingSmallButton;
      
      public var goldButton:TankmanTrainingSmallButton;
      
      public var creditsButton:TankmanTrainingSmallButton;
      
      public var freeButton:TankmanTrainingSmallButton;
      
      public var blankIcon:MovieClip;
      
      public var blanksTf:TextField;
      
      public var blanksDescrTf:TextField;
      
      public var freeDropTf:TextField;
      
      public var model:SkillDropModel;
      
      private var _savingModeGroup:ButtonGroup;
      
      private var _isSmallState:Boolean = false;
      
      private var _retrainingButtons:Vector.<TankmanTrainingSmallButton> = null;
      
      private var _buttonsData:Vector.<RetrainButtonVO> = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _logger:SkillDropPageLogger = null;
      
      public function SkillDropWindow()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:TankmanTrainingSmallButton = null;
         super.initialize();
         this._retrainingButtons = new <TankmanTrainingSmallButton>[this.freeButton,this.creditsButton,this.goldButton,this.blankButton];
         for each(_loc1_ in this._retrainingButtons)
         {
            _loc1_.groupName = SAVE_MODE_GROUP;
            _loc1_.scopeType = TankmanTrainingSmallButton.DROP_SKILLS;
            _loc1_.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDropButtonDoubleClickHandler);
            _loc1_.allowDeselect = false;
            _loc1_.doubleClickEnabled = true;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._savingModeGroup = new ButtonGroup(SAVE_MODE_GROUP,this);
         this._savingModeGroup.addButton(this.blankButton);
         this._savingModeGroup.addButton(this.goldButton);
         this._savingModeGroup.addButton(this.creditsButton);
         this._savingModeGroup.addButton(this.freeButton);
         this._savingModeGroup.addEventListener(Event.CHANGE,this.onSavingModeGroupChangeHandler);
         this._logger = new SkillDropPageLogger();
         this.buttonDrop.addEventListener(ButtonEvent.CLICK,this.onButtonDropClickHandler);
         this.buttonCancel.addEventListener(ButtonEvent.CLICK,this.onButtonCancelClickHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TankmanTrainingSmallButton = null;
         App.utils.scheduler.cancelTask(this.updateWindowSize);
         this.buttonDrop.removeEventListener(ButtonEvent.CLICK,this.onButtonDropClickHandler);
         this.buttonCancel.removeEventListener(ButtonEvent.CLICK,this.onButtonCancelClickHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.beforeBlock.dispose();
         this.beforeBlock = null;
         this.afterBlock.dispose();
         this.afterBlock = null;
         this.buttonCancel.dispose();
         this.buttonCancel = null;
         this.buttonDrop.dispose();
         this.buttonDrop = null;
         this.blankButton = null;
         this.goldButton = null;
         this.creditsButton = null;
         this.freeButton = null;
         this.blankIcon = null;
         this.blanksTf = null;
         this.blanksDescrTf = null;
         this.freeDropTf = null;
         for each(_loc1_ in this._retrainingButtons)
         {
            if(_loc1_)
            {
               _loc1_.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDropButtonDoubleClickHandler);
               _loc1_.dispose();
            }
         }
         this._retrainingButtons.length = 0;
         this._retrainingButtons = null;
         this._buttonsData = null;
         this._tooltipMgr = null;
         if(this._logger)
         {
            this._logger.stopPageLog();
            this._logger.dispose();
            this._logger = null;
         }
         if(this._savingModeGroup)
         {
            this._savingModeGroup.removeEventListener(Event.CHANGE,this.onSavingModeGroupChangeHandler);
            this._savingModeGroup.dispose();
            this._savingModeGroup = null;
         }
         this.model = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
         window.title = MENU.SKILLDROPWINDOW_TITLE;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.model)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.validateData();
               this.validateButtonsData();
               this._logger.startPageLog();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.validateLayout();
            }
         }
      }
      
      override protected function updateRetrainButtonsData(param1:Vector.<RetrainButtonVO>) : void
      {
         this._buttonsData = param1;
         invalidateData();
      }
      
      override protected function setData(param1:SkillDropModel) : void
      {
         this.model = param1;
         invalidate(InvalidationType.DATA,InvalidationType.LAYOUT);
      }
      
      protected function validateLayout() : void
      {
         if(this.blanksTf)
         {
            this.blanksTf.x = Math.round(BLANKS_TEXT_SHIFT - this.blanksTf.width);
         }
         if(this.blanksDescrTf)
         {
            this.blanksDescrTf.x = this.model.blanks > 0 ? Number(Math.round(this.blanksTf.x - this.blanksDescrTf.width - BLANKS_TEXTS_GAP)) : Number(Math.round(BLANKS_DESCR_TEXT_SHIFT - this.blanksDescrTf.width));
         }
         if(this._isSmallState)
         {
            this.buttonCancel.y = this.buttonDrop.y = RECERTIFICATION_HIDDEN;
         }
         else
         {
            this.buttonCancel.y = this.buttonDrop.y = RECERTIFICATION_VISIBLE;
         }
         App.utils.scheduler.scheduleOnNextFrame(this.updateWindowSize);
      }
      
      protected function validateData() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         _loc1_ = this.model.skillsCount <= 1 && this.model.lastSkillLevel < 1;
         this.goldButton.visible = !_loc1_;
         this.creditsButton.visible = !_loc1_;
         this.freeButton.visible = !_loc1_;
         this.freeDropTf.visible = _loc1_;
         this.beforeBlock.nation = this.afterBlock.nation = this.model.nation;
         this.beforeBlock.tankmanName = this.afterBlock.tankmanName = this.model.tankmanName;
         this.beforeBlock.portraitSource = this.afterBlock.portraitSource = this.model.tankmanIcon;
         this.beforeBlock.roleSource = this.afterBlock.roleSource = this.model.roleIcon;
         this.beforeBlock.setRoleLevel(this.model.roleLevel);
         this._isSmallState = this.model.recertificationStatus == SKILLS_CONSTANTS.RECERTIFICATION_HIDDEN || _loc1_;
         if(this._isSmallState)
         {
            gotoAndStop(SKILLS_CONSTANTS.RECERTIFICATION_HIDDEN);
         }
         else
         {
            gotoAndStop(SKILLS_CONSTANTS.RECERTIFICATION_USABLE);
            _loc2_ = this.model.blanks > 0;
            this.blanksTf.text = this.model.blanks.toString();
            this.blanksDescrTf.htmlText = !!_loc2_ ? App.utils.locale.makeString(MENU.SKILLDROPWINDOW_INSTORAGE) : App.utils.locale.makeString(MENU.SKILLDROPWINDOW_NOTAVAILABLE);
            this.blankIcon.visible = this.blanksTf.visible = _loc2_;
            this.blanksTf.autoSize = this.blanksDescrTf.autoSize = TextFieldAutoSize.RIGHT;
         }
         if(this.model.recertificationStatus == SKILLS_CONSTANTS.RECERTIFICATION_VISIBLE_DISABLED)
         {
            this.blankButton.mouseEnabledOnDisabled = true;
            this.blankButton.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDropButtonDoubleClickHandler);
         }
         if(_loc1_)
         {
            this.freeDropTf.htmlText = this.model.freeDropText;
         }
         this.autoSelectSavingMode();
         this.recalculateData();
      }
      
      private function validateButtonsData() : void
      {
         if(!this._buttonsData)
         {
            return;
         }
         var _loc1_:Number = this._retrainingButtons.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._retrainingButtons[_loc2_].setData(this._buttonsData[_loc2_]);
            _loc2_++;
         }
      }
      
      private function updateWindowSize() : void
      {
         height = this.actualHeight;
         window.invalidate(Window.INVALID_SRC_VIEW);
      }
      
      private function autoSelectSavingMode() : void
      {
         var _loc1_:TankmanTrainingSmallButton = null;
         switch(this.model.defaultSavingMode)
         {
            case SkillDropModel.SAVING_MODE_BLANK:
               _loc1_ = this.blankButton;
               break;
            case SkillDropModel.SAVING_MODE_GOLD:
               _loc1_ = this.goldButton;
               break;
            case SkillDropModel.SAVING_MODE_CREDITS:
               _loc1_ = this.creditsButton;
               break;
            default:
               _loc1_ = this.freeButton;
         }
         this._savingModeGroup.selectedButton = _loc1_;
         if(_loc1_.enabled)
         {
            _loc1_.selected = true;
         }
      }
      
      private function getSelectedDropCostInfo() : DropSkillsCost
      {
         var _loc1_:DropSkillsCost = null;
         switch(this._savingModeGroup.selectedButton)
         {
            case this.blankButton:
               _loc1_ = this.model.dropSkillBlank;
               break;
            case this.goldButton:
               _loc1_ = this.model.dropSkillGold;
               break;
            case this.creditsButton:
               _loc1_ = this.model.dropSkillCredits;
               break;
            case this.freeButton:
               _loc1_ = this.model.dropSkillFree;
         }
         return _loc1_;
      }
      
      private function recalculateData() : void
      {
         var _loc1_:DropSkillsCost = this.getSelectedDropCostInfo();
         var _loc2_:Array = calcDropSkillsParamsS(this.model.compactDescriptor,_loc1_.xpReuseFraction);
         var _loc3_:Number = _loc2_[0];
         var _loc4_:int = _loc3_ >= MAX_SKILL ? int(_loc2_[1]) : int(-1);
         var _loc5_:Number = _loc2_[2];
         this.beforeBlock.setSkills(this.model.skillsCount,this.model.preLastSkill,this.model.lastSkill,this.model.lastSkillLevel,this.model.hasNewSkill,this.model.newSkillsCount,this.model.lastNewSkillLevel);
         var _loc6_:String = _loc4_ > 1 ? SKILLS_CONSTANTS.TYPE_NEW_SKILL : null;
         var _loc7_:String = SKILLS_CONSTANTS.TYPE_NEW_SKILL;
         var _loc8_:Boolean = this.model.skillsCount > _loc4_;
         this.afterBlock.setSkills(_loc4_,_loc6_,_loc7_,_loc5_,_loc8_);
         this.afterBlock.setRoleLevel(this.model.roleLevel,_loc3_);
      }
      
      private function showBlanksTooltip() : void
      {
         this._tooltipMgr.showSpecial.apply(TOOLTIPS_CONSTANTS.EPIC_BATTLE_RECERTIFICATION_FORM_TOOLTIP,[TOOLTIPS_CONSTANTS.EPIC_BATTLE_RECERTIFICATION_FORM_TOOLTIP,null].concat([BLANK_TOOLTIP_ID]));
         this._logger.startTooltipLog(EPIC_BATTLE_LOGGER_CONSTANTS.ACTIVE_STATE);
      }
      
      private function showDisabledBlanksTooltip() : void
      {
         this._tooltipMgr.show(MENU.SKILLDROPWINDOW_TOOLTIP_VISIBLEDISABLED);
         this._logger.startTooltipLog(EPIC_BATTLE_LOGGER_CONSTANTS.DISABLED_STATE);
      }
      
      private function onSavingModeGroupChangeHandler(param1:Event) : void
      {
         this.recalculateData();
         this._logger.currencySelectLog(this.getSelectedDropCostInfo().id);
      }
      
      private function onDropButtonDoubleClickHandler(param1:MouseEvent) : void
      {
         this.onButtonDropClickHandler(null);
      }
      
      private function onButtonCancelClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onButtonDropClickHandler(param1:ButtonEvent) : void
      {
         dropSkillsS(this.getSelectedDropCostInfo().id);
         this._logger.dropSkillClickLog(this.getSelectedDropCostInfo().id);
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(!this.enabled)
         {
            return;
         }
         if(param1.target == this.blankButton)
         {
            if(this.model.recertificationStatus === SKILLS_CONSTANTS.RECERTIFICATION_VISIBLE_DISABLED)
            {
               this.showDisabledBlanksTooltip();
            }
            else
            {
               this.showBlanksTooltip();
            }
         }
         else if(param1.target == this.blankIcon)
         {
            this.showBlanksTooltip();
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
         if(param1.target == this.blankButton || param1.target == this.blankIcon)
         {
            this._logger.stopTooltipLog();
         }
      }
   }
}
