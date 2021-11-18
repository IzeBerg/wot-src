package net.wg.gui.lobby.modulesPanel.components
{
   import net.wg.gui.components.controls.listselection.AbstractListSelectionNavigator;
   import net.wg.gui.lobby.modulesPanel.data.DeviceVO;
   
   public class FittingListSelectionNavigator extends AbstractListSelectionNavigator
   {
       
      
      public function FittingListSelectionNavigator()
      {
         super();
      }
      
      override protected function isSelectable(param1:int) : Boolean
      {
         return !DeviceVO(getItemByIndex(param1)).disabled;
      }
   }
}
