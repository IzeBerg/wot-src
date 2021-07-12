package net.wg.gui.bootcamp.messageWindow.views
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.bootcamp.messageWindow.controls.MessageCostContainer;
   import net.wg.gui.bootcamp.messageWindow.events.MessageViewEvent;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.utils.IUtils;
   import scaleform.clik.events.ButtonEvent;
   
   public class MessageViewLinesBuy extends MessageViewBase
   {
      
      private static const OUT_FRAME:int = 9;
      
      private static const SEPARATOR_Y:int = 215;
       
      
      public var btnExecute:UniversalBtn = null;
      
      public var btnCancel:UniversalBtn = null;
      
      public var lockIcon:MovieClip = null;
      
      public var glow:MovieClip = null;
      
      public var cost:MessageCostContainer = null;
      
      public var separator:MovieClip = null;
      
      private var _utils:IUtils = null;
      
      private var _isUnlockComplete:Boolean = false;
      
      public function MessageViewLinesBuy()
      {
         super();
         animContainerBtnContinue.visible = false;
         addFrameScript(totalFrames - OUT_FRAME,this.onAnimationComplete);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._utils = App.utils;
         animContainerTitle.gotoAndPlay(IN_STATE);
      }
      
      override protected function onDispose() : void
      {
         addFrameScript(totalFrames - OUT_FRAME,null);
         this.btnExecute.removeEventListener(ButtonEvent.CLICK,this.onBtnExecuteClickHandler);
         this.btnExecute.dispose();
         this.btnExecute = null;
         this.btnCancel.removeEventListener(ButtonEvent.CLICK,this.onBtnCancelClickHandler);
         this.btnCancel.dispose();
         this.btnCancel = null;
         this.lockIcon = null;
         this.glow = null;
         this.cost.dispose();
         this.cost = null;
         this.separator = null;
         this._utils = null;
         super.onDispose();
      }
      
      override protected function setDescription() : void
      {
         animContainerDescription.htmlText = messageData.message;
      }
      
      override protected function updateContent() : void
      {
         super.updateContent();
         this.btnExecute.label = messageData.labelExecute;
         this.btnCancel.label = BOOTCAMP.BTN_CANCEL;
         if(!messageData.isTraining)
         {
            this._utils.universalBtnStyles.setStyle(this.btnExecute,!!messageData.isBuy ? UniversalBtnStylesConst.STYLE_HEAVY_ORANGE : UniversalBtnStylesConst.STYLE_HEAVY_LIME);
         }
         else
         {
            this._utils.universalBtnStyles.setStyle(this.btnExecute,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
            this.separator.y = SEPARATOR_Y;
         }
         this._utils.universalBtnStyles.setStyle(this.btnCancel,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
         this.cost.updateContent(messageData.costValue,messageData.isBuy);
         this.cost.visible = !messageData.isTraining;
         this.lockIcon.visible = !messageData.isBuy && !messageData.isTraining;
         this.glow.visible = true;
         this.btnExecute.enabled = true;
         this.btnCancel.enabled = true;
         this._isUnlockComplete = false;
      }
      
      override public function getFocusTarget() : InteractiveObject
      {
         return this.btnExecute;
      }
      
      override protected function onPressAnyKeyHandler() : void
      {
         super.onPressAnyKeyHandler();
         this.btnExecute.addEventListener(ButtonEvent.CLICK,this.onBtnExecuteClickHandler);
         this.btnCancel.addEventListener(ButtonEvent.CLICK,this.onBtnCancelClickHandler);
      }
      
      private function onUnlockComplete() : void
      {
         setExecuteState(false);
         this.lockIcon.addFrameScript(this.lockIcon.totalFrames - 1,null);
         this.lockIcon.visible = false;
      }
      
      private function onBtnExecuteClickHandler(param1:Event) : void
      {
         if(this.lockIcon.visible)
         {
            this.lockIcon.addFrameScript(this.lockIcon.totalFrames - 1,this.onUnlockComplete);
            this.lockIcon.gotoAndPlay(ACCEPT_STATE);
            this._isUnlockComplete = true;
         }
         else
         {
            setExecuteState(true);
         }
         this.btnExecute.enabled = false;
         this.btnCancel.enabled = false;
         this.btnExecute.removeEventListener(ButtonEvent.CLICK,this.onBtnExecuteClickHandler);
      }
      
      private function onBtnCancelClickHandler(param1:Event) : void
      {
         this.btnCancel.removeEventListener(ButtonEvent.CLICK,this.onBtnCancelClickHandler);
         setOutState();
      }
      
      private function onAnimationComplete() : void
      {
         animContainerTitle.gotoAndPlay(OUT_STATE);
         this.btnExecute.visible = false;
         this.btnCancel.visible = false;
         this.lockIcon.visible = false;
         this.separator.visible = false;
         if(this._isUnlockComplete)
         {
            animContainerTitle.visible = false;
            this.cost.visible = false;
            dispatchEvent(new MessageViewEvent(MessageViewEvent.MESSAGE_EXECUTED));
         }
      }
   }
}
