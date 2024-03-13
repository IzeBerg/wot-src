package net.wg.gui.battle.battleRoyale.views.shamrock.events
{
   import flash.events.Event;
   
   public class ShamrockAnimationEvent extends Event
   {
      
      public static const VALUE_ADDED:String = "valueAdded";
      
      public static const COMPLETED:String = "completed";
      
      public static const COLLECTED:String = "collected";
      
      public static const COLLECT_X3:String = "collectX3";
       
      
      private var _amount:int = -1;
      
      private var _totalValue:int = -1;
      
      private var _isFromTeamMate:Boolean = false;
      
      public function ShamrockAnimationEvent(param1:String, param2:int = 0, param3:int = 0, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this._amount = param2;
         this._totalValue = param3;
         this._isFromTeamMate = param4;
      }
      
      public function get totalValue() : int
      {
         return this._totalValue;
      }
      
      public function get isFromTeamMate() : Boolean
      {
         return this._isFromTeamMate;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
   }
}
