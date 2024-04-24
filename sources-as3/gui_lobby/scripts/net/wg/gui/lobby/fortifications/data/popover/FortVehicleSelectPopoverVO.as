package net.wg.gui.lobby.fortifications.data.popover
{
   import net.wg.gui.lobby.components.data.VehicleSelectMultiFilterPopoverVO;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   
   public class FortVehicleSelectPopoverVO extends VehicleSelectMultiFilterPopoverVO
   {
       
      
      public function FortVehicleSelectPopoverVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function getVehicleSelectorFilterVO(param1:Object) : IVehicleSelectorFilterVO
      {
         return new FortVehicleSelectorFilterVO(param1);
      }
   }
}
