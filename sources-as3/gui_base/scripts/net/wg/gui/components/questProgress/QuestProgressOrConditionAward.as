package net.wg.gui.components.questProgress
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class QuestProgressOrConditionAward extends QuestProgressOrCondition
   {
       
      
      public var labelTf:TextField = null;
      
      public var arrowBg:Sprite = null;
      
      public function QuestProgressOrConditionAward()
      {
         super();
         this.labelTf.text = PERSONAL_MISSIONS.CONDITIONS_ORGROUP;
         App.utils.commons.updateTextFieldSize(this.labelTf,true,false);
         var _loc1_:int = this.labelTf.width;
         this.labelTf.x = -_loc1_ >> 1;
      }
      
      override protected function onDispose() : void
      {
         this.labelTf = null;
         this.arrowBg = null;
         super.onDispose();
      }
   }
}
