package net.wg.gui.notification
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.notification.constants.MessageMetrics;
   import net.wg.gui.notification.vo.MessageInfoVO;
   import net.wg.gui.notification.vo.NotificationDialogInitInfoVO;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.infrastructure.base.meta.ISystemMessageDialogMeta;
   import net.wg.infrastructure.base.meta.impl.SystemMessageDialogMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   
   public class SystemMessageDialog extends SystemMessageDialogMeta implements ISystemMessageDialogMeta
   {
      
      private static const DATA_INVALID:String = "dataInv";
      
      private static const DIMENSIONS_INVALID:String = "dimInv";
      
      private static const ICON_POSITION_INV:String = "iconPosInv";
      
      private static const INIT_DATA_INVALID:String = "initDataInv";
       
      
      public var icon:UILoaderAlt;
      
      public var textField:TextField;
      
      public var bgMc:Sprite;
      
      public var closeBtn:SoundButtonEx;
      
      private var messageData:NotificationInfoVO;
      
      private var initInfo:NotificationDialogInitInfoVO;
      
      private var dimensionsInitialized:Boolean;
      
      public function SystemMessageDialog()
      {
         super();
         showWindowBgForm = false;
         this.visible = false;
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         if(param1)
         {
            invalidate(DIMENSIONS_INVALID);
            invalidate(INIT_DATA_INVALID);
         }
      }
      
      override protected function setMessageData(param1:NotificationInfoVO) : void
      {
         this.messageData = param1;
         invalidate(DATA_INVALID);
      }
      
      override protected function setInitData(param1:NotificationDialogInitInfoVO) : void
      {
         this.initInfo = param1;
         invalidate(INIT_DATA_INVALID);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = this.dimensionsInitialized;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.textField.multiline = true;
         this.textField.wordWrap = true;
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.iconLoadingCompleteHandler,false,0,true);
         this.icon.addEventListener(UILoaderEvent.IOERROR,this.iconLoadingErrorHandler,false,0,true);
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.closeButtonClickHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:MessageInfoVO = null;
         super.draw();
         if(this.messageData && isInvalid(DATA_INVALID))
         {
            _loc1_ = this.messageData.messageVO;
            if(_loc1_.icon)
            {
               this.icon.source = _loc1_.icon;
            }
            this.textField.htmlText = _loc1_.message;
            invalidate(DIMENSIONS_INVALID);
            invalidate(ICON_POSITION_INV);
         }
         if(isInvalid(DIMENSIONS_INVALID) && window)
         {
            this.bgMc.height = Math.round(this.textField.height + MessageMetrics.WINDOW_BOTTOM_PADDING);
            this.closeBtn.y = this.bgMc.height + 3;
            this.height = this.closeBtn.y + this.closeBtn.height;
            App.utils.scheduler.scheduleOnNextFrame(this.refreshWindowSize);
         }
         if(isInvalid(ICON_POSITION_INV))
         {
            if(this.textField.textHeight < this.icon.height)
            {
               this.icon.y = Math.round(this.textField.y + (-this.icon.height + this.textField.height) / 2) + MessageMetrics.ICON_DEFAULT_PADDING_Y;
            }
         }
         if(isInvalid(INIT_DATA_INVALID) && window)
         {
            window.title = this.initInfo.title;
            this.closeBtn.label = this.initInfo.closeBtnTitle;
            if(this.initInfo.settings.timeout > 0)
            {
               App.utils.scheduler.scheduleTask(onWindowCloseS,this.initInfo.settings.timeout);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(onWindowCloseS);
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.iconLoadingCompleteHandler);
         this.icon.removeEventListener(UILoaderEvent.IOERROR,this.iconLoadingErrorHandler);
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.closeButtonClickHandler);
         this.messageData = null;
         this.initInfo = null;
         super.onDispose();
      }
      
      private function refreshWindowSize() : void
      {
         UIComponent(window).invalidate(Window.INVALID_SRC_VIEW);
         this.dimensionsInitialized = true;
         this.visible = this.dimensionsInitialized;
         window.validateNow();
      }
      
      private function closeButtonClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function iconLoadingErrorHandler(param1:UILoaderEvent) : void
      {
         this.icon.alpha = 0;
      }
      
      private function iconLoadingCompleteHandler(param1:UILoaderEvent) : void
      {
         var _loc2_:int = MessageMetrics.ICON_DEFAULT_PADDING_X;
         this.icon.x = _loc2_ + Math.max(0,Math.round((this.textField.x - _loc2_ - this.icon.width) / 2));
         invalidate(ICON_POSITION_INV);
      }
   }
}
