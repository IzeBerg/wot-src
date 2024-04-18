package net.wg.gui.login.impl
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.meta.ILoginQueueWindowMeta;
   import net.wg.infrastructure.base.meta.impl.LoginQueueWindowMeta;
   import scaleform.clik.events.ButtonEvent;
   
   public class LoginQueueWindow extends LoginQueueWindowMeta implements ILoginQueueWindowMeta
   {
      
      private static const DEFAULT_WIDTH:int = 160;
      
      private static const AUTOSEARCH_WIDTH:int = 120;
       
      
      public var cancelBtn:SoundButtonEx = null;
      
      public var autologinBtn:SoundButtonEx = null;
      
      public var titleField:TextField = null;
      
      public var messageTextField:TextField = null;
      
      private var isFirstUpdateStage:Boolean = true;
      
      public function LoginQueueWindow()
      {
         super();
         showWindowBgForm = false;
         showWindowBg = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.autologinBtn.label = WAITING.BUTTONS_AUTOSEARCH;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         var _loc3_:Number = App.appWidth - window.width >> 1;
         var _loc4_:Number = App.appHeight - window.height >> 1;
         if(!this.isFirstUpdateStage)
         {
            window.x = _loc3_;
            window.y = _loc4_;
         }
         else
         {
            this.isFirstUpdateStage = false;
         }
      }
      
      public function as_setTitle(param1:String) : void
      {
         this.titleField.htmlText = param1;
      }
      
      public function as_setMessage(param1:String) : void
      {
         this.messageTextField.htmlText = param1;
      }
      
      public function as_setCancelLabel(param1:String) : void
      {
         this.cancelBtn.label = param1;
      }
      
      public function as_showAutoLoginBtn(param1:Boolean) : void
      {
         if(param1)
         {
            this.autologinBtn.visible = true;
            this.cancelBtn.width = AUTOSEARCH_WIDTH;
            this.autologinBtn.x = (width - this.autologinBtn.width - this.cancelBtn.width) / 2;
            this.cancelBtn.x = this.autologinBtn.x + this.autologinBtn.width;
         }
         else
         {
            this.autologinBtn.visible = false;
            this.cancelBtn.width = DEFAULT_WIDTH;
            this.cancelBtn.x = (width - this.cancelBtn.width) / 2;
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler,false,0,true);
         this.autologinBtn.addEventListener(ButtonEvent.CLICK,this.onAutologinBtnClickHandler,false,0,true);
      }
      
      override protected function onDispose() : void
      {
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler,false);
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.autologinBtn.removeEventListener(ButtonEvent.CLICK,this.onAutologinBtnClickHandler,false);
         this.autologinBtn.dispose();
         this.autologinBtn = null;
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         if(this.autologinBtn.visible)
         {
            setFocus(this.autologinBtn);
         }
         else
         {
            setFocus(this.cancelBtn);
         }
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         onCancelClickS();
      }
      
      private function onAutologinBtnClickHandler(param1:ButtonEvent) : void
      {
         DebugUtils.LOG_DEBUG("onAutologinBtnClickHandler!!!!! in Flash");
         onAutoLoginClickS();
      }
   }
}
