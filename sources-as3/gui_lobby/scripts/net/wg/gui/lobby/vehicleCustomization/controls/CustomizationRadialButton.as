package net.wg.gui.lobby.vehicleCustomization.controls
{
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetButtonsBlockVO;
   
   public class CustomizationRadialButton extends BlackButton
   {
      
      public static const ALPHA_VISIBLE_ON:int = 1;
      
      public static const ALPHA_VISIBLE_OFF:int = 0;
       
      
      public function CustomizationRadialButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         image.smoothing = true;
      }
      
      override protected function layoutContent(param1:int, param2:Number, param3:Number) : void
      {
         textField.x = -(textField.width >> 1);
      }
      
      public function toggleIndicatorEnable(param1:Boolean) : void
      {
         toggleIndicator.alpha = !!param1 ? Number(ALPHA_VISIBLE_ON) : Number(ALPHA_VISIBLE_OFF);
      }
      
      public function setVO(param1:CustomizationPropertiesSheetButtonsBlockVO) : void
      {
         data = param1.value;
         iconSource = param1.paletteIcon;
         label = param1.label;
         selected = param1.selected;
         enabled = param1.enable;
      }
   }
}
