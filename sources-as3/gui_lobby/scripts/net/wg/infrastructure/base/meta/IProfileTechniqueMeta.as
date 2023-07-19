package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IProfileTechniqueMeta extends IEventDispatcher
   {
       
      
      function setSelectedTableColumnS(param1:int, param2:String) : void;
      
      function showVehiclesRatingS() : void;
      
      function as_responseVehicleDossier(param1:Object) : void;
      
      function as_setRatingButton(param1:Object) : void;
      
      function as_setBtnCounters(param1:Array) : void;
   }
}
