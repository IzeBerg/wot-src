package net.wg.gui.lobby.epicBattles.views
{
   import flash.events.KeyboardEvent;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.BackButton;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.components.IconTextWrapper;
   import net.wg.gui.lobby.epicBattles.components.BackgroundComponent;
   import net.wg.gui.lobby.epicBattles.components.prestigeView.PrestigeOverlay;
   import net.wg.gui.lobby.epicBattles.components.prestigeView.RewardRibbon;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesPrestigeViewVO;
   import net.wg.gui.lobby.epicBattles.events.EpicBattlePrestigeViewClickEvent;
   import net.wg.infrastructure.base.meta.IEpicBattlesPrestigeViewMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattlesPrestigeViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   
   public class EpicBattlesPrestigeView extends EpicBattlesPrestigeViewMeta implements IEpicBattlesPrestigeViewMeta
   {
      
      private static const CLOSE_BTN_RIGHT_OFFSET:int = 22;
      
      private static const STANDARD_TOP_TITLE_OFFSET_RATIO:Number = 0.17;
      
      private static const STANDARD_TOP_RIBBON_RATIO:Number = 0.58;
      
      private static const STANDARD_TOP_CONTINUE_BUTTON_RATIO:Number = 0.73;
      
      private static const BACK_BTN_RIGHT_MARGIN:int = 7;
      
      private static const REWARD_TITLE_SIZE_SMALL:int = 48;
      
      private static const REWARD_TITLE_SIZE_REGULAR:int = 62;
      
      private static const STANDARD_OFFSET:int = 30;
      
      private static const BREAKING_POINT_RESOLUTION:int = 768;
      
      private static const SHOW_RIBBON_STATE:String = "showRibbon";
       
      
      public var closeButton:CloseButtonText = null;
      
      public var rewardRibbon:RewardRibbon = null;
      
      public var rewardTitle:IconTextWrapper = null;
      
      public var continueBTN:SoundButtonEx = null;
      
      public var backButton:BackButton = null;
      
      public var prestigeOverlayContent:PrestigeOverlay = null;
      
      public var background:BackgroundComponent = null;
      
      private var _data:EpicBattlesPrestigeViewVO = null;
      
      public function EpicBattlesPrestigeView()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         var _loc3_:int = param1 >> 1;
         var _loc4_:int = param2 >> 1;
         this.prestigeOverlayContent.x = _loc3_;
         this.closeButton.x = param1 - this.closeButton.width - CLOSE_BTN_RIGHT_OFFSET;
         this.backButton.x = BACK_BTN_RIGHT_MARGIN;
         this.rewardTitle.y = param2 * STANDARD_TOP_TITLE_OFFSET_RATIO;
         this.rewardTitle.x = _loc3_;
         this.rewardRibbon.y = param2 * STANDARD_TOP_RIBBON_RATIO;
         this.rewardRibbon.x = _loc3_;
         this.continueBTN.y = param2 * STANDARD_TOP_CONTINUE_BUTTON_RATIO;
         this.continueBTN.x = param1 - this.continueBTN.width >> 1;
         this.background.x = 0;
         this.background.y = 0;
         this.background.updateStage(param1,param2);
         var _loc5_:TextFormat = this.rewardTitle.getTextFormat();
         if(param2 <= BREAKING_POINT_RESOLUTION)
         {
            this.prestigeOverlayContent.y = _loc4_ + STANDARD_OFFSET;
            this.rewardRibbon.y = param2 * STANDARD_TOP_RIBBON_RATIO + STANDARD_OFFSET;
            _loc5_.size = REWARD_TITLE_SIZE_SMALL;
         }
         else
         {
            this.prestigeOverlayContent.y = _loc4_;
            _loc5_.size = REWARD_TITLE_SIZE_REGULAR;
         }
         this.rewardTitle.setTextFormat(_loc5_);
         this.prestigeOverlayContent.updateStage(param1,param2);
      }
      
      public function as_showSuccessfullPrestige() : void
      {
         this.prestigeOverlayContent.visible = this.backButton.visible = false;
         this.rewardRibbon.visible = true;
         this.rewardRibbon.gotoAndPlay(SHOW_RIBBON_STATE);
         this.rewardTitle.visible = true;
         this.continueBTN.visible = true;
      }
      
      override protected function setData(param1:EpicBattlesPrestigeViewVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.closeButton.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.backButton.label = MENU.VIEWHEADER_BACKBTN_LABEL;
         this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
         this.continueBTN.label = DIALOGS.COMMON_SUBMIT;
         this.continueBTN.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.prestigeOverlayContent.addEventListener(EpicBattlePrestigeViewClickEvent.CANCEL_BUTTON_CLICKED,this.onCancelButtonClickedHandler);
         this.prestigeOverlayContent.addEventListener(EpicBattlePrestigeViewClickEvent.RESET_BUTTON_CLICKED,this.onResetButtonClickedHandler);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true);
      }
      
      override protected function onDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
         this.prestigeOverlayContent.removeEventListener(EpicBattlePrestigeViewClickEvent.CANCEL_BUTTON_CLICKED,this.onCancelButtonClickedHandler);
         this.prestigeOverlayContent.removeEventListener(EpicBattlePrestigeViewClickEvent.RESET_BUTTON_CLICKED,this.onResetButtonClickedHandler);
         this.continueBTN.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.backButton.dispose();
         this.backButton = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.continueBTN.dispose();
         this.continueBTN = null;
         this.prestigeOverlayContent.dispose();
         this.prestigeOverlayContent = null;
         this.rewardRibbon.dispose();
         this.rewardRibbon = null;
         this.rewardTitle.dispose();
         this.rewardTitle = null;
         this.background.dispose();
         this.background = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.prestigeOverlayContent.setData(this._data);
            this.rewardRibbon.setAwards(this._data.awards);
            this.rewardRibbon.setLevel(this._data.epicMetaLevelIconData,Linkages.EPIC_META_LEVEL_UI);
            this.continueBTN.visible = false;
            this.rewardTitle.visible = false;
            this.rewardTitle.setText(this._data.rewardTitleText);
            this.rewardRibbon.visible = false;
            this.background.setBackground(this._data.backgroundImageSrc);
         }
      }
      
      private function onCancelButtonClickedHandler(param1:EpicBattlePrestigeViewClickEvent) : void
      {
         onBackBtnClickS();
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         onCloseBtnClickS();
      }
      
      private function onBackButtonClickHandler(param1:ButtonEvent) : void
      {
         onBackBtnClickS();
      }
      
      private function onEscapeKeyDownHandler(param1:InputEvent) : void
      {
         onEscapePressS();
      }
      
      private function onResetButtonClickedHandler(param1:EpicBattlePrestigeViewClickEvent) : void
      {
         onResetBtnClickS();
      }
   }
}
