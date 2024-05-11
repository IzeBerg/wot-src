package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationBillLineRendererEvent extends Event
   {
      
      public static const UPDATE_MIN_WIDTH:String = "updateMinWidth";
       
      
      private var _widthDiff:int = 0;
      
      public function CustomizationBillLineRendererEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._widthDiff = param2;
      }
      
      public function get widthDiff() : int
      {
         return this._widthDiff;
      }
   }
}
