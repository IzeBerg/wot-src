package net.wg.gui.dialogs
{
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class ButtonDialog extends SimpleDialog
   {
       
      
      private var _hasLeftMouseButtonBeenClicked:Boolean = false;
      
      public function ButtonDialog()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         textField.addEventListener(TextEvent.LINK,this.textLinkClickHandler);
         textField.addEventListener(MouseEvent.CLICK,this.textClickHandler);
         App.utils.styleSheetManager.setLinkStyle(textField);
         super.onPopulate();
      }
      
      override protected function onDispose() : void
      {
         textField.removeEventListener(TextEvent.LINK,this.textLinkClickHandler);
         textField.removeEventListener(MouseEvent.CLICK,this.textClickHandler);
         super.onDispose();
      }
      
      private function textClickHandler(param1:MouseEvent) : void
      {
         this._hasLeftMouseButtonBeenClicked = App.utils.commons.isLeftButton(param1);
      }
      
      private function textLinkClickHandler(param1:TextEvent) : void
      {
         if(this._hasLeftMouseButtonBeenClicked)
         {
            onButtonClickS(param1.text);
         }
      }
   }
}
