package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehiclePreviewCrewTabMeta extends IEventDispatcher
   {
       
      
      function setActiveStateS(param1:Boolean) : void;
      
      function getTooltipDataS(param1:int) : Array;
      
      function as_setData(param1:Object) : void;
   }
}
