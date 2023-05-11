package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehConfSkillEvent extends Event
   {
      
      public static const SKILL_SELECT:String = "skillSelect";
       
      
      private var _skillType:String;
      
      private var _slotIndex:int;
      
      private var _selected:Boolean;
      
      public function VehConfSkillEvent(param1:String, param2:String, param3:int, param4:Boolean, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this._skillType = param2;
         this._slotIndex = param3;
         this._selected = param4;
      }
      
      public function get skillType() : String
      {
         return this._skillType;
      }
      
      public function get slotIndex() : int
      {
         return this._slotIndex;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
   }
}
