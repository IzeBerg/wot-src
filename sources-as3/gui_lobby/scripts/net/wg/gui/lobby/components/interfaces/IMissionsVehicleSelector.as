package net.wg.gui.lobby.components.interfaces
{
   import net.wg.infrastructure.base.meta.IMissionsVehicleSelectorMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IMissionsVehicleSelector extends IMissionsVehicleSelectorMeta, IUIComponentEx, IDAAPIModule
   {
       
      
      function get isOpen() : Boolean;
      
      function set isOpen(param1:Boolean) : void;
      
      function setVehicleSelectorCarouselAlias(param1:String) : void;
   }
}
