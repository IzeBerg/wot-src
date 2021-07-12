package net.wg.gui.bootcamp.messageWindow.views
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.bootcamp.interfaces.IAnimatedContainerRenderer;
   import net.wg.gui.bootcamp.messageWindow.controls.MessageIconContainer;
   import net.wg.gui.bootcamp.messageWindow.data.MessageBottomItemVO;
   import net.wg.gui.bootcamp.messageWindow.events.MessageViewEvent;
   import net.wg.gui.bootcamp.messageWindow.interfaces.IBottomRenderer;
   import net.wg.gui.bootcamp.messageWindow.rewardAnimation.RewardAnimation;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.utils.IUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class MessageViewLinesReward extends MessageViewBase
   {
      
      private static const HIDE_TWEEN_DELAY:int = 100;
      
      private static const HIDE_TWEEN_TIME:int = 200;
      
      private static const OFFSET_BUTTON1:int = 70;
      
      private static const OFFSET_BUTTON2:int = 75;
      
      private static const OFFSET_BUTTON3:int = 90;
      
      private static const OUT_STATE:String = "out";
       
      
      public var animContainerIconSmall:IAnimatedContainerRenderer = null;
      
      public var rewardBg:MovieClip = null;
      
      public var btnContinue:UniversalBtn = null;
      
      public var icon:MessageIconContainer = null;
      
      public var glow:MovieClip = null;
      
      private var _bottomView:IBottomRenderer = null;
      
      private var _bottomViewLinkage:String = "";
      
      private var _utils:IUtils = null;
      
      private var _isFlyingReward:Boolean = false;
      
      private var _flyingReward:RewardAnimation = null;
      
      private var _hideTween:Tween = null;
      
      private var _animContainerTitleY:int = 0;
      
      private var _animContainerDescriptionY:int = 0;
      
      private var _iconY:int = 0;
      
      private var _glowY:int = 0;
      
      private var _animContainerIconSmallY:int = 0;
      
      private var _rewardBgY:int = 0;
      
      private var _btnContinueY:int = 0;
      
      public function MessageViewLinesReward()
      {
         super();
         animContainerBtnContinue.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._utils = App.utils;
         this._animContainerTitleY = animContainerTitle.y;
         this._animContainerDescriptionY = animContainerDescription.y;
         this._iconY = this.icon.y;
         this._glowY = this.glow.y;
         this._animContainerIconSmallY = this.animContainerIconSmall.y;
         this._rewardBgY = this.rewardBg.y;
         this._btnContinueY = this.btnContinue.y;
      }
      
      override protected function onDispose() : void
      {
         this.disposeBottomView();
         if(this._flyingReward)
         {
            this._flyingReward.removeEventListener(MessageViewEvent.REWARD_ANIMATION_COMPLETE,this.onRewardAnimationCompleteHandler);
            if(this._flyingReward.parent)
            {
               this._flyingReward.parent.removeChild(this._flyingReward);
            }
            this._flyingReward.dispose();
            this._flyingReward = null;
         }
         if(this._hideTween)
         {
            this._hideTween.paused = true;
            this._hideTween.dispose();
            this._hideTween = null;
         }
         this.animContainerIconSmall.dispose();
         this.animContainerIconSmall = null;
         this.rewardBg = null;
         this.btnContinue.removeEventListener(ButtonEvent.CLICK,this.onBtnContinueClickHandler);
         this.btnContinue.dispose();
         this.btnContinue = null;
         this.icon.dispose();
         this.icon = null;
         this.glow = null;
         this._utils = null;
         super.onDispose();
      }
      
      override protected function updateContent() : void
      {
         super.updateContent();
         if(StringUtils.isNotEmpty(messageData.iconPath))
         {
            this.icon.source = messageData.iconPath;
         }
         this.rewardBg.visible = this.animContainerIconSmall.visible = StringUtils.isNotEmpty(messageData.bottomRenderer);
         if(this.animContainerIconSmall.visible)
         {
            this.createBottomView();
         }
         this.btnContinue.label = BOOTCAMP.BTN_CONTINUE;
         this._utils.universalBtnStyles.setStyle(this.btnContinue,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.animContainerIconSmall.gotoAndPlay(getMessageStateLabel());
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = height >> 1;
            _loc2_ = _loc1_ - this._btnContinueY - this.btnContinue.height;
            if(_loc2_ >= OFFSET_BUTTON1)
            {
               this.btnContinue.y = this._btnContinueY;
            }
            else
            {
               this.btnContinue.y = _loc1_ - OFFSET_BUTTON1 - this.btnContinue.height;
            }
            _loc3_ = this.btnContinue.y - this._rewardBgY - this.rewardBg.height;
            if(_loc2_ >= OFFSET_BUTTON2)
            {
               if(_loc2_ >= OFFSET_BUTTON3)
               {
                  this.rewardBg.y = this._rewardBgY;
               }
               else
               {
                  this.rewardBg.y = _loc2_;
               }
            }
            else
            {
               this.rewardBg.y = this.btnContinue.y - OFFSET_BUTTON2 - this.rewardBg.height;
            }
            _loc4_ = this._rewardBgY - this.rewardBg.y;
            animContainerTitle.y = this._animContainerTitleY - _loc4_;
            animContainerDescription.y = this._animContainerDescriptionY - _loc4_;
            this.icon.y = this._iconY - _loc4_;
            this.glow.y = this._glowY - _loc4_;
            this.animContainerIconSmall.y = this._animContainerIconSmallY - _loc4_;
         }
      }
      
      protected function disposeBottomView() : void
      {
         if(this._bottomView != null)
         {
            this._bottomView.removeEventListener(MessageViewEvent.REWARD_ICON_LOADED,this.onRewardIconLoadedHandler);
            this._bottomView.dispose();
            this.animContainerIconSmall.removeContent(DisplayObject(this._bottomView));
            this._bottomView = null;
         }
      }
      
      protected function createBottomView() : void
      {
         var _loc1_:IBottomRenderer = null;
         var _loc2_:MessageBottomItemVO = null;
         if(this._bottomViewLinkage != messageData.bottomRenderer)
         {
            this.disposeBottomView();
            this._bottomViewLinkage = messageData.bottomRenderer;
            _loc1_ = App.utils.classFactory.getComponent(this._bottomViewLinkage,IBottomRenderer);
            this._bottomView = _loc1_;
            this.animContainerIconSmall.addContent(DisplayObject(this._bottomView));
         }
         if(messageData.bottomData)
         {
            _loc2_ = messageData.bottomData[0];
            if(_loc2_.animationTarget)
            {
               this._isFlyingReward = true;
               this._flyingReward = new RewardAnimation(_loc2_.icon,_loc2_.animationType,_loc2_.animationTarget);
               parent.addChild(this._flyingReward);
               this._flyingReward.addEventListener(MessageViewEvent.REWARD_ANIMATION_COMPLETE,this.onRewardAnimationCompleteHandler);
               this._bottomView.addEventListener(MessageViewEvent.REWARD_ICON_LOADED,this.onRewardIconLoadedHandler);
            }
            this._bottomView.setData(messageData.bottomData);
         }
      }
      
      override public function getFocusTarget() : InteractiveObject
      {
         return this.btnContinue;
      }
      
      override protected function onPressAnyKeyHandler() : void
      {
         super.onPressAnyKeyHandler();
         this.btnContinue.addEventListener(ButtonEvent.CLICK,this.onBtnContinueClickHandler);
      }
      
      override protected function onAnimationFinish() : void
      {
         if(!this._isFlyingReward)
         {
            super.onAnimationFinish();
         }
      }
      
      private function onBtnContinueClickHandler(param1:Event) : void
      {
         this.btnContinue.removeEventListener(ButtonEvent.CLICK,this.onBtnContinueClickHandler);
         if(this._isFlyingReward)
         {
            dispatchEvent(new MessageViewEvent(MessageViewEvent.MESSAGE_DISAPPEAR));
            this.startFlyingReward();
         }
         else
         {
            this.icon.gotoAndPlay(OUT_STATE);
            setOutState();
         }
      }
      
      private function startFlyingReward() : void
      {
         this._flyingReward.startAnimation();
         this._hideTween = new Tween(HIDE_TWEEN_TIME,this,{"alpha":0},{
            "delay":HIDE_TWEEN_DELAY,
            "fastTransform":false
         });
         dispatchEvent(new MessageViewEvent(MessageViewEvent.REWARD_ANIMATION_START));
      }
      
      private function onRewardIconLoadedHandler(param1:MessageViewEvent) : void
      {
         var _loc2_:Point = param1.target.localToGlobal(new Point(param1.target.width >> 1,param1.target.height >> 1));
         _loc2_ = parent.globalToLocal(_loc2_);
         this._flyingReward.x = _loc2_.x;
         this._flyingReward.y = _loc2_.y;
         param1.stopPropagation();
      }
      
      private function onRewardAnimationCompleteHandler(param1:MessageViewEvent) : void
      {
         dispatchEvent(new MessageViewEvent(MessageViewEvent.MESSAGE_REMOVED));
      }
   }
}
