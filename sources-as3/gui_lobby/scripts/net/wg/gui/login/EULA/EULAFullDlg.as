package net.wg.gui.login.EULA
{
   import flash.events.Event;
   import net.wg.gui.components.controls.CheckBox;
   import scaleform.clik.utils.Constraints;
   
   public class EULAFullDlg extends EULADlg
   {
       
      
      public var agreeCheckBox:CheckBox;
      
      public function EULAFullDlg()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         constraints.addElement(this.agreeCheckBox.name,this.agreeCheckBox,Constraints.BOTTOM | Constraints.RIGHT);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         textArea.editable = false;
         textArea.selectable = true;
         textArea.textField.selectable = true;
         textArea.addEventListener(Event.SCROLL,this.handleScroll);
         applyButton.enabled = false;
         this.agreeCheckBox.enabled = false;
         this.agreeCheckBox.addEventListener(Event.SELECT,this.agreeCheckBoxHandler);
      }
      
      override protected function isAutoResize() : Boolean
      {
         return false;
      }
      
      override protected function onDispose() : void
      {
         textArea.removeEventListener(Event.SCROLL,this.handleScroll);
         this.agreeCheckBox.removeEventListener(Event.SELECT,this.agreeCheckBoxHandler);
         this.agreeCheckBox.dispose();
         super.onDispose();
      }
      
      private function handleScroll(param1:Event) : void
      {
         if(this.agreeCheckBox.enabled)
         {
            return;
         }
         if(textArea.textField.scrollV == textArea.textField.maxScrollV || !textArea.scrollBar.visible)
         {
            this.agreeCheckBox.enabled = true;
         }
      }
      
      private function agreeCheckBoxHandler(param1:Event) : void
      {
         applyButton.enabled = param1.target.selected;
      }
   }
}
