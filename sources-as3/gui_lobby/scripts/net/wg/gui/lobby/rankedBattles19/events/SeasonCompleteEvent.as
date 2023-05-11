package net.wg.gui.lobby.rankedBattles19.events
{
   import flash.events.Event;
   
   public class SeasonCompleteEvent extends Event
   {
      
      public static const NEXT_BTN_CLICK:String = "onNextBtnClick";
      
      public static const CLOSE_BTN_CLICK:String = "onCloseBtnClick";
      
      public static const START_INIT_DATA:String = "onStartInitData";
      
      public static const RESULT_BLOCK_READY:String = "onResultBlockReady";
       
      
      public function SeasonCompleteEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new SeasonCompleteEvent(type,bubbles,cancelable);
      }
   }
}
