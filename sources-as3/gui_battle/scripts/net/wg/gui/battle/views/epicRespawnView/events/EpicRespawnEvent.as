package net.wg.gui.battle.views.epicRespawnView.events
{
   import flash.events.Event;
   
   public class EpicRespawnEvent extends Event
   {
      
      public static const VIEW_CHANGED:String = "respawnViewChanged";
      
      public static const DEPLOYMENT_BUTTON_READY:String = "respawnDeploymentButtonReady";
      
      public static const RESPAWN_LOCATION_SELECT:String = "respawnLocationSelect";
       
      
      private var _locationIdx:int = -1;
      
      public function EpicRespawnEvent(param1:String, param2:int = -1, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._locationIdx = param2;
      }
      
      public function get locationIdx() : int
      {
         return this._locationIdx;
      }
      
      override public function clone() : Event
      {
         return new EpicRespawnEvent(type,this._locationIdx,bubbles,cancelable);
      }
   }
}
