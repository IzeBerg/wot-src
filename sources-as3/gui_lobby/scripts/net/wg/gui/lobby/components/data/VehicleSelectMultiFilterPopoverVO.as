package net.wg.gui.lobby.components.data
{
   import net.wg.gui.components.popovers.data.VehicleSelectPopoverVO;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   
   public class VehicleSelectMultiFilterPopoverVO extends VehicleSelectPopoverVO
   {
       
      
      public function VehicleSelectMultiFilterPopoverVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function getVehicleSelectorFilterVO(param1:Object) : IVehicleSelectorFilterVO
      {
         return new VehicleSelectorMultiFilterVO(param1);
      }
   }
}
