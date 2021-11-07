package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPersonalMissionsAwardsViewMeta extends IEventDispatcher
   {
       
      
      function showVehiclePreviewS() : void;
      
      function closeViewS() : void;
      
      function showMissionByVehicleTypeS(param1:String) : void;
      
      function buyMissionsByVehicleTypeS(param1:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setHeaderData(param1:Object) : void;
   }
}
