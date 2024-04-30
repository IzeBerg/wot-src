package net.wg.gui.cyberSport.controls.interfaces
{
   import net.wg.gui.interfaces.IResettable;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.rally.vo.VehicleVO;
   
   public interface IVehicleButton extends IResettable, ISoundButtonEx
   {
       
      
      function selectState(param1:Boolean, param2:String = null) : void;
      
      function setVehicle(param1:VehicleVO) : void;
      
      function get showAlertIcon() : Boolean;
      
      function set showAlertIcon(param1:Boolean) : void;
      
      function get showFrozenIcon() : Boolean;
      
      function set showFrozenIcon(param1:Boolean) : void;
      
      function get currentState() : int;
      
      function get vehicleCount() : int;
      
      function set vehicleCount(param1:int) : void;
      
      function get showCommanderSettings() : Boolean;
      
      function set showCommanderSettings(param1:Boolean) : void;
      
      function set currentViewType(param1:String) : void;
      
      function get currentViewType() : String;
      
      function set forceSoundEnable(param1:Boolean) : void;
      
      function get forceSoundEnable() : Boolean;
      
      function set showRangeRosterBg(param1:Boolean) : void;
      
      function get showRangeRosterBg() : Boolean;
   }
}
