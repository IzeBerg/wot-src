package net.wg.gui.battle.views.epicScorePanel.events
{
   import flash.events.Event;
   
   public class EpicScorePanelEvent extends Event
   {
      
      public static const STATE_CHANGED:String = "epicScorePanelStateChanged";
      
      public static const SINGLE_ROW_STATE:String = "singleRowState";
      
      public static const DOUBLE_ROW_STATE:String = "doubleRowState";
      
      public static const PRE_BATTLE_TRANSITION_START:String = "prebattleTransition";
       
      
      private var _state:String = "";
      
      public function EpicScorePanelEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._state = param2;
      }
      
      override public function clone() : Event
      {
         return new EpicScorePanelEvent(type,this._state,bubbles,cancelable);
      }
      
      public function get state() : String
      {
         return this._state;
      }
   }
}
