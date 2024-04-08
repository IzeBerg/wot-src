package net.wg.gui.battle.battleRoyale.views.playersPanel
{
   import flash.events.Event;
   
   public class RespawnIconEvent extends Event
   {
      
      public static const ALPHA_CHANGE:String = "alphaChange";
       
      
      private var _teamIndex:int = -1;
      
      private var _alpha:Number = 1.0;
      
      public function RespawnIconEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1, param5:Number = 1.0)
      {
         super(param1,param2,param3);
         this._teamIndex = param4;
         this._alpha = param5;
      }
      
      public function get teamIndex() : int
      {
         return this._teamIndex;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
   }
}
