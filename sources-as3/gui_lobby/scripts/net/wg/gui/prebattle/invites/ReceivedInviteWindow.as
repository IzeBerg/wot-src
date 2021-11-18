package net.wg.gui.prebattle.invites
{
   import flash.text.TextField;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.prebattle.data.ReceivedInviteVO;
   import net.wg.gui.prebattle.meta.IReceivedInviteWindowMeta;
   import net.wg.gui.prebattle.meta.impl.ReceivedInviteWindowMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class ReceivedInviteWindow extends ReceivedInviteWindowMeta implements IReceivedInviteWindowMeta
   {
      
      private static const SIMPLE_INVITE_LABEL:String = "simple";
      
      private static const INVITE_WITH_NOTE_LABEL:String = "withNote";
      
      private static const BOTTOM_PADDING:int = 28;
       
      
      public var inviteTextArea:TextAreaSimple = null;
      
      public var messageTextArea:TextAreaSimple = null;
      
      public var noteTextField:TextField = null;
      
      public var inviteMessageLabel:TextField = null;
      
      public var inviteAddMessageLabel:TextField = null;
      
      public var acceptButton:SoundButtonEx = null;
      
      public var declineButton:SoundButtonEx = null;
      
      public var cancelButton:SoundButtonEx = null;
      
      private var _inviteVO:ReceivedInviteVO = null;
      
      public function ReceivedInviteWindow()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._inviteVO != null && isInvalid(InvalidationType.DATA))
         {
            this.updateComponents();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._inviteVO.isAcceptVisible && !this._inviteVO.isDeclineVisible)
            {
               this.acceptButton.x = this.declineButton.x;
            }
            this.cancelButton.y = this.acceptButton.y;
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         showWindowBgForm = false;
         window.useBottomBtns = true;
         var _loc1_:Padding = Padding(window.contentPadding);
         _loc1_.bottom = BOTTOM_PADDING;
         this.inviteMessageLabel.text = INVITES.GUI_LABELS_INVITETEXT;
         this.inviteAddMessageLabel.text = INVITES.GUI_LABELS_ADDITIONALTEXT;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.acceptButton.addEventListener(ButtonEvent.CLICK,this.onAcceptButtonClickHandler);
         this.declineButton.addEventListener(ButtonEvent.CLICK,this.onDeclineButtonClickHandler);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(window.updateSize);
         this.inviteTextArea.dispose();
         this.inviteTextArea = null;
         this.messageTextArea.dispose();
         this.messageTextArea = null;
         this.noteTextField = null;
         this.inviteMessageLabel = null;
         this.inviteAddMessageLabel = null;
         this.acceptButton.removeEventListener(ButtonEvent.CLICK,this.onAcceptButtonClickHandler);
         this.acceptButton.dispose();
         this.acceptButton = null;
         this.declineButton.removeEventListener(ButtonEvent.CLICK,this.onDeclineButtonClickHandler);
         this.declineButton.dispose();
         this.declineButton = null;
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.cancelButton.dispose();
         this.cancelButton = null;
         this.clearModel();
         super.onDispose();
      }
      
      public function as_setReceivedInviteInfo(param1:Object) : void
      {
         this.clearModel();
         this._inviteVO = new ReceivedInviteVO(param1);
         invalidateData();
      }
      
      public function as_setTitle(param1:String) : void
      {
         window.title = param1;
      }
      
      private function clearModel() : void
      {
         if(this._inviteVO != null)
         {
            this._inviteVO.dispose();
            this._inviteVO = null;
         }
      }
      
      private function updateComponents() : void
      {
         var _loc1_:String = !!this._inviteVO.hasNote() ? INVITE_WITH_NOTE_LABEL : SIMPLE_INVITE_LABEL;
         if(_loc1_ != currentFrameLabel)
         {
            gotoAndStop(_loc1_);
         }
         this.inviteTextArea.htmlText = this._inviteVO.text;
         this.messageTextArea.htmlText = this._inviteVO.comment;
         if(this.noteTextField != null)
         {
            this.noteTextField.text = this._inviteVO.note;
         }
         this.acceptButton.visible = this._inviteVO.isAcceptVisible;
         this.acceptButton.enabled = this._inviteVO.canAccept;
         this.declineButton.visible = this._inviteVO.isDeclineVisible;
         this.declineButton.enabled = this._inviteVO.canDecline;
         setSize(actualWidth,actualHeight);
         App.utils.scheduler.scheduleOnNextFrame(window.updateSize,width,height,true);
      }
      
      private function onAcceptButtonClickHandler(param1:ButtonEvent) : void
      {
         acceptInviteS();
      }
      
      private function onDeclineButtonClickHandler(param1:ButtonEvent) : void
      {
         declineInviteS();
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent) : void
      {
         cancelInviteS();
      }
   }
}
