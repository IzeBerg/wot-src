package net.wg.gui.lobby.epicBattles.events
{
   import flash.events.Event;
   
   public class EpicBattlesSkillViewClickEvent extends Event
   {
      
      public static const SLOT_ITEM_CLICKED:String = "skillSlotClicked";
      
      public static const SKILL_LEVEL_UP_CLICKED:String = "skillLevelUpClicked";
       
      
      private var _skillID:int = 0;
      
      public function EpicBattlesSkillViewClickEvent(param1:String, param2:int, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._skillID = param2;
      }
      
      override public function clone() : Event
      {
         return new EpicBattlesSkillViewClickEvent(type,this._skillID,bubbles,cancelable);
      }
      
      public function get skillID() : int
      {
         return this._skillID;
      }
   }
}
