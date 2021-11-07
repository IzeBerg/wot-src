package net.wg.gui.components.controls
{
   import flash.text.TextFieldAutoSize;
   
   public class CompactCheckBox extends CheckBox
   {
       
      
      public function CompactCheckBox()
      {
         super();
         constraintsDisabled = true;
         preventAutosizing = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints.removeElement("textField");
         textField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function updateAfterStateChange() : void
      {
         textField.autoSize = TextFieldAutoSize.LEFT;
         super.updateAfterStateChange();
      }
   }
}
