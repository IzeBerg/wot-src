package net.wg.gui.battle.events
{
   import flash.events.Event;
   
   public class BattleSoundEvent extends Event
   {
      
      public static const ON_SOUND_PLAY:String = "onSound";
       
      
      public var soundType:String = "";
      
      public function BattleSoundEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         this.soundType = param2;
         super(param1,param3,param4);
      }
      
      override public function clone() : Event
      {
         return new BattleSoundEvent(type,this.soundType,bubbles,cancelable);
      }
   }
}
