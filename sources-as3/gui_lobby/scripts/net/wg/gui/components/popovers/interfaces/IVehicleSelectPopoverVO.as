package net.wg.gui.components.popovers.interfaces
{
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public interface IVehicleSelectPopoverVO extends IDisposable
   {
       
      
      function get tableHeaders() : DataProvider;
      
      function get header() : String;
      
      function set header(param1:String) : void;
      
      function get btnCancel() : String;
      
      function set btnCancel(param1:String) : void;
      
      function get isMultiSelect() : Boolean;
      
      function set isMultiSelect(param1:Boolean) : void;
      
      function get filters() : IVehicleSelectorFilterVO;
      
      function getVehicleSelectorFilterVO(param1:Object) : IVehicleSelectorFilterVO;
   }
}
