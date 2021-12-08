package net.wg.gui.lobby.tankman
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.SKILLS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TankmanTrainingSmallButton;
   import net.wg.gui.lobby.tankman.vo.RetrainButtonVO;
   import net.wg.infrastructure.base.meta.ISkillDropMeta;
   import net.wg.infrastructure.base.meta.impl.SkillDropMeta;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.events.ButtonEvent;
   
   public class SkillDropWindow extends SkillDropMeta implements ISkillDropMeta
   {
      
      private static const INVALID_DATA:String = "invalidData";
      
      private static const SAVE_MODE_GROUP:String = "savingModeGroup";
      
      private static const MAX_SKILL:int = 100;
       
      
      public var beforeBlock:TankmanSkillsInfoBlock;
      
      public var afterBlock:TankmanSkillsInfoBlock;
      
      public var buttonCancel:SoundButtonEx;
      
      public var buttonDrop:SoundButtonEx;
      
      public var goldButton:TankmanTrainingSmallButton;
      
      public var creditsButton:TankmanTrainingSmallButton;
      
      public var freeButton:TankmanTrainingSmallButton;
      
      public var freeDropTf:TextField;
      
      public var model:SkillDropModel;
      
      private var _savingModeGroup:ButtonGroup;
      
      private var _isFirstInited:Boolean = false;
      
      private var _retrainingButtons:Vector.<TankmanTrainingSmallButton> = null;
      
      public function SkillDropWindow()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:TankmanTrainingSmallButton = null;
         super.initialize();
         this._retrainingButtons = new <TankmanTrainingSmallButton>[this.freeButton,this.creditsButton,this.goldButton];
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
         this._savingModeGroup.addButton(this.goldButton);
         this._savingModeGroup.addButton(this.creditsButton);
         this._savingModeGroup.addButton(this.freeButton);
         this._savingModeGroup.addEventListener(Event.CHANGE,this.onSavingModeGroupChangeHandler);
         this.buttonDrop.addEventListener(ButtonEvent.CLICK,this.onButtonDropClickHandler);
         this.buttonCancel.addEventListener(ButtonEvent.CLICK,this.onButtonCancelClickHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TankmanTrainingSmallButton = null;
         this.buttonDrop.removeEventListener(ButtonEvent.CLICK,this.onButtonDropClickHandler);
         this.buttonCancel.removeEventListener(ButtonEvent.CLICK,this.onButtonCancelClickHandler);
         this.beforeBlock.dispose();
         this.beforeBlock = null;
         this.afterBlock.dispose();
         this.afterBlock = null;
         this.buttonCancel.dispose();
         this.buttonCancel = null;
         this.buttonDrop.dispose();
         this.buttonDrop = null;
         this.goldButton = null;
         this.creditsButton = null;
         this.freeButton = null;
         this.freeDropTf = null;
         for each(_loc1_ in this._retrainingButtons)
         {
            _loc1_.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDropButtonDoubleClickHandler);
            _loc1_.dispose();
         }
         this._retrainingButtons.length = 0;
         this._retrainingButtons = null;
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
         var _loc1_:Boolean = false;
         super.draw();
         if(this.model && isInvalid(INVALID_DATA))
         {
            _loc1_ = this.model.skillsCount <= 1 && this.model.lastSkillLevel < 1;
            this.goldButton.visible = !_loc1_;
            this.creditsButton.visible = !_loc1_;
            this.freeButton.visible = !_loc1_;
            this.freeDropTf.visible = _loc1_;
            if(_loc1_)
            {
               this.freeDropTf.htmlText = this.model.freeDropText;
            }
            this.beforeBlock.nation = this.afterBlock.nation = this.model.nation;
            this.beforeBlock.tankmanName = this.afterBlock.tankmanName = this.model.tankmanName;
            this.beforeBlock.portraitSource = this.afterBlock.portraitSource = this.model.tankmanIcon;
            this.beforeBlock.roleSource = this.afterBlock.roleSource = this.model.roleIcon;
            this.beforeBlock.setRoleLevel(this.model.roleLevel);
            if(!this._isFirstInited)
            {
               this.autoSelectSavingMode();
               this._isFirstInited = true;
            }
            this.recalculateData();
         }
      }
      
      override protected function updateRetrainButtonsData(param1:Vector.<RetrainButtonVO>) : void
      {
         var _loc2_:Number = this._retrainingButtons.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._retrainingButtons[_loc3_].setData(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      private function autoSelectSavingMode() : void
      {
         var _loc1_:TankmanTrainingSmallButton = null;
         switch(this.model.defaultSavingMode)
         {
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
      
      override protected function setData(param1:SkillDropModel) : void
      {
         this.model = param1;
         invalidate(INVALID_DATA);
      }
      
      private function onSavingModeGroupChangeHandler(param1:Event) : void
      {
         this.recalculateData();
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
      }
   }
}
