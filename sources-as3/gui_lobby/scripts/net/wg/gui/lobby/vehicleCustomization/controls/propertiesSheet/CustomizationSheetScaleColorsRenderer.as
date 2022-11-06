package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.vehicleCustomization.controls.CustomizationRadialButton;
   import net.wg.gui.lobby.vehicleCustomization.events.propertiesSheet.CustomizationSheetRendererEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class CustomizationSheetScaleColorsRenderer extends CustomizationSheetBaseBtnRenderer
   {
       
      
      public function CustomizationSheetScaleColorsRenderer()
      {
         super();
      }
      
      private static function isClickLeftMouse(param1:MouseEvent) : Boolean
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         return _loc3_ == MouseEventEx.LEFT_BUTTON;
      }
      
      override protected function prepareBtn(param1:CustomizationRadialButton) : void
      {
         super.prepareBtn(param1);
         param1.toggle = true;
         param1.allowDeselect = false;
         param1.addEventListener(MouseEvent.CLICK,this.onBtnChangeClickHandler);
      }
      
      private function onBtnChangeClickHandler(param1:MouseEvent) : void
      {
         if(isClickLeftMouse(param1))
         {
            dispatchEvent(new CustomizationSheetRendererEvent(CustomizationSheetRendererEvent.ACTION_BTN_CLICK,model.actionType,btns.indexOf(param1.target)));
         }
      }
      
      override protected function onDispose() : void
      {
         btn0.removeEventListener(MouseEvent.CLICK,this.onBtnChangeClickHandler);
         btn1.removeEventListener(MouseEvent.CLICK,this.onBtnChangeClickHandler);
         btn2.removeEventListener(MouseEvent.CLICK,this.onBtnChangeClickHandler);
         super.onDispose();
      }
   }
}
