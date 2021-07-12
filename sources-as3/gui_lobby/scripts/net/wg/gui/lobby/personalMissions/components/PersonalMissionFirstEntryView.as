package net.wg.gui.lobby.personalMissions.components
{
   import fl.motion.easing.Cubic;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.BackButton;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.personalMissions.components.firstEntry.InfoAdditionalContentPage;
   import net.wg.gui.lobby.personalMissions.components.firstEntry.InfoContent;
   import net.wg.gui.lobby.personalMissions.components.firstEntry.PMInfoAdditionalViewSettings;
   import net.wg.gui.lobby.personalMissions.components.firstEntry.PMInfoVewSettings;
   import net.wg.gui.lobby.personalMissions.components.firstEntry.PMInfoVewSettingsCore;
   import net.wg.gui.lobby.personalMissions.data.InfoAdditionalDataVO;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionFirstEntryViewVO;
   import net.wg.gui.lobby.personalMissions.events.FirstEntryCardEvent;
   import net.wg.infrastructure.base.meta.IPersonalMissionFirstEntryViewMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionFirstEntryViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class PersonalMissionFirstEntryView extends PersonalMissionFirstEntryViewMeta implements IPersonalMissionFirstEntryViewMeta
   {
      
      private static const BACK_BTN_RIGHT_MARGIN:int = 7;
      
      private static const BACK_BTN_TOP_MARGIN:int = 80;
      
      private static const INVALID_DATA_INIT:String = "invalidDataInit";
      
      private static const ANIMATION_SHOW_POS_Y_DIFF:int = 150;
      
      private static const TWEEN_DURATION:int = 600;
      
      private static const TWEEN_DELAY_TITLE:int = 200;
      
      private static const TWEEN_DELAY_PLAY_VIDEO_BTN:int = 200;
      
      private static const TWEEN_DELAY_ACCEPT_BTN:int = 1200;
       
      
      public var backBtn:BackButton = null;
      
      public var playVideoBtn:ISoundButtonEx = null;
      
      public var shadow:Sprite = null;
      
      public var acceptBtn:ISoundButtonEx = null;
      
      public var titleTFContainer:TextFieldContainer = null;
      
      public var content:InfoContent = null;
      
      public var additionalContent:InfoAdditionalContentPage = null;
      
      private var _sizeId:String = "";
      
      private var _settingsCore:PMInfoVewSettingsCore = null;
      
      private var _settings:PMInfoVewSettings = null;
      
      private var _additionalSettings:PMInfoAdditionalViewSettings = null;
      
      private var _tweens:Vector.<Tween> = null;
      
      private var _firstShow:Boolean = true;
      
      private var _isMainContentHidden:Boolean = false;
      
      private var _initData:PersonalMissionFirstEntryViewVO;
      
      private var _cardsLen:int = -1;
      
      public function PersonalMissionFirstEntryView()
      {
         super();
      }
      
      private static function createShowTween(param1:Object, param2:int, param3:int) : Tween
      {
         param1.y = param2 + ANIMATION_SHOW_POS_Y_DIFF;
         return new Tween(TWEEN_DURATION,param1,{
            "y":param2,
            "alpha":Values.DEFAULT_ALPHA
         },{
            "paused":false,
            "ease":Cubic.easeOut,
            "delay":param3,
            "fastTransform":false
         });
      }
      
      override protected function setInitData(param1:PersonalMissionFirstEntryViewVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._initData = param1;
         this._cardsLen = this._initData.infoBlocks.length;
         invalidate(INVALID_DATA_INIT);
      }
      
      override protected function onDispose() : void
      {
         this.clearTweens();
         this._settings = null;
         this._additionalSettings = null;
         this._settingsCore.dispose();
         this._settingsCore = null;
         this.additionalContent.removeEventListener(FirstEntryCardEvent.CLOSE_DESCRIPTION,this.onAdditionalContentCloseDescriptionHandler);
         this.additionalContent.removeEventListener(FirstEntryCardEvent.TO_PREV,this.onAdditionalContentToPrevHandler);
         this.additionalContent.removeEventListener(FirstEntryCardEvent.TO_NEXT,this.onAdditionalContentToNextHandler);
         this.additionalContent.dispose();
         this.additionalContent = null;
         this.content.removeEventListener(FirstEntryCardEvent.CARD_CLICK,this.onContentCardClickHandler);
         this.content.dispose();
         this.content = null;
         this.acceptBtn.removeEventListener(ButtonEvent.CLICK,this.onAcceptBtnClickHandler);
         this.acceptBtn.dispose();
         this.acceptBtn = null;
         this.titleTFContainer.dispose();
         this.titleTFContainer = null;
         this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.backBtn.dispose();
         this.backBtn = null;
         this.shadow = null;
         this.playVideoBtn.removeEventListener(ButtonEvent.CLICK,this.onPlayVideoBtnClickHandler);
         this.playVideoBtn.dispose();
         this.playVideoBtn = null;
         this._initData = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.additionalContent.addEventListener(FirstEntryCardEvent.CLOSE_DESCRIPTION,this.onAdditionalContentCloseDescriptionHandler);
         this.additionalContent.addEventListener(FirstEntryCardEvent.TO_PREV,this.onAdditionalContentToPrevHandler);
         this.additionalContent.addEventListener(FirstEntryCardEvent.TO_NEXT,this.onAdditionalContentToNextHandler);
         this.additionalContent.visible = false;
         this.content.addEventListener(FirstEntryCardEvent.CARD_CLICK,this.onContentCardClickHandler);
         this._settingsCore = new PMInfoVewSettingsCore();
         this.playVideoBtn.useHtmlText = true;
         this.acceptBtn.useHtmlText = true;
         this.acceptBtn.alpha = Values.ZERO;
         this.playVideoBtn.alpha = Values.ZERO;
         this.titleTFContainer.isUpdateWidth = true;
         this.titleTFContainer.alpha = Values.ZERO;
         this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.playVideoBtn.addEventListener(ButtonEvent.CLICK,this.onPlayVideoBtnClickHandler);
         this.backBtn.x = BACK_BTN_RIGHT_MARGIN;
         this.backBtn.y = BACK_BTN_TOP_MARGIN;
         this.acceptBtn.addEventListener(ButtonEvent.CLICK,this.onAcceptBtnClickHandler);
         App.popoverMgr.hide();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         super.draw();
         if(this._initData != null && isInvalid(INVALID_DATA_INIT))
         {
            setBackground(this._initData.bgSource);
            this.titleTFContainer.label = this._initData.titleLabel;
            this.acceptBtn.label = this._initData.bigBtnLabel;
            this.backBtn.label = this._initData.backBtnLabel;
            this.content.initBlocks(this._initData.infoBlocks);
            this.playVideoBtn.visible = this._initData.playVideoBtnVisible;
            this.playVideoBtn.label = this._initData.playVideoBtnLabel;
            this.backBtn.visible = !this._initData.isFirstEntry;
            this.acceptBtn.visible = this._initData.isFirstEntry;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = PMInfoVewSettingsCore.getSizeId(width,height);
            _loc2_ = false;
            if(this._sizeId != _loc1_)
            {
               this._sizeId = _loc1_;
               this._settings = this._settingsCore.getSettingsBySizeId(this._sizeId);
               this._additionalSettings = this._settingsCore.getAdditionalSettingsBySizeId(this._sizeId);
               _loc2_ = true;
            }
            if(_loc2_)
            {
               this.titleTFContainer.fontSize = this._settings.titleFontSize;
            }
            _loc3_ = this._settings.titleTopGap;
            _loc4_ = _loc3_ + this.titleTFContainer.height + this._settings.playVideoBtnTopGap;
            _loc5_ = height - this.acceptBtn.height - this._settings.acceptBtnBottomGap;
            _loc6_ = width >> 1;
            this.titleTFContainer.x = width - this.titleTFContainer.width >> 1;
            this.playVideoBtn.x = _loc6_ - (this.playVideoBtn.width >> 1);
            this.shadow.x = width - this.shadow.width >> 1;
            _loc7_ = !!this._initData.playVideoBtnVisible ? int(_loc4_ + this.playVideoBtn.height) : int(_loc3_ + this.titleTFContainer.height);
            this.content.x = _loc6_;
            this.content.y = _loc7_ + (_loc5_ - _loc7_ - this._settings.cardHeight >> 1);
            this.content.layoutRenderers(this._settings,_loc2_);
            this.acceptBtn.x = width - this.acceptBtn.width >> 1;
            if(this._firstShow)
            {
               this._firstShow = false;
               this._tweens = new Vector.<Tween>();
               this._tweens.push(createShowTween(this.titleTFContainer,_loc3_,TWEEN_DELAY_TITLE));
               this._tweens.push(createShowTween(this.playVideoBtn,_loc4_,TWEEN_DELAY_PLAY_VIDEO_BTN));
               this._tweens.push(createShowTween(this.acceptBtn,_loc5_,TWEEN_DELAY_ACCEPT_BTN));
            }
            else
            {
               this.clearTweens();
               this.titleTFContainer.alpha = Values.DEFAULT_ALPHA;
               this.playVideoBtn.alpha = Values.DEFAULT_ALPHA;
               this.acceptBtn.alpha = Values.DEFAULT_ALPHA;
               this.titleTFContainer.y = _loc3_;
               this.playVideoBtn.y = _loc4_;
               this.acceptBtn.y = _loc5_;
            }
            this.additionalContent.x = _loc6_;
            if(_loc2_)
            {
               this.additionalContent.updateSettings(this._additionalSettings);
            }
            this.additionalContent.setSize(width,height);
         }
      }
      
      override protected function onEscapeKeyDown() : void
      {
         if(this._isMainContentHidden)
         {
            this.closeAdditionalContent();
         }
         else if(this._initData.isFirstEntry)
         {
            onViewCloseS(false);
         }
         else
         {
            backBtnClickedS();
         }
      }
      
      override protected function setDetailedCardData(param1:InfoAdditionalDataVO) : void
      {
         this.hideMainContent();
         this.showAdditionalContent(param1);
      }
      
      private function clearTweens() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._tweens)
         {
            _loc1_ = this._tweens.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._tweens[_loc2_].dispose();
               _loc2_++;
            }
            this._tweens.splice(0,_loc1_);
            this._tweens = null;
         }
      }
      
      private function showAdditionalContent(param1:InfoAdditionalDataVO) : void
      {
         this.additionalContent.visible = true;
         this.additionalContent.setData(param1,this._cardsLen);
      }
      
      private function hideAdditionalContent() : void
      {
         this.additionalContent.visible = false;
         this.additionalContent.clear();
      }
      
      private function showMainContent() : void
      {
         this._isMainContentHidden = false;
         this.backBtn.visible = !this._initData.isFirstEntry;
         this.acceptBtn.visible = this._initData.isFirstEntry;
         this.playVideoBtn.visible = true;
         this.shadow.visible = true;
         this.titleTFContainer.visible = true;
         this.content.visible = true;
         this.content.resetShowContent();
         this._sizeId = Values.EMPTY_STR;
         this._firstShow = true;
         unblurElements(new <DisplayObject>[bgHolder],true);
         invalidateSize();
      }
      
      private function hideMainContent() : void
      {
         if(this._isMainContentHidden)
         {
            return;
         }
         this._isMainContentHidden = true;
         this.acceptBtn.alpha = Values.ZERO;
         this.playVideoBtn.alpha = Values.ZERO;
         this.titleTFContainer.alpha = Values.ZERO;
         this.backBtn.visible = false;
         this.playVideoBtn.visible = false;
         this.shadow.visible = false;
         this.acceptBtn.visible = false;
         this.titleTFContainer.visible = false;
         this.content.visible = false;
         blurElements(new <DisplayObject>[bgHolder],true);
      }
      
      private function closeAdditionalContent() : void
      {
         this.showMainContent();
         this.hideAdditionalContent();
      }
      
      override public function get isModal() : Boolean
      {
         return true;
      }
      
      private function onAdditionalContentToNextHandler(param1:FirstEntryCardEvent) : void
      {
         onNextCardClickS(param1.slotIndex);
      }
      
      private function onAdditionalContentToPrevHandler(param1:FirstEntryCardEvent) : void
      {
         onPrevCardClickS(param1.slotIndex);
      }
      
      private function onAdditionalContentCloseDescriptionHandler(param1:FirstEntryCardEvent) : void
      {
         this.closeAdditionalContent();
      }
      
      private function onContentCardClickHandler(param1:FirstEntryCardEvent) : void
      {
         onCardClickS(param1.slotIndex);
      }
      
      private function onPlayVideoBtnClickHandler(param1:ButtonEvent) : void
      {
         playVideoS();
      }
      
      private function onBackBtnClickHandler(param1:ButtonEvent) : void
      {
         backBtnClickedS();
      }
      
      private function onAcceptBtnClickHandler(param1:ButtonEvent) : void
      {
         onViewCloseS(true);
      }
   }
}
