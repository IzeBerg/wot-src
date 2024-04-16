package net.wg.gui.lobby.dialogs
{
   public class PMConfirmationDialog extends IconDialog
   {
      
      private static const TF_BOTTOM_PADDING:Number = 30;
       
      
      public function PMConfirmationDialog()
      {
         super();
      }
      
      override protected function applyLayout() : void
      {
         super.applyLayout();
         textField.x = icon.x + icon.width;
      }
      
      override protected function getTextAreaCurrentHeight() : Number
      {
         return textField.textHeight + ADDITIONAL_MULTI_LINE_PADDING;
      }
      
      override protected function getBackgroundActualHeight() : Number
      {
         return super.getBackgroundActualHeight() + TF_BOTTOM_PADDING;
      }
   }
}
