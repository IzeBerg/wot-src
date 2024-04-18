package net.wg.gui.lobby.components.events
{
   import flash.events.Event;
   import net.wg.gui.lobby.components.data.BoosterSlotVO;
   
   public class BoosterPanelEvent extends Event
   {
      
      public static const SLOT_SELECTED:String = "boosterSlotSelected";
       
      
      private var _data:BoosterSlotVO;
      
      public function BoosterPanelEvent(param1:String, param2:BoosterSlotVO, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._data = param2;
      }
      
      public function get data() : BoosterSlotVO
      {
         return this._data;
      }
   }
}
