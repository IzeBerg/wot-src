package net.wg.gui.lobby.epicBattles.views
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.BackButton;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWelcomeBackViewVO;
   import net.wg.gui.lobby.epicBattles.utils.EpicHelper;
   import net.wg.infrastructure.base.meta.IEpicBattlesWelcomeBackViewMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattlesWelcomeBackViewMeta;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class EpicBattlesWelcomeBackView extends EpicBattlesWelcomeBackViewMeta implements IEpicBattlesWelcomeBackViewMeta
   {
      
      private static const TILE_WIDTH:int = 280;
      
      private static const TILE_HEIGHT:int = 260;
      
      private static const TILE_GAP_MIN_RES:int = 54;
      
      private static const TILE_GAP_MAX_RES:int = 94;
      
      private static const SCR_WIDTH_LIMIT:int = 1100;
      
      private static const MIN_SCR_WIDTH:int = 1024;
      
      private static const MIN_TILE_GAP:int = 40;
      
      private static const MAX_TILE_GAP:int = 80;
      
      private static const PLAY_VIDEO_BTN_GAP:int = 8;
      
      private static const TILE_TO_CONTINUE_BUTTON_GAP:int = 60;
      
      private static const CONTINUE_BUTTON_TO_DETAILS_LINK_GAP:int = 20;
       
      
      public var tileList:SimpleTileList = null;
      
      public var backBtn:BackButton = null;
      
      public var playVideoBtn:ISoundButtonEx = null;
      
      public var continueBtn:IconTextBigButton = null;
      
      public var changesLink:HyperLink = null;
      
      public var subTitleTF:TextField = null;
      
      public var titleTF:TextField = null;
      
      private var _initData:EpicBattlesWelcomeBackViewVO;
      
      public function EpicBattlesWelcomeBackView()
      {
         super();
         fadeEnable = true;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
      }
      
      override protected function setInitData(param1:EpicBattlesWelcomeBackViewVO) : void
      {
         this._initData = EpicBattlesWelcomeBackViewVO(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.playVideoBtn.removeEventListener(ButtonEvent.CLICK,this.onPlayVideoBtnClickHandler);
         this.playVideoBtn.dispose();
         this.playVideoBtn = null;
         this.tileList.removeEventListener(Event.COMPLETE,this.onTileListCompleteHandler);
         this.tileList.dispose();
         this.tileList = null;
         this.titleTF = null;
         this.subTitleTF = null;
         this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.backBtn.dispose();
         this.backBtn = null;
         this.continueBtn.removeEventListener(ButtonEvent.CLICK,this.onContinueBtnClickHandler);
         this.continueBtn.dispose();
         this.continueBtn = null;
         this.changesLink.removeEventListener(ButtonEvent.CLICK,this.onChangesLinkClickHandler);
         this.changesLink.dispose();
         this.changesLink = null;
         closeBtn.dispose();
         closeBtn = null;
         this._initData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tileList.itemRenderer = App.utils.classFactory.getClass(Linkages.EPIC_BATTLE_WELCOME_BACK_INFO_RENDERER_UI);
         this.tileList.tileWidth = TILE_WIDTH;
         this.tileList.tileHeight = TILE_HEIGHT;
         this.tileList.directionMode = DirectionMode.HORIZONTAL;
         this.playVideoBtn.useHtmlText = true;
         this.playVideoBtn.addEventListener(ButtonEvent.CLICK,this.onPlayVideoBtnClickHandler);
         this.tileList.addEventListener(Event.COMPLETE,this.onTileListCompleteHandler);
         this.continueBtn.addEventListener(ButtonEvent.CLICK,this.onContinueBtnClickHandler);
         this.changesLink.addEventListener(ButtonEvent.CLICK,this.onChangesLinkClickHandler);
         this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
         this.changesLink.label = Values.EMPTY_STR;
         this.continueBtn.label = MENU.VIEWHEADER_BACKBTN_LABEL;
         this.backBtn.label = MENU.VIEWHEADER_BACKBTN_LABEL;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:CloseButtonText = null;
         var _loc4_:Number = NaN;
         super.draw();
         if(this._initData && isInvalid(InvalidationType.DATA))
         {
            setBackground(this._initData.bgSource);
            this.subTitleTF.htmlText = EPIC_BATTLE.EPICBATTLESWELCOMEBACKVIEW_SUBTITLE;
            App.utils.commons.updateTextFieldSize(this.subTitleTF,true,true);
            this.playVideoBtn.visible = true;
            this.playVideoBtn.label = this._initData.playVideoBtnLabel;
            this.tileList.dataProvider = this._initData.tileListDP;
            this.backBtn.visible = this._initData.showBackBtn;
            this.continueBtn.visible = !this._initData.showBackBtn;
            invalidateSize();
         }
         if(this._initData && isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = EpicHelper.calculateStaticMargin(height);
            _loc2_ = _loc1_ + EpicHelper.MAIN_MENU_BUTTON_BAR_HEIGHT;
            if(EpicHelper.isMinResolution(height))
            {
               this.tileList.horizontalGap = TILE_GAP_MIN_RES;
               this.titleTF.htmlText = this._initData.titleLabelSmall;
               this.titleTF.y = _loc2_ - EpicHelper.VISUAL_HERO_TITLE_TOP_PADDING;
               this.subTitleTF.y = this.titleTF.y + EpicHelper.HERO_TITLE_SUBTITLE_DISTANCE;
            }
            else
            {
               this.tileList.horizontalGap = TILE_GAP_MAX_RES;
               this.titleTF.htmlText = this._initData.titleLabelBig;
               this.titleTF.y = _loc2_ - EpicHelper.VISUAL_EPIC_TITLE_TOP_PADDING;
               this.subTitleTF.y = this.titleTF.y + EpicHelper.EPIC_TITLE_SUBTITLE_DISTANCE;
            }
            this.titleTF.width = width;
            App.utils.commons.updateTextFieldSize(this.titleTF,true,true);
            this.titleTF.x = width - this.titleTF.width >> 1;
            EpicHelper.positionBackButton(this.backBtn,height);
            _loc3_ = closeBtn as CloseButtonText;
            if(_loc3_ != null)
            {
               EpicHelper.positionCloseButton(_loc3_,height,width);
            }
            this.subTitleTF.x = (width >> 1) - this.subTitleTF.width;
            this.playVideoBtn.x = (width >> 1) + PLAY_VIDEO_BTN_GAP;
            this.playVideoBtn.y = this.subTitleTF.y + EpicHelper.BUTTON_TOP_MARGIN;
            if(width >= SCR_WIDTH_LIMIT)
            {
               this.tileList.horizontalGap = MAX_TILE_GAP;
            }
            else
            {
               _loc4_ = 1 - (SCR_WIDTH_LIMIT - width) / (SCR_WIDTH_LIMIT - MIN_SCR_WIDTH);
               this.tileList.horizontalGap = MIN_TILE_GAP + _loc4_ * (MAX_TILE_GAP - MIN_TILE_GAP);
            }
            this.changesLink.autoSize = TextFieldAutoSize.LEFT;
            this.positionTilelistAndBelow();
         }
      }
      
      override protected function layoutBackground() : void
      {
         var _loc1_:Number = height + EpicHelper.MESSENGER_BAR_HEIGHT + EpicHelper.MAIN_MENU_BUTTON_BAR_HEIGHT;
         var _loc2_:int = bgHolder.width / bgHolder.scaleX;
         var _loc3_:int = bgHolder.height / bgHolder.scaleY;
         if(_loc1_ < _loc3_ * width / _loc2_)
         {
            bgHolder.width = width;
            bgHolder.scaleY = bgHolder.scaleX;
         }
         else
         {
            bgHolder.height = _loc1_;
            bgHolder.scaleX = bgHolder.scaleY;
         }
         bgHolder.x = width - bgHolder.width >> 1;
         bgHolder.y = height - bgHolder.height >> 1;
      }
      
      override protected function onEscapeKeyDown() : void
      {
         onBackBtnClickedS();
      }
      
      override protected function onCloseBtn() : void
      {
         onCloseBtnClickedS();
      }
      
      protected function updateDynamicPositions() : void
      {
         this.changesLink.x = width - this.changesLink.textField.textWidth >> 1;
         this.changesLink.visible = true;
         this.titleTF.x = width - this.titleTF.width >> 1;
         this.positionTilelistAndBelow();
      }
      
      private function getTileListHeight() : int
      {
         var _loc4_:DisplayObject = null;
         var _loc1_:int = this.tileList.height;
         var _loc2_:int = this.tileList.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.tileList.getChildAt(_loc3_);
            if(_loc4_.height > _loc1_)
            {
               _loc1_ = _loc4_.height;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function positionTilelistAndBelow() : void
      {
         var _loc6_:int = 0;
         if(this._initData)
         {
            _loc6_ = TILE_WIDTH * this._initData.tileListDP.length + this.tileList.horizontalGap * (this._initData.tileListDP.length - 1);
            this.tileList.x = width - _loc6_ >> 1;
         }
         var _loc1_:int = this.playVideoBtn.y + this.playVideoBtn.height;
         var _loc2_:int = this.getTileListHeight();
         var _loc3_:int = _loc2_ + TILE_TO_CONTINUE_BUTTON_GAP + this.continueBtn.height + CONTINUE_BUTTON_TO_DETAILS_LINK_GAP + this.changesLink.height;
         var _loc4_:int = height - _loc1_ - _loc3_ >> 1;
         this.tileList.y = _loc1_ + _loc4_;
         var _loc5_:int = this.tileList.y + _loc2_ + TILE_TO_CONTINUE_BUTTON_GAP;
         this.continueBtn.y = _loc5_;
         this.changesLink.y = _loc5_ + this.continueBtn.height + CONTINUE_BUTTON_TO_DETAILS_LINK_GAP;
         this.changesLink.x = width - this.changesLink.textField.textWidth >> 1;
         this.continueBtn.x = width - this.continueBtn.width >> 1;
      }
      
      private function onBackBtnClickHandler(param1:ButtonEvent) : void
      {
         onBackBtnClickedS();
      }
      
      private function onContinueBtnClickHandler(param1:ButtonEvent) : void
      {
         onContinueBtnClickedS();
      }
      
      private function onChangesLinkClickHandler(param1:ButtonEvent) : void
      {
         onChangesLinkClickedS();
      }
      
      private function onTileListCompleteHandler(param1:Event) : void
      {
         this.updateDynamicPositions();
      }
      
      private function onPlayVideoBtnClickHandler(param1:ButtonEvent) : void
      {
         playVideoS();
      }
   }
}
