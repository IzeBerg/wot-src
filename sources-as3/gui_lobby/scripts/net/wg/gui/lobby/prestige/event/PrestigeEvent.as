package net.wg.gui.lobby.prestige.event
{
   import flash.events.Event;
   
   public class PrestigeEvent extends Event
   {
      
      public static const SHOW_TECHNIQUE_PROFILE:String = "ShowTechniqueProfile";
       
      
      private var _vehCD:int;
      
      public function PrestigeEvent(param1:String, param2:int)
      {
         super(param1,true);
         this._vehCD = param2;
      }
      
      override public function clone() : Event
      {
         return new PrestigeEvent(type,this._vehCD);
      }
      
      public function get vehCD() : int
      {
         return this._vehCD;
      }
   }
}
