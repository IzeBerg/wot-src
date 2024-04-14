package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehCompareScrollEvent extends Event
   {
      
      public static const SCROLL_CHANGED:String = "ScrollChanged";
       
      
      private var _horizintalScrollPosition:int = -1;
      
      private var _verticalScrollPosition:int = -1;
      
      public function VehCompareScrollEvent(param1:String, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._horizintalScrollPosition = param2;
         this._verticalScrollPosition = param3;
      }
      
      public function get horizintalScrollPosition() : int
      {
         return this._horizintalScrollPosition;
      }
      
      public function get verticalScrollPosition() : int
      {
         return this._verticalScrollPosition;
      }
   }
}
