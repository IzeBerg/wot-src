package net.wg.gui.lobby.missions.event
{
   import flash.events.Event;
   import net.wg.gui.lobby.missions.data.MissionDetailsPopUpPanelVO;
   
   public class MissionConditionRendererEvent extends Event
   {
      
      public static const CLICK:String = "RendererClick";
       
      
      private var _data:MissionDetailsPopUpPanelVO;
      
      public function MissionConditionRendererEvent(param1:String, param2:MissionDetailsPopUpPanelVO, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._data = param2;
      }
      
      override public function clone() : Event
      {
         return new MissionConditionRendererEvent(type,this._data,bubbles,cancelable);
      }
      
      public function get data() : MissionDetailsPopUpPanelVO
      {
         return this._data;
      }
   }
}
