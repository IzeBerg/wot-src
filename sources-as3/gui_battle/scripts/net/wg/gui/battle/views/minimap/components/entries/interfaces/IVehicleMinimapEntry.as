package net.wg.gui.battle.views.minimap.components.entries.interfaces
{
   public interface IVehicleMinimapEntry
   {
       
      
      function showVehicleName() : void;
      
      function hideVehicleName() : void;
      
      function highlight() : void;
      
      function unhighlight() : void;
      
      function get vehicleID() : Number;
   }
}
