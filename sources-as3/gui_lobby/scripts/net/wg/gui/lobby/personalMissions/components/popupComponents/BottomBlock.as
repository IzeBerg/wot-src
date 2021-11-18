package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import flash.text.TextField;
   
   public class BottomBlock extends AwardSheetAcceptBtnCmp
   {
       
      
      public var descrTF:TextField;
      
      public function BottomBlock()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
         acceptBtn.label = PERSONAL_MISSIONS.FOURFREESHEETSOBTAINEDPOPUP_BUTTON;
      }
      
      override protected function onDispose() : void
      {
         this.descrTF = null;
         super.onDispose();
      }
      
      public function setDescription(param1:String) : void
      {
         this.descrTF.text = param1;
      }
   }
}
