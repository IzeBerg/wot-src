package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRecruitWindowMeta extends IEventDispatcher
   {
       
      
      function updateVehicleClassDropdownS(param1:Number) : void;
      
      function updateVehicleTypeDropdownS(param1:Number, param2:String) : void;
      
      function updateRoleDropdownS(param1:Number, param2:String, param3:Number) : void;
      
      function updateNationDropdownS() : void;
      
      function buyTankmanS(param1:Number, param2:Number, param3:String, param4:Number, param5:Number) : void;
      
      function updateAllDropdownsS(param1:Number, param2:String, param3:Number, param4:String) : void;
      
      function as_setVehicleClassDropdown(param1:Array) : void;
      
      function as_setVehicleTypeDropdown(param1:Array) : void;
      
      function as_setRoleDropdown(param1:Array) : void;
      
      function as_initData(param1:Object) : void;
      
      function as_setNations(param1:Array) : void;
      
      function as_setRecruitButtonsEnableState(param1:Boolean, param2:Boolean, param3:Boolean) : void;
      
      function as_setAllDropdowns(param1:Array, param2:Array, param3:Array, param4:Array) : void;
   }
}
