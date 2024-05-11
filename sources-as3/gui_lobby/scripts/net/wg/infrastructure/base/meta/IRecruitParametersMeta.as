package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRecruitParametersMeta extends IEventDispatcher
   {
       
      
      function onNationChangedS(param1:Number) : void;
      
      function onVehicleClassChangedS(param1:String) : void;
      
      function onVehicleChangedS(param1:Number) : void;
      
      function onTankmanRoleChangedS(param1:String) : void;
      
      function setPredefinedTankmanS(param1:Object) : void;
      
      function as_setVehicleClassData(param1:Object) : void;
      
      function as_setVehicleData(param1:Object) : void;
      
      function as_setTankmanRoleData(param1:Object) : void;
      
      function as_setNationsData(param1:Object) : void;
   }
}
