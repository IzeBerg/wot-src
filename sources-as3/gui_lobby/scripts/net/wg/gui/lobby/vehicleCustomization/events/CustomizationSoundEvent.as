package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationSoundEvent extends Event
   {
      
      public static const PLAY_SOUND:String = "CustomizationPlaySound";
       
      
      private var _sound:String = "";
      
      public function CustomizationSoundEvent(param1:String, param2:String, param3:Boolean = true, param4:Boolean = true)
      {
         super(param1,param3,param4);
         this._sound = param2;
      }
      
      override public function clone() : Event
      {
         return new CustomizationSoundEvent(type,this._sound,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomizationSoundEvent","type","sound","bubbles","cancelable");
      }
      
      public function get sound() : String
      {
         return this._sound;
      }
   }
}
