package net.wg.gui.rally.interfaces
{
   import net.wg.gui.interfaces.IExtendedUserVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IRallyVO extends IDisposable
   {
       
      
      function isAvailable() : Boolean;
      
      function get slotsArray() : Array;
      
      function get commanderExtendedUserVO() : IExtendedUserVO;
      
      function get description() : String;
      
      function set description(param1:String) : void;
      
      function get isCommander() : Boolean;
      
      function get canAssignToSlot() : Boolean;
      
      function get statusLbl() : String;
      
      function set statusLbl(param1:String) : void;
      
      function get canInvite() : Boolean;
      
      function set canInvite(param1:Boolean) : void;
      
      function get statusValue() : Boolean;
      
      function set statusValue(param1:Boolean) : void;
      
      function clearSlots() : void;
      
      function addSlot(param1:IRallySlotVO) : void;
      
      function hasSlotsData() : Boolean;
   }
}
