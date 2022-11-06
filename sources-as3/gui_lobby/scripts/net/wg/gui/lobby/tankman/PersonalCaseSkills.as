package net.wg.gui.lobby.tankman
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.events.PersonalCaseEvent;
   
   public class PersonalCaseSkills extends PersonalCaseFreeSkills
   {
       
      
      public var emptySkillsBG:MovieClip;
      
      public var emptySkillsMessage:TextField;
      
      private var hasNewSkill:Boolean = false;
      
      public function PersonalCaseSkills()
      {
         super();
      }
      
      override public function update(param1:Object) : void
      {
         this.hasNewSkill = false;
         super.update(param1);
      }
      
      override protected function onDispose() : void
      {
         this.emptySkillsBG = null;
         this.emptySkillsMessage = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.emptySkillsMessage.text = MENU.TANKMSNPERSONALCASE_LOADINGINFO;
      }
      
      override protected function updateState() : void
      {
         super.updateState();
         if(model.length > 0)
         {
            this.emptySkillsBG.visible = this.emptySkillsMessage.visible = false;
         }
         else
         {
            this.emptySkillsMessage.text = MENU.TANKMSNPERSONALCASE_LACKOFSKILLSFORLEARN;
            this.emptySkillsBG.visible = this.emptySkillsMessage.visible = true;
         }
      }
      
      override protected function get selectButtonVisibility() : Boolean
      {
         if(!model)
         {
            return false;
         }
         var _loc1_:int = 0;
         while(_loc1_ < model.length)
         {
            if(model[_loc1_].hasNewSkills)
            {
               this.hasNewSkill = true;
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      override protected function learnSkillDispatchEvent() : void
      {
         if(!this.hasNewSkill || !selectedSkillName)
         {
            return;
         }
         var _loc1_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.TRAINING_SKILL,true);
         _loc1_.trainingSkillName = selectedSkillName;
         dispatchEvent(_loc1_);
         selectedSkillName = null;
         updateSelectBtn();
      }
   }
}
