package net.wg.gui.components.interfaces
{
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IVehicleSelectorFilter extends IUIComponentEx
   {
       
      
      function setData(param1:IVehicleSelectorFilterVO) : void;
   }
}
