package net.wg.gui.lobby.vehicleCustomization
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.vehicleCustomization.data.ConfirmCustomizationItemDialogVO;
   import net.wg.gui.lobby.window.ConfirmItemWindow;
   import net.wg.gui.lobby.window.ConfirmItemWindowVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ConfirmCustomizationItemDialog extends ConfirmItemWindow
   {
       
      
      public function ConfirmCustomizationItemDialog()
      {
         super();
      }
      
      override protected function getConfirmItemWindowVOForValue(param1:Object) : ConfirmItemWindowVO
      {
         return new ConfirmCustomizationItemDialogVO(param1);
      }
      
      override protected function onDispose() : void
      {
         data = null;
         super.onDispose();
      }
      
      override protected function setData(param1:ConfirmItemWindowVO) : void
      {
         data = param1;
         invalidateData();
      }
      
      override protected function applyData() : void
      {
         var _loc1_:ConfirmCustomizationItemDialogVO = ConfirmCustomizationItemDialogVO(data);
         App.utils.asserter.assertNotNull(_loc1_.smallSlotVO,"smallSlotVO" + Errors.CANT_NULL);
         var _loc2_:PropertySheetSeasonItemPopover = App.utils.classFactory.getComponent(Linkages.CUSTOMIZATION_SMALL_SLOT,PropertySheetSeasonItemPopover);
         _loc2_.setData(_loc1_.smallSlotVO);
         _loc2_.validateNow();
         content.setIcon(_loc2_,true);
         if(StringUtils.isNotEmpty(_loc1_.countLabel))
         {
            content.countLabel.text = _loc1_.countLabel;
         }
         super.applyData();
      }
   }
}
