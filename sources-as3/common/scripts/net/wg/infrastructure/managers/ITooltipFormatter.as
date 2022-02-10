package net.wg.infrastructure.managers
{
   public interface ITooltipFormatter
   {
       
      
      function addHeader(param1:String, param2:Boolean = false) : ITooltipFormatter;
      
      function addBody(param1:String, param2:Boolean = false) : ITooltipFormatter;
      
      function addNote(param1:String, param2:Boolean = false) : ITooltipFormatter;
      
      function addAttention(param1:String, param2:Boolean = false) : ITooltipFormatter;
      
      function make() : String;
   }
}
