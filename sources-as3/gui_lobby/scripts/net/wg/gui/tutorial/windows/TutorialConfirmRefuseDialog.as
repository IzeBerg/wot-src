package net.wg.gui.tutorial.windows
{
   import flash.display.InteractiveObject;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.tutorial.meta.ITutorialConfirmRefuseDialogMeta;
   import net.wg.gui.tutorial.meta.impl.TutorialConfirmRefuseDialogMeta;
   
   public class TutorialConfirmRefuseDialog extends TutorialConfirmRefuseDialogMeta implements ITutorialConfirmRefuseDialogMeta
   {
       
      
      public var checkBox:CheckBox;
      
      public function TutorialConfirmRefuseDialog()
      {
         super();
      }
      
      override protected function drawData() : void
      {
         if(window)
         {
            window.title = _data.title;
         }
         if(messageField)
         {
            messageField.htmlText = _data.message;
         }
         if(this.checkBox)
         {
            this.checkBox.multiline = true;
            this.checkBox.wordWrap = true;
            this.checkBox.label = _data.checkBoxLabel;
            this.checkBox.selected = _data.doStartOnNextLogin;
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         if(_data)
         {
            window.title = _data.title;
         }
         window.useBottomBtns = true;
      }
      
      override protected function onDispose() : void
      {
         this.checkBox.dispose();
         this.checkBox = null;
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(submitBtn);
      }
      
      override protected function onSubmitButtonClick() : void
      {
         setStartOnNextLoginS(this.checkBox.selected);
         super.onSubmitButtonClick();
      }
   }
}
