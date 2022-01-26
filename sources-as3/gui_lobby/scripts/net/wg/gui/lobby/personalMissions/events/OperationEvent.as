package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class OperationEvent extends Event
   {
      
      public static const SIZE_CHANGED:String = "sizeChanged";
      
      public static const CLICK:String = "clicqqk";
      
      public static const AWARDS_BTN_CLICK:String = "awardsBtnClick";
      
      public static const INFO_BTN_CLICK:String = "infoBtnClick";
       
      
      public var id:int = -1;
      
      public var pmType:int = -1;
      
      public function OperationEvent(param1:String, param2:int = -1, param3:int = -1, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.id = param2;
         this.pmType = param3;
      }
      
      override public function clone() : Event
      {
         return new OperationEvent(type,this.id,this.pmType,bubbles,cancelable);
      }
   }
}
