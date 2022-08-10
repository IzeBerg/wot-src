package net.wg.gui.events
{
   import flash.events.Event;
   
   public class DeviceEvent extends Event
   {
      
      public static const DEVICE_REMOVE:String = "deviceRemove";
      
      public static const DEVICE_DESTROY:String = "deviceDestroy";
      
      public static const DEVICE_BUY:String = "deviceBuy";
      
      public static const DEVICE_EQUIP:String = "deviceEquip";
      
      public static const DEVICE_UPGRADE:String = "deviceUpgrade";
       
      
      private var _deviceId:Number;
      
      public function DeviceEvent(param1:String, param2:Number)
      {
         super(param1,true,true);
         this._deviceId = param2;
      }
      
      override public function clone() : Event
      {
         return new DeviceEvent(type,this._deviceId);
      }
      
      public function get deviceId() : Number
      {
         return this._deviceId;
      }
   }
}
