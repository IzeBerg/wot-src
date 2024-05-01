package net.wg.infrastructure.base
{
   import flash.display.InteractiveObject;
   import net.wg.gui.components.common.ConfirmItemComponent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   
   public class AbstractConfirmItemDialog extends AbstractWindowView
   {
       
      
      public var content:ConfirmItemComponent = null;
      
      public function AbstractConfirmItemDialog()
      {
         super();
      }
      
      public function moveFocusToButton() : void
      {
         setFocus(this.content.submitBtn);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addListeners();
         this.setLabels();
         this.moveFocusToButton();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         this.moveFocusToButton();
      }
      
      override protected function onDispose() : void
      {
         if(this.content)
         {
            this.removeListeners();
            this.content.dispose();
            this.content = null;
         }
         super.onDispose();
      }
      
      protected function setLabels() : void
      {
      }
      
      protected function addListeners() : void
      {
         this.content.cancelBtn.addEventListener(ButtonEvent.CLICK,this.cancelBtnClickHandler,false,0,true);
         this.content.submitBtn.addEventListener(ButtonEvent.CLICK,this.submitBtnClickHandler,false,0,true);
         this.content.nsCount.addEventListener(IndexEvent.INDEX_CHANGE,this.selectedCountChangeHandler,false,0,true);
      }
      
      protected function selectedCountChangeHandler(param1:IndexEvent) : void
      {
      }
      
      protected function submitBtnClickHandler(param1:ButtonEvent) : void
      {
      }
      
      protected function cancelBtnClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      protected function removeListeners() : void
      {
         this.content.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.cancelBtnClickHandler);
         this.content.submitBtn.removeEventListener(ButtonEvent.CLICK,this.submitBtnClickHandler);
         this.content.nsCount.removeEventListener(IndexEvent.INDEX_CHANGE,this.selectedCountChangeHandler);
      }
   }
}
