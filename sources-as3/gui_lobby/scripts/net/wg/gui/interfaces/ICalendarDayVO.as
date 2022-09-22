package net.wg.gui.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ICalendarDayVO extends IDate, IDisposable
   {
       
      
      function get available() : Boolean;
      
      function get tooltipHeader() : String;
      
      function get tooltipBody() : String;
      
      function get iconSource() : String;
   }
}
