package net.wg.gui.lobby.vehicleCustomization.controls
{
   import net.wg.gui.components.controls.listselection.AbstractListSelectionNavigator;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationRadioRendererVO;
   
   public class RadioButtonListSelectionNavigator extends AbstractListSelectionNavigator
   {
       
      
      public function RadioButtonListSelectionNavigator()
      {
         super();
      }
      
      override protected function isSelectable(param1:int) : Boolean
      {
         return CustomizationRadioRendererVO(getItemByIndex(param1)).enabled;
      }
   }
}
