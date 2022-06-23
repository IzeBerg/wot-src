package net.wg.gui.cyberSport.controls
{
   import net.wg.gui.components.controls.listselection.AbstractListSelectionNavigator;
   
   public class VehicleSelectorNavigator extends AbstractListSelectionNavigator
   {
       
      
      public function VehicleSelectorNavigator()
      {
         super();
      }
      
      override protected function isSelectable(param1:int) : Boolean
      {
         return getItemByIndex(param1).enabled;
      }
   }
}
