package net.wg.gui.lobby.epicBattles.components.offlineView
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class Calendar extends MovieClip
   {
       
      
      public var calendarText:TextField = null;
      
      public var calendarImg:MovieClip = null;
      
      public function Calendar()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.calendarText = null;
         this.calendarImg = null;
      }
      
      public function setCalendarDateAsString(param1:String) : void
      {
         this.calendarText.text = param1;
      }
   }
}
