package net.wg.gui.lobby.settings.events
{
   import flash.events.Event;
   
   public class AlternativeVoiceEvent extends Event
   {
      
      public static const ON_TEST_ALTERNATIVE_VOICES:String = "on_alternative_voices";
      
      public static const ON_TEST_ARTY_BULB_VOICES:String = "on_arty_bulb_voices";
      
      public static const ON_TEST_BULB_VOICES:String = "on_bulb_voices";
       
      
      public var id:int = -1;
      
      public function AlternativeVoiceEvent(param1:String, param2:int = -1, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.id = param2;
      }
      
      override public function clone() : Event
      {
         return new AlternativeVoiceEvent(type,this.id,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("AlternativeVoiceEvent","type","modeName","bubbles","cancelable","eventPhase");
      }
   }
}
