package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRoleChangeMeta extends IEventDispatcher
   {
       
      
      function onVehicleSelectedS(param1:int) : void;
      
      function changeRoleS(param1:String, param2:int) : void;
      
      function as_setCommonData(param1:Object) : void;
      
      function as_setRoles(param1:Array) : void;
      
      function as_setPrice(param1:String, param2:Object) : void;
   }
}
