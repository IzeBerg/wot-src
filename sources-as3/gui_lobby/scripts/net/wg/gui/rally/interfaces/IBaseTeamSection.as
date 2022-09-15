package net.wg.gui.rally.interfaces
{
   import net.wg.gui.rally.vo.ActionButtonVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IBaseTeamSection extends IDisposable
   {
       
      
      function setMemberVehicle(param1:uint, param2:uint, param3:VehicleVO) : void;
      
      function setMemberStatus(param1:uint, param2:uint) : void;
      
      function setOfflineStatus(param1:uint, param2:Boolean) : void;
      
      function updateMembers(param1:Boolean, param2:Array) : void;
      
      function enableFightButton(param1:Boolean) : void;
      
      function get actionButtonData() : ActionButtonVO;
      
      function set actionButtonData(param1:ActionButtonVO) : void;
      
      function set teamLabel(param1:String) : void;
      
      function set vehiclesLabel(param1:String) : void;
      
      function get vehiclesLabel() : String;
      
      function get rallyData() : IRallyVO;
      
      function set rallyData(param1:IRallyVO) : void;
      
      function get entireSelectArea() : Boolean;
      
      function set entireSelectArea(param1:Boolean) : void;
      
      function cooldownSlots(param1:Boolean) : void;
      
      function highlightSlots(param1:Array) : void;
      
      function setVehiclesInfoTooltipId(param1:String, param2:Object, param3:Object) : void;
   }
}
