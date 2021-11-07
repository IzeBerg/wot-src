package net.wg.gui.lobby.modulesPanel.interfaces
{
   import net.wg.gui.interfaces.ISoundButton;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.controls.Button;
   
   public interface IDeviceSlot extends IUpdatable, IPopOverCaller, IUIComponentEx, ISoundButton
   {
       
      
      function get type() : String;
      
      function set type(param1:String) : void;
      
      function get slotIndex() : int;
      
      function set slotIndex(param1:int) : void;
      
      function get slotData() : DeviceSlotVO;
      
      function get button() : Button;
      
      function get tooltip() : String;
      
      function set tooltip(param1:String) : void;
   }
}
