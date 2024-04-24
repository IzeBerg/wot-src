package net.wg.gui.cyberSport.views.unit
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.IRallySlotWithRating;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   
   public class SimpleSlotRenderer extends RallySimpleSlotRenderer implements IRallySlotWithRating
   {
      
      private static const TAKE_PLACE_FIRST_TIME_BTN_PADDING:Number = 14;
       
      
      public var lockBackground:Sprite = null;
      
      public var ratingTF:TextField = null;
      
      public function SimpleSlotRenderer()
      {
         badgeOffsetY = -3;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         takePlaceFirstTimeBtn.paddingHorizontal = TAKE_PLACE_FIRST_TIME_BTN_PADDING;
         userInfoTextLoadingController.setControlledUserRatingTextField(this.ratingTF);
      }
      
      override protected function onDispose() : void
      {
         this.lockBackground = null;
         this.ratingTF = null;
         super.onDispose();
      }
      
      public function setRatingLabelHtmlText(param1:String) : void
      {
         userInfoTextLoadingController.setUserRatingHtmlText(param1);
      }
      
      override public function set slotData(param1:IRallySlotVO) : void
      {
         super.slotData = param1;
         validateNow();
      }
      
      public function get ratingTextField() : TextField
      {
         return this.ratingTF;
      }
      
      public function get slotLabelTextField() : TextField
      {
         return slotLabel.textField;
      }
   }
}
