package net.wg.gui.lobby.wgnc
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.meta.IWGNCPollWindowMeta;
   import net.wg.infrastructure.base.meta.impl.WGNCPollWindowMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class WGNCPollWindow extends WGNCPollWindowMeta implements IWGNCPollWindowMeta
   {
      
      private static const DESCRIPTION_BOTTOM_MARGIN:Number = 30;
      
      private static const BTN_BOTTON_MARGIN:Number = 20;
      
      private static const INVALID_CONTENT_SIZE:String = "invalidContentSize";
       
      
      public var descriptionTF:TextField = null;
      
      public var confirmBtn:SoundButtonEx = null;
      
      public var wndBounds:Sprite = null;
      
      private var _isTFClickedByMBR:Boolean = false;
      
      public function WGNCPollWindow()
      {
         super();
         this.descriptionTF.multiline = true;
         this.descriptionTF.wordWrap = true;
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.confirmBtn.addEventListener(ButtonEvent.CLICK,this.onApplyButtonClick);
         this.descriptionTF.addEventListener(TextEvent.LINK,this.onDescriptionLinkClickHandler);
         this.descriptionTF.addEventListener(MouseEvent.CLICK,this.oDescriptionTextClickHandler);
         App.utils.styleSheetManager.setLinkStyle(this.descriptionTF);
      }
      
      override protected function onDispose() : void
      {
         this.confirmBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyButtonClick);
         this.descriptionTF.removeEventListener(TextEvent.LINK,this.onDescriptionLinkClickHandler);
         this.descriptionTF.removeEventListener(MouseEvent.CLICK,this.oDescriptionTextClickHandler);
         this.confirmBtn.dispose();
         this.confirmBtn = null;
         this.descriptionTF = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_CONTENT_SIZE))
         {
            this.updateWindowSize();
         }
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.confirmBtn);
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         var _loc2_:Padding = null;
         super.setWindow(param1);
         if(window)
         {
            _loc2_ = new Padding(33,11,15,10);
            window.formBgPadding = _loc2_;
            window.getConstraints().scaleMode = ConstrainMode.COUNTER_SCALE;
         }
      }
      
      public function as_setButtonLbl(param1:String) : void
      {
         this.confirmBtn.label = param1;
      }
      
      public function as_setText(param1:String) : void
      {
         this.descriptionTF.htmlText = param1;
         this.descriptionTF.height = this.descriptionTF.textHeight + 4;
         this.confirmBtn.y = this.descriptionTF.y + this.descriptionTF.textHeight + DESCRIPTION_BOTTOM_MARGIN ^ 0;
         this.wndBounds.height = this.confirmBtn.y + this.confirmBtn.height + BTN_BOTTON_MARGIN;
         invalidate(INVALID_CONTENT_SIZE);
      }
      
      private function updateWindowSize() : void
      {
         window.updateSize(this.width,this.wndBounds.height,true);
      }
      
      public function as_setWindowTitle(param1:String) : void
      {
         window.title = param1;
      }
      
      private function onApplyButtonClick(param1:ButtonEvent) : void
      {
         onBtnClickS();
      }
      
      private function oDescriptionTextClickHandler(param1:MouseEvent) : void
      {
         this._isTFClickedByMBR = App.utils.commons.isRightButton(param1);
      }
      
      private function onDescriptionLinkClickHandler(param1:TextEvent) : void
      {
         if(this._isTFClickedByMBR)
         {
            return;
         }
         onLinkClickS(param1.text);
      }
   }
}
