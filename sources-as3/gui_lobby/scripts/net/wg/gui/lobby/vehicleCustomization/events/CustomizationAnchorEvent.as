package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   import net.wg.gui.lobby.vehicleCustomization.CustomizationEndPointIcon;
   
   public class CustomizationAnchorEvent extends Event
   {
      
      public static const SELECT_ANCHOR:String = "selectAnchorEvent";
      
      public static const LOCKED_ANCHOR:String = "lockedAnchorEvent";
      
      public static const OVER_ANCHOR:String = "overAnchorEvent";
      
      public static const OUT_ANCHOR:String = "outAnchorEvent";
      
      public static const DRAG_ANCHOR:String = "dragAnchorEvent";
       
      
      private var _anchor:CustomizationEndPointIcon = null;
      
      public function CustomizationAnchorEvent(param1:String, param2:CustomizationEndPointIcon, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._anchor = param2;
      }
      
      override public function clone() : Event
      {
         return new CustomizationAnchorEvent(type,this._anchor,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomizationAnchorEvent","eventType","anchor","bubbles","cancelable");
      }
      
      public function get anchor() : CustomizationEndPointIcon
      {
         return this._anchor;
      }
   }
}
