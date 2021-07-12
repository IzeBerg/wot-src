package net.wg.gui.bootcamp.messageWindow
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import net.wg.gui.bootcamp.messageWindow.data.MessageContentVO;
   import net.wg.gui.bootcamp.messageWindow.events.MessageViewEvent;
   import net.wg.gui.bootcamp.messageWindow.interfaces.IMessageView;
   import net.wg.gui.bootcamp.messageWindow.views.MessageViewBase;
   import net.wg.gui.components.windows.Window;
   import net.wg.infrastructure.base.DefaultWindowGeometry;
   import net.wg.infrastructure.base.meta.IBCMessageWindowMeta;
   import net.wg.infrastructure.base.meta.impl.BCMessageWindowMeta;
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Padding;
   
   public class BCMessageWindow extends BCMessageWindowMeta implements IBCMessageWindowMeta
   {
      
      private static const STAGE_RESIZED:String = "stageResized";
      
      private static const BLUR_XY:int = 20;
       
      
      public var messageContainer:MovieClip = null;
      
      private var _contentRenderer:MessageViewBase;
      
      private var _messagesQueue:Vector.<MessageContentVO>;
      
      private var _messageIndex:uint;
      
      private var _renderLinkage:String;
      
      private var _blurWindows:Vector.<DisplayObject>;
      
      public function BCMessageWindow()
      {
         super();
         showWindowBgForm = false;
         showWindowBg = false;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         invalidate(STAGE_RESIZED);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         App.toolTipMgr.hide();
         geometry.positionStrategy = DefaultWindowGeometry.POSITION_ALWAYS;
         window.contentPadding = new Padding();
         this.updatePositions();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._messagesQueue && isInvalid(InvalidationType.DATA))
         {
            this.createMessage();
         }
         if(this._contentRenderer && isInvalid(STAGE_RESIZED))
         {
            this._contentRenderer.setSize(App.appWidth,App.appHeight);
            this.updatePositions();
         }
      }
      
      override protected function setMessageData(param1:Vector.<MessageContentVO>) : void
      {
         this._messageIndex = 0;
         this._messagesQueue = param1;
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.clearBlurWindows();
         this.disposeMessageView();
         this.messageContainer = null;
         this._messagesQueue = null;
         super.onDispose();
      }
      
      override protected function onClosingApproved() : void
      {
         super.onClosingApproved();
         if(this._contentRenderer)
         {
            this._contentRenderer.tryToClose();
         }
      }
      
      public function as_blurOtherWindows(param1:int) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:DisplayObject = null;
         this.clearBlurWindows();
         this._blurWindows = new Vector.<DisplayObject>(0);
         var _loc2_:ISimpleManagedContainer = App.containerMgr.getContainer(param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_.numChildren;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = _loc2_.getChildAt(_loc4_);
               if(!(_loc5_ is Window && (_loc5_ as Window).sourceView == this))
               {
                  this._blurWindows.push(_loc5_);
                  _loc5_.filters = [new BlurFilter(BLUR_XY,BLUR_XY,BitmapFilterQuality.MEDIUM)];
               }
               _loc4_++;
            }
         }
      }
      
      private function updatePositions() : void
      {
         this.messageContainer.x = _width >> 1;
         this.messageContainer.y = _height >> 1;
      }
      
      private function createMessage() : void
      {
         var _loc1_:MessageContentVO = this._messagesQueue[this._messageIndex];
         var _loc2_:String = _loc1_.messagePreset;
         if(this._renderLinkage != _loc2_)
         {
            if(this._contentRenderer)
            {
               this.disposeMessageView();
            }
            this._renderLinkage = _loc2_;
            this._contentRenderer = App.utils.classFactory.getComponent(this._renderLinkage,IMessageView);
            this.messageContainer.addChild(this._contentRenderer);
            this._contentRenderer.addEventListener(MessageViewEvent.MESSAGE_REMOVED,this.onContentRendererMessageRemovedHandler);
            this._contentRenderer.addEventListener(MessageViewEvent.MESSAGE_OPEN_NATIONS,this.onContentRendererMessageOpenNationsHandler);
            this._contentRenderer.addEventListener(MessageViewEvent.MESSAGE_DISAPPEAR,this.onContentRendererMessageDisappearHandler);
            this._contentRenderer.addEventListener(MessageViewEvent.MESSAGE_EXECUTED,this.onContentRendererMessageExecutedHandler);
            this._contentRenderer.addEventListener(MessageViewEvent.REWARD_ANIMATION_START,this.onContentRendererRewardAnimationStartHandler);
         }
         this._contentRenderer.setSize(App.appWidth,App.appHeight);
         this._contentRenderer.setMessageData(_loc1_);
         setFocus(this._contentRenderer.getFocusTarget());
         onMessageAppearS(this._renderLinkage);
      }
      
      private function disposeMessageView() : void
      {
         this._contentRenderer.stop();
         this._contentRenderer.removeEventListener(MessageViewEvent.MESSAGE_REMOVED,this.onContentRendererMessageRemovedHandler);
         this._contentRenderer.removeEventListener(MessageViewEvent.MESSAGE_OPEN_NATIONS,this.onContentRendererMessageOpenNationsHandler);
         this._contentRenderer.removeEventListener(MessageViewEvent.MESSAGE_DISAPPEAR,this.onContentRendererMessageDisappearHandler);
         this._contentRenderer.removeEventListener(MessageViewEvent.MESSAGE_EXECUTED,this.onContentRendererMessageExecutedHandler);
         this._contentRenderer.removeEventListener(MessageViewEvent.REWARD_ANIMATION_START,this.onContentRendererRewardAnimationStartHandler);
         this.messageContainer.removeChild(DisplayObject(this._contentRenderer));
         this._contentRenderer.dispose();
         this._contentRenderer = null;
      }
      
      private function clearBlurWindows() : void
      {
         var _loc1_:DisplayObject = null;
         if(this._blurWindows)
         {
            while(this._blurWindows.length)
            {
               _loc1_ = this._blurWindows.pop();
               _loc1_.filters = [];
            }
            this._blurWindows = null;
         }
      }
      
      private function onContentRendererMessageOpenNationsHandler(param1:Event) : void
      {
         onMessageButtonClickedS();
      }
      
      private function onContentRendererMessageDisappearHandler(param1:Event) : void
      {
         onMessageDisappearS(this._renderLinkage);
      }
      
      private function onContentRendererMessageExecutedHandler(param1:Event) : void
      {
         onMessageExecutedS(this._renderLinkage);
      }
      
      private function onContentRendererRewardAnimationStartHandler(param1:Event) : void
      {
         hideBlurS();
      }
      
      private function onContentRendererMessageRemovedHandler(param1:Event) : void
      {
         ++this._messageIndex;
         if(this._messageIndex < this._messagesQueue.length)
         {
            invalidateData();
            return;
         }
         onMessageRemovedS();
      }
   }
}
