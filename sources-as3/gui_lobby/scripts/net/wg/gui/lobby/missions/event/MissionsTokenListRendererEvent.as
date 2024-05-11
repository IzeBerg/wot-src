package net.wg.gui.lobby.missions.event
{
   import flash.events.Event;
   
   public class MissionsTokenListRendererEvent extends Event
   {
      
      public static const QUEST_RENDERER_CLICK:String = "questRendererClick";
       
      
      private var _idx:String = "";
      
      public function MissionsTokenListRendererEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._idx = param2;
      }
      
      override public function clone() : Event
      {
         return new MissionsTokenListRendererEvent(type,this._idx,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("MissionsTokenListRendererEvent","type","idx","bubbles","cancelable");
      }
      
      public function get idx() : String
      {
         return this._idx;
      }
   }
}
