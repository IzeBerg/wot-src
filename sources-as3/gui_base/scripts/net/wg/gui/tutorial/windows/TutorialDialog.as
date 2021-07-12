package net.wg.gui.tutorial.windows
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.tutorial.data.TutorialDialogVO;
   import net.wg.infrastructure.base.meta.ITutorialDialogMeta;
   import net.wg.infrastructure.base.meta.impl.TutorialDialogMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class TutorialDialog extends TutorialDialogMeta implements ITutorialDialogMeta
   {
       
      
      public var messageField:TextField;
      
      public var cancelBtn:SoundButtonEx;
      
      public var submitBtn:SoundButtonEx;
      
      protected var _data:TutorialDialogVO;
      
      public function TutorialDialog()
      {
         super();
      }
      
      override protected function setContent(param1:TutorialDialogVO) : void
      {
         this.setData(param1);
      }
      
      override protected function updateContent(param1:TutorialDialogVO) : void
      {
         this.setData(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.cancelBtn)
         {
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         }
         if(this.submitBtn)
         {
            this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitButtonClickHandler);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.drawData();
         }
      }
      
      override protected function onDispose() : void
      {
         this.tryClearData();
         if(this.cancelBtn)
         {
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
            this.cancelBtn.dispose();
            this.cancelBtn = null;
         }
         if(this.submitBtn)
         {
            this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitButtonClickHandler);
            this.submitBtn.dispose();
            this.submitBtn = null;
         }
         this.messageField = null;
         super.onDispose();
      }
      
      protected function drawData() : void
      {
         throw new AbstractException("drawData" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function onSubmitButtonClick() : void
      {
         submitS();
      }
      
      protected function onCancelButtonClick() : void
      {
         cancelS();
      }
      
      private function setData(param1:TutorialDialogVO) : void
      {
         this.tryClearData();
         this._data = param1;
         invalidate(InvalidationType.DATA);
      }
      
      private function tryClearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      protected function get data() : TutorialDialogVO
      {
         return this._data;
      }
      
      private function onSubmitButtonClickHandler(param1:Event) : void
      {
         this.onSubmitButtonClick();
      }
      
      private function onCancelButtonClickHandler(param1:Event) : void
      {
         this.onCancelButtonClick();
      }
   }
}
