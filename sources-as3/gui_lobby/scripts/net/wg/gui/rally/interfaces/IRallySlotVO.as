package net.wg.gui.rally.interfaces
{
   import net.wg.gui.interfaces.IRallyCandidateVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IRallySlotVO extends IDisposable
   {
       
      
      function get hasRestrictions() : Boolean;
      
      function get isClosed() : Boolean;
      
      function get rallyIdx() : Number;
      
      function get isCommanderState() : Boolean;
      
      function get isClosedVal() : Boolean;
      
      function get selectedVehicle() : VehicleVO;
      
      function set selectedVehicle(param1:VehicleVO) : void;
      
      function get selectedVehicleLevel() : int;
      
      function set selectedVehicleLevel(param1:int) : void;
      
      function get playerStatus() : int;
      
      function set playerStatus(param1:int) : void;
      
      function get rating() : String;
      
      function set rating(param1:String) : void;
      
      function get isCurrentUserInSlot() : Boolean;
      
      function get slotLabel() : String;
      
      function get canBeTaken() : Boolean;
      
      function get player() : IRallyCandidateVO;
      
      function get isFreezed() : Boolean;
      
      function get compatibleVehiclesCount() : int;
      
      function get isEvent() : Boolean;
      
      function get isLegionaries() : Boolean;
      
      function get isLocked() : Boolean;
      
      function get restrictions() : Array;
   }
}
