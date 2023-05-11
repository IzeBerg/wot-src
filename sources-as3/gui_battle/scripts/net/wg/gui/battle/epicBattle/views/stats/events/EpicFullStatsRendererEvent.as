package net.wg.gui.battle.epicBattle.views.stats.events
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class EpicFullStatsRendererEvent extends Event
   {
      
      public static const RENDERER_CLICKED:String = "rendererClicked";
       
      
      public var vehicleID:Number = 0;
      
      public var mEvent:MouseEvent = null;
      
      public function EpicFullStatsRendererEvent(param1:String, param2:Number, param3:MouseEvent, param4:Boolean = false, param5:Boolean = false)
      {
         this.vehicleID = param2;
         this.mEvent = param3;
         super(param1,param4,param5);
      }
      
      override public function clone() : Event
      {
         return new EpicFullStatsRendererEvent(type,this.vehicleID,this.mEvent,bubbles,cancelable);
      }
   }
}
