package net.wg.gui.lobby.epicBattles.components.offlineView
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class CenterBlock extends MovieClip
   {
      
      private static const DESCRIPTION_WIDTH:int = 360;
       
      
      public var calendar:Calendar = null;
      
      public var calendarSubTitle:TextField = null;
      
      public var calendarDescription:TextField = null;
      
      public function CenterBlock()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.calendar.dispose();
         this.calendar = null;
         this.calendarSubTitle = null;
         this.calendarDescription = null;
      }
      
      public function setData(param1:String, param2:String, param3:String) : void
      {
         this.calendarSubTitle.htmlText = param2;
         this.calendarDescription.htmlText = param3;
         this.calendarDescription.width = DESCRIPTION_WIDTH;
         this.calendar.setCalendarDateAsString(param1);
         App.utils.commons.updateTextFieldSize(this.calendarSubTitle,true,true);
         App.utils.commons.updateTextFieldSize(this.calendarDescription,false,true);
         var _loc4_:int = DESCRIPTION_WIDTH >= this.calendarSubTitle.width ? int(DESCRIPTION_WIDTH) : int(this.calendarSubTitle.width);
         this.calendar.x = _loc4_ - this.calendar.width >> 1;
         this.calendarSubTitle.x = _loc4_ - this.calendarSubTitle.width >> 1;
         this.calendarDescription.x = _loc4_ - DESCRIPTION_WIDTH >> 1;
      }
   }
}
