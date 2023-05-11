package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationCarouselScrollEvent extends Event
   {
      
      public static const AVAILABLE_PAGING:String = "availableScrolling";
       
      
      private var _leftScroll:Boolean;
      
      private var _rightScroll:Boolean;
      
      public function CustomizationCarouselScrollEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._leftScroll = param2;
         this._rightScroll = param3;
      }
      
      override public function clone() : Event
      {
         return new CustomizationCarouselScrollEvent(type,this._leftScroll,this._rightScroll,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomizationCarouselScrollEvent","type","leftScroll","rightScroll","bubbles","cancelable");
      }
      
      public function get leftScroll() : Boolean
      {
         return this._leftScroll;
      }
      
      public function get rightScroll() : Boolean
      {
         return this._rightScroll;
      }
   }
}
