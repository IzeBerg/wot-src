package net.wg.gui.lobby.components.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public interface IVehicleSelectorFilterVO extends IDisposable
   {
       
      
      function get vehicleTypesDP() : DataProvider;
      
      function get levelsDP() : DataProvider;
      
      function get nation() : int;
      
      function set nation(param1:int) : void;
      
      function get vehicleType() : String;
      
      function set vehicleType(param1:String) : void;
      
      function get isMain() : Boolean;
      
      function set isMain(param1:Boolean) : void;
      
      function get level() : int;
      
      function set level(param1:int) : void;
      
      function get compatibleOnly() : Boolean;
      
      function set compatibleOnly(param1:Boolean) : void;
      
      function get compatibleOnlyLabel() : String;
      
      function set compatibleOnlyLabel(param1:String) : void;
      
      function get nationDP() : DataProvider;
      
      function get visibility() : int;
      
      function set visibility(param1:int) : void;
   }
}
