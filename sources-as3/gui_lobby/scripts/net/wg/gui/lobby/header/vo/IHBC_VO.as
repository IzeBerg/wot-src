package net.wg.gui.lobby.header.vo
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IHBC_VO extends IDisposable
   {
       
      
      function get tooltip() : String;
      
      function get tooltipType() : String;
      
      function get tooltipArgs() : Array;
   }
}
