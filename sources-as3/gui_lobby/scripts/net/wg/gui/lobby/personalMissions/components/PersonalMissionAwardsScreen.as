package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.InteractiveObject;
   import flash.ui.Keyboard;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.RibbonAwards;
   import net.wg.gui.lobby.components.data.RibbonAwardsVO;
   import net.wg.gui.lobby.components.events.RibbonAwardAnimEvent;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionAwardsScreenVO;
   import net.wg.gui.lobby.personalMissions.events.AnimationStateEvent;
   import net.wg.infrastructure.base.meta.IPersonalMissionsOperationAwardsScreenMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionsOperationAwardsScreenMeta;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class PersonalMissionAwardsScreen extends PersonalMissionsOperationAwardsScreenMeta implements IPersonalMissionsOperationAwardsScreenMeta
   {
      
      private static const DEF_BACKGROUND_WIDTH:Number = 1920;
      
      private static const DEF_BACKGROUND_HEIGHT:Number = 1080;
      
      private static const BLUR_ADDITIONAL_SIZE:int = 20;
      
      private static const CLOSE_BTN_OFFSET:int = 29;
      
      private static const RIBBON_OFFSET:int = 180;
      
      private static const HEADER_ANIM_OFFSET:int = 230;
      
      private static const AWARD_BTN_OFFSET:int = 142;
      
      private static const CNTRLS_ALPHA_ENABLED:Number = 1;
      
      private static const CNTRLS_ALPHA_DISABLED:Number = 0.4;
      
      private static const FADE_IN_HEADER_DELAY:Number = 900;
      
      private static const SND_SHOW_VIEW:String = "snd_show_view";
      
      private static const SND_SHOW_CONSUMABLE:String = "snd_show_consumable";
      
      private static const SND_SHOW_MONEY:String = "snd_show_money";
      
      private static const SND_SHOW_VEHICLE:String = "snd_show_vehicle";
      
      private static const SND_MINIMIZE_VEHICLE:String = "snd_minimize_vehicle";
      
      private static const SND_SHOW_ACCEPT_BUTTON:String = "snd_show_accept_btn";
       
      
      public var closeBtn:ISoundButtonEx = null;
      
      public var headerAnim:PersonalMissionAwardsScreenHeaderAnim = null;
      
      public var awardBtnAnim:PersonalMissionAwardBtnAnim = null;
      
      public var extraAwardAnim:PersonalMissionExtraAwardAnim = null;
      
      public var ribbonAwards:RibbonAwards = null;
      
      public var background:PersonalMissionAwardsScreenBgAnim = null;
      
      private var _awardBtn:ISoundButtonEx = null;
      
      private var _data:PersonalMissionAwardsScreenVO = null;
      
      private var _screenW:Number = 0;
      
      private var _screenH:Number = 0;
      
      private var _isCloseEnabled:Boolean = true;
      
      private var _isClosed:Boolean = false;
      
      public function PersonalMissionAwardsScreen()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this._screenW = param1;
         this._screenH = param2;
         invalidateSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.closeBtn.focusable = false;
         this.background.addEventListener(AnimationStateEvent.FADE_OUT_COMPLETE,this.onBackgroundFadeOutCompleteHandler);
      }
      
      override protected function setAwardData(param1:RibbonAwardsVO) : void
      {
         this.ribbonAwards.setData(param1);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this._awardBtn = this.awardBtnAnim.getBtn();
         this._awardBtn.addEventListener(ButtonEvent.CLICK,this.onAwardBtnClickHandler);
         this.awardBtnAnim.addEventListener(AnimationStateEvent.FADE_IN_COMPLETE,this.onAwardBtnAnimFadeInCompleteHandler);
         this.awardBtnAnim.addEventListener(AnimationStateEvent.FADE_OUT_COMPLETE,this.onAwardBtnAnimFadeOutCompleteHandler);
         this.extraAwardAnim.addEventListener(AnimationStateEvent.FADE_IN_COMPLETE,this.onExtraAwardAnimFadeInCompleteHandler);
         this.extraAwardAnim.addEventListener(AnimationStateEvent.MOVE_START,this.onExtraAwardAnimMoveStartHandler);
         this.ribbonAwards.addEventListener(RibbonAwardAnimEvent.RIBBON_FADE_IN_COMPLETE,this.onRibbonFadeInCompleteHandler);
         this.ribbonAwards.addEventListener(RibbonAwardAnimEvent.RIBBON_FADE_OUT_COMPLETE,this.onRibbonFadeOutCompleteHandler);
         this.ribbonAwards.addEventListener(RibbonAwardAnimEvent.CONSUMABLE_FADE_IN,this.onRibbonAwardsConsumableFadeInHandler);
         this.ribbonAwards.addEventListener(RibbonAwardAnimEvent.MONEY_FADE_IN,this.onRibbonAwardsMoneyFadeInHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.updateData();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateComponentsPosition();
         }
      }
      
      override protected function setInitData(param1:PersonalMissionAwardsScreenVO) : void
      {
         this._data = param1;
         if(this._data.vehicleData)
         {
            this.extraAwardAnim.setData(this._data.vehicleData);
         }
         invalidateData();
         this.background.fadeIn();
         onPlaySoundS(SND_SHOW_VIEW);
      }
      
      override protected function onBeforeDispose() : void
      {
         App.utils.scheduler.cancelTask(this.fadeInHeader);
         if(this._awardBtn)
         {
            this._awardBtn.removeEventListener(ButtonEvent.CLICK,this.onAwardBtnClickHandler);
            this._awardBtn = null;
         }
         this.awardBtnAnim.removeEventListener(AnimationStateEvent.FADE_IN_COMPLETE,this.onAwardBtnAnimFadeInCompleteHandler);
         this.awardBtnAnim.removeEventListener(AnimationStateEvent.FADE_OUT_COMPLETE,this.onAwardBtnAnimFadeOutCompleteHandler);
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.extraAwardAnim.removeEventListener(AnimationStateEvent.FADE_IN_COMPLETE,this.onExtraAwardAnimFadeInCompleteHandler);
         this.extraAwardAnim.removeEventListener(AnimationStateEvent.MOVE_START,this.onExtraAwardAnimMoveStartHandler);
         this.ribbonAwards.removeEventListener(RibbonAwardAnimEvent.CONSUMABLE_FADE_IN,this.onRibbonAwardsConsumableFadeInHandler);
         this.ribbonAwards.removeEventListener(RibbonAwardAnimEvent.MONEY_FADE_IN,this.onRibbonAwardsMoneyFadeInHandler);
         this.ribbonAwards.removeEventListener(RibbonAwardAnimEvent.RIBBON_FADE_IN_COMPLETE,this.onRibbonFadeInCompleteHandler);
         this.ribbonAwards.removeEventListener(RibbonAwardAnimEvent.RIBBON_FADE_OUT_COMPLETE,this.onRibbonFadeOutCompleteHandler);
         this.background.removeEventListener(AnimationStateEvent.FADE_OUT_COMPLETE,this.onBackgroundFadeOutCompleteHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.headerAnim.dispose();
         this.headerAnim = null;
         this.awardBtnAnim.dispose();
         this.awardBtnAnim = null;
         this.extraAwardAnim.dispose();
         this.extraAwardAnim = null;
         this.ribbonAwards.dispose();
         this.ribbonAwards = null;
         this.background.dispose();
         this.background = null;
         this._data = null;
         super.onDispose();
      }
      
      public function as_playAwardsAnimation() : void
      {
         this.ribbonAwards.show();
         App.utils.scheduler.scheduleTask(this.fadeInHeader,FADE_IN_HEADER_DELAY);
      }
      
      public function as_setCloseBtnEnabled(param1:Boolean) : void
      {
         this._isCloseEnabled = param1;
         this.closeBtn.enabled = param1;
         this.closeBtn.alpha = !!param1 ? Number(CNTRLS_ALPHA_ENABLED) : Number(CNTRLS_ALPHA_DISABLED);
      }
      
      private function updateFocus(param1:InteractiveObject) : void
      {
         if(param1)
         {
            setFocus(param1);
         }
      }
      
      private function fadeOut() : void
      {
         if(this._data.vehicleData)
         {
            this.extraAwardAnim.fadeOut();
         }
         this.headerAnim.fadeOut();
         this.awardBtnAnim.fadeOut();
         this.ribbonAwards.hide();
         if(this._isClosed)
         {
            this.closeBtn.visible = false;
            this.background.fadeOut();
         }
      }
      
      private function fadeInHeader() : void
      {
         if(this._isClosed)
         {
            return;
         }
         this.headerAnim.fadeIn();
      }
      
      private function updateComponentsPosition() : void
      {
         var _loc1_:int = this._screenW >> 1;
         var _loc2_:int = this._screenH >> 1;
         var _loc3_:Number = Math.max(this._screenW / DEF_BACKGROUND_WIDTH,this._screenH / DEF_BACKGROUND_HEIGHT);
         x = _loc1_;
         this.background.width = DEF_BACKGROUND_WIDTH * _loc3_ + BLUR_ADDITIONAL_SIZE;
         this.background.height = DEF_BACKGROUND_HEIGHT * _loc3_ + BLUR_ADDITIONAL_SIZE;
         this.ribbonAwards.y = _loc2_ - (this.ribbonAwards.height >> 1) + RIBBON_OFFSET;
         this.headerAnim.y = HEADER_ANIM_OFFSET;
         this.awardBtnAnim.y = this.ribbonAwards.y + AWARD_BTN_OFFSET;
         this.extraAwardAnim.y = this.ribbonAwards.y;
         this.closeBtn.x = (this._screenW - this.closeBtn.width - CLOSE_BTN_OFFSET ^ 0) - _loc1_;
      }
      
      private function updateData() : void
      {
         this.closeBtn.label = this._data.closeBtnLabel;
         this.headerAnim.setHeader(this._data.header);
         this.headerAnim.setHeaderExtra(this._data.headerExtra);
         this.background.setCampaignId(this._data.campaignId);
      }
      
      private function extraAwardFadeIn() : void
      {
         if(this._data.vehicleData.hasData)
         {
            this.ribbonAwards.blink();
            this.extraAwardAnim.fadeIn();
            onPlaySoundS(SND_SHOW_VEHICLE);
         }
         else
         {
            this.awardBtnAnim.fadeIn();
            onPlaySoundS(SND_SHOW_ACCEPT_BUTTON);
         }
      }
      
      private function close() : void
      {
         if(!this._isClosed)
         {
            mouseChildren = false;
            this._isClosed = true;
            this.fadeOut();
         }
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled || !this._isCloseEnabled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            this.onCloseBtnClickHandler(null);
         }
      }
      
      private function onRibbonAwardsMoneyFadeInHandler(param1:RibbonAwardAnimEvent) : void
      {
         onPlaySoundS(SND_SHOW_MONEY);
      }
      
      private function onRibbonAwardsConsumableFadeInHandler(param1:RibbonAwardAnimEvent) : void
      {
         onPlaySoundS(SND_SHOW_CONSUMABLE);
      }
      
      private function onExtraAwardAnimMoveStartHandler(param1:AnimationStateEvent) : void
      {
         onPlaySoundS(SND_MINIMIZE_VEHICLE);
      }
      
      private function onAwardBtnAnimFadeInCompleteHandler(param1:AnimationStateEvent) : void
      {
         this.updateFocus(InteractiveObject(this._awardBtn));
      }
      
      private function onAwardBtnAnimFadeOutCompleteHandler(param1:AnimationStateEvent) : void
      {
         this.updateFocus(this);
      }
      
      private function onRibbonFadeInCompleteHandler(param1:RibbonAwardAnimEvent) : void
      {
         this.extraAwardFadeIn();
      }
      
      private function onRibbonFadeOutCompleteHandler(param1:RibbonAwardAnimEvent) : void
      {
         if(!this._isClosed)
         {
            this.ribbonAwards.clear();
         }
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         this.close();
      }
      
      private function onAwardBtnClickHandler(param1:ButtonEvent) : void
      {
         this.close();
      }
      
      private function onExtraAwardAnimFadeInCompleteHandler(param1:AnimationStateEvent) : void
      {
         this.awardBtnAnim.fadeIn();
         onPlaySoundS(SND_SHOW_ACCEPT_BUTTON);
      }
      
      private function onBackgroundFadeOutCompleteHandler(param1:AnimationStateEvent) : void
      {
         onCloseWindowS();
      }
   }
}
