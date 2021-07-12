package net.wg.gui.lobby.epicBattles.events
{
   import flash.events.Event;
   
   public class SkillLevelBarMouseEvent extends Event
   {
      
      public static const LEVEL_BAR_SECTION_OVER:String = "levelBarSectionOver";
       
      
      private var _overLevel:int = 0;
      
      public function SkillLevelBarMouseEvent(param1:String, param2:int, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._overLevel = param2;
      }
      
      override public function clone() : Event
      {
         return new SkillLevelBarMouseEvent(type,this._overLevel,bubbles,cancelable);
      }
      
      public function get overLevel() : int
      {
         return this._overLevel;
      }
   }
}
