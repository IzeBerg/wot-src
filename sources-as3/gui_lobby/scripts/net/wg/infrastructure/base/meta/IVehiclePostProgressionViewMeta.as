package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehiclePostProgressionViewMeta extends IEventDispatcher
   {
       
      
      function onGoBackClickS() : void;
      
      function goToVehicleViewS() : void;
      
      function compareVehicleS() : void;
      
      function onAboutClickS() : void;
   }
}
