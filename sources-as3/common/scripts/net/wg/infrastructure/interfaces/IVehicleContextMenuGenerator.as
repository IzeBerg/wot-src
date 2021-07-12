package net.wg.infrastructure.interfaces
{
   import net.wg.data.daapi.ContextMenuVehicleVo;
   
   public interface IVehicleContextMenuGenerator
   {
       
      
      function generateData(param1:ContextMenuVehicleVo) : Vector.<IContextItem>;
   }
}
