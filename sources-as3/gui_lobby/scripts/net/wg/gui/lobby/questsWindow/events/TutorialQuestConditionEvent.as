package net.wg.gui.lobby.questsWindow.events
{
   import flash.events.Event;
   
   public class TutorialQuestConditionEvent extends Event
   {
      
      public static const ACTION_BUTTON_PRESSED:String = "actionButtonPressed";
       
      
      private var _id:String;
      
      private var _additionalType:String;
      
      public function TutorialQuestConditionEvent(param1:String, param2:String, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._id = param2;
         this._additionalType = param3;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get additionalType() : String
      {
         return this._additionalType;
      }
   }
}
