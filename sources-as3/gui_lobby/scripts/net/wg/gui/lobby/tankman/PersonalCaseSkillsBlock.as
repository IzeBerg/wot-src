package net.wg.gui.lobby.tankman
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.PERSONALCASECONST;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import scaleform.clik.events.ButtonEvent;
   
   public class PersonalCaseSkillsBlock extends PersonalCaseSkillsBlockBase
   {
      
      private static const MAX_SPECIALIZATION_LEVEL:uint = 100;
       
      
      public var alertIcon:UILoaderAlt;
      
      public var accTeachingOfSkillBtn:ISoundButtonEx;
      
      public var dropSkillsButton:ISoundButtonEx;
      
      public var skillsBtn:MovieClip;
      
      private var _isVehicleLocked:Boolean = false;
      
      public function PersonalCaseSkillsBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onAlertIconRollOverHandler);
         this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onAlertIconRollOutHandler);
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.accTeachingOfSkillBtn.removeEventListener(ButtonEvent.CLICK,this.onTeachSkillBtnClickHandler);
         this.accTeachingOfSkillBtn.dispose();
         this.accTeachingOfSkillBtn = null;
         this.dropSkillsButton.removeEventListener(ButtonEvent.CLICK,this.onDropSkillsButtonClickHandler);
         this.dropSkillsButton.dispose();
         this.dropSkillsButton = null;
         this.skillsBtn.removeEventListener(ButtonEvent.CLICK,this.onSkillsBtnClickHandler);
         this.skillsBtn = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         descrSkillButton.text = App.utils.locale.makeString(DIALOGS.ADDSKILLWINDOW_LABEL);
         this.alertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTICON;
         this.accTeachingOfSkillBtn.visible = false;
         this.accTeachingOfSkillBtn.enabled = false;
         this.accTeachingOfSkillBtn.mouseEnabledOnDisabled = true;
         this.dropSkillsButton.addEventListener(ButtonEvent.CLICK,this.onDropSkillsButtonClickHandler);
         this.dropSkillsButton.mouseEnabledOnDisabled = true;
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
               this.accTeachingOfSkillBtn.enabled = !data.tankmanInBattle;
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
      
      override protected function validateDate() : void
      {
         this._isVehicleLocked = data.currentVehicle && data.currentVehicle.currentVehicleLocked;
         this.dropSkillsButton.enabled = this.isEnableDropSkillsButton();
         if(this.dropSkillsButton.enabled)
         {
            this.dropSkillsButton.tooltip = TOOLTIPS.PERSONAL_CASE_SKILLS_DROPSKILLSBUTTON;
         }
         else
         {
            this.dropSkillsButton.tooltip = TOOLTIPS.PERSONAL_CASE_SKILLS_DROPSKILLSBUTTON_NOSKILL;
         }
         this.initializeSkillBtn(this._isVehicleLocked);
         super.validateDate();
      }
      
      private function isTeachingButtonEnable() : Boolean
      {
         return data.skills.length > 0 && data.skillsCountForLearn == 0 && this.isLearningSomething() && data.specializationLevel == MAX_SPECIALIZATION_LEVEL && data.enoughFreeXPForTeaching;
      }
      
      private function isLearningSomething() : Boolean
      {
         var _loc1_:CarouselTankmanSkillsModel = null;
         var _loc2_:uint = data.skills.length;
         if(_loc2_ > 0)
         {
            _loc1_ = CarouselTankmanSkillsModel(data.skills[_loc2_ - 1]);
            return _loc1_ && _loc1_.level < MAX_SPECIALIZATION_LEVEL;
         }
         return false;
      }
      
      private function isEnableDropSkillsButton() : Boolean
      {
         var _loc3_:Object = null;
         if(this._isVehicleLocked)
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
         this.skillsBtn.bg.flag_switcher.gotoAndPlay(data.currentNation);
         this.skillsBtn.addEventListener(ButtonEvent.CLICK,this.onSkillsBtnClickHandler);
      }
      
      private function onSkillsBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.CHANGE_TAB,true);
         _loc2_.relatedTabId = PERSONALCASECONST.SKILLS_TAB_ID;
         dispatchEvent(_loc2_);
      }
      
      private function onTeachSkillBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new PersonalCaseEvent(PersonalCaseEvent.TEACH_SKILL,true));
      }
      
      private function onDropSkillsButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new PersonalCaseEvent(PersonalCaseEvent.DROP_SKILL,true));
      }
      
      private function onAlertIconRollOutHandler(param1:Event) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onAlertIconRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.PERSONAL_CASE_SKILLS_ACCTEACHINGOFSKILLBTN_NOTENOUGHFREEXP);
      }
   }
}
