package net.wg.gui.lobby.epicBattles.views
{
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.lobby.epicBattles.components.BackgroundComponent;
   import net.wg.gui.lobby.epicBattles.components.EpicBattlesPrestigeProgress;
   import net.wg.gui.lobby.epicBattles.components.common.AlignedIconTextButton;
   import net.wg.gui.lobby.epicBattles.components.infoView.LeftInfoViewWing;
   import net.wg.gui.lobby.epicBattles.components.infoView.RewardRibbonSubView;
   import net.wg.gui.lobby.epicBattles.components.infoView.RightInfoViewWing;
   import net.wg.gui.lobby.epicBattles.components.infoView.TitleElement;
   import net.wg.gui.lobby.epicBattles.components.infoView.TutorialLine;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoViewVO;
   import net.wg.gui.lobby.epicBattles.events.EpicBattleInfoViewClickEvent;
   import net.wg.gui.lobby.epicBattles.events.RewardRibbonSubViewEvent;
   import net.wg.gui.lobby.epicBattles.utils.EpicHelper;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.EpicBattleMetaLevel;
   import net.wg.infrastructure.base.meta.IEpicBattlesInfoViewMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattlesInfoViewMeta;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   
   public class EpicBattlesInfoView extends EpicBattlesInfoViewMeta implements IEpicBattlesInfoViewMeta
   {
      
      private static const WINGS_SMALL_MODE_OFFSET:int = 52;
      
      private static const META_ICON_SMALL_MODE_HALF_WIDTH:int = 168;
      
      private static const META_ICON_SMALL_MODE_HALF_HEIGHT:int = 175;
      
      private static const META_ICON_BIG_MODE_HALF_WIDTH:int = 240;
      
      private static const META_ICON_BIG_MODE_HALF_HEIGHT:int = 250;
      
      private static const TUTORIAL_LINES_COUNT:int = 5;
      
      private static const FRONTLINE_TIER_TUTORIAL_X_OFFSET:int = 44;
      
      private static const FRONTLINE_TIER_TUTORIAL_SMALL_Y_OFFSET:int = 115;
      
      private static const FRONTLINE_TIER_TUTORIAL_REGULAR_Y_OFFSET:int = 180;
      
      private static const PRESTIGE_LEVEL_TUTORIAL_SMALL_X_OFFSET:int = 12;
      
      private static const PRESTIGE_LEVEL_TUTORIAL_REGULAR_X_OFFSET:int = 20;
      
      private static const PRESTIGE_LEVEL_TUTORIAL_SMALL_Y_OFFSET:int = 80;
      
      private static const PRESTIGE_LEVEL_TUTORIAL_REGULAR_Y_OFFSET:int = 124;
      
      private static const COMBAT_RESERVES_TUTORIAL_SMALL_X_OFFSET:int = 300;
      
      private static const COMBAT_RESERVES_TUTORIAL_REGULAR_X_OFFSET:int = 370;
      
      private static const COMBAT_RESERVES_TUTORIAL_SMALL_Y_OFFSET:int = 90;
      
      private static const COMBAT_RESERVES_TUTORIAL_REGULAR_Y_OFFSET:int = 100;
      
      private static const PRESTIGE_PROGRESS_TUTORIAL_X_OFFSET:int = 352;
      
      private static const PRESTIGE_PROGRESS_TUTORIAL_Y_OFFSET:int = 25;
      
      private static const ABOUT_LINE_IDX:int = 0;
      
      private static const TIER_LINE_IDX:int = 1;
      
      private static const PRESTIGE_LVL_LINE_IDX:int = 2;
      
      private static const COMBAT_RESERVES_LINE_IDX:int = 3;
      
      private static const PRESTIGE_PROGRESS_LINE_IDX:int = 4;
       
      
      public var aboutButton:AlignedIconTextButton = null;
      
      public var closeButton:CloseButtonText = null;
      
      public var titleElement:TitleElement = null;
      
      public var rewardRibbon:RewardRibbonSubView = null;
      
      public var epicMetaLevelIcon:EpicBattleMetaLevel = null;
      
      public var combatReservesElement:RightInfoViewWing = null;
      
      public var metaProgressElement:LeftInfoViewWing = null;
      
      public var prestigeProgressPanel:EpicBattlesPrestigeProgress = null;
      
      public var background:BackgroundComponent = null;
      
      private var _isSmallMode:Boolean = false;
      
      private var _currentWidth:int = 0;
      
      private var _currentHeight:int = 0;
      
      private var _tutorialLines:Vector.<TutorialLine> = null;
      
      private var _canClaimFinalReward:Boolean = false;
      
      public function EpicBattlesInfoView()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this._currentWidth = param1;
         this._currentHeight = param2;
         this._isSmallMode = EpicHelper.isMinResolution(param2);
         this.combatReservesElement.isSmallMode = this._isSmallMode;
         this.metaProgressElement.isSmallMode = this._isSmallMode;
         this.titleElement.isSmallMode = this._isSmallMode;
         this.rewardRibbon.updateStage(param1,param2);
         this.prestigeProgressPanel.updateStage(param1,param2);
         this.background.updateStage(param1,param2);
         this.updateLayout();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rewardRibbon.visible = false;
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true);
         this.closeButton.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.aboutButton.addEventListener(ButtonEvent.CLICK,this.onAboutInfoButtonClickHandler);
         this.rewardRibbon.addEventListener(RewardRibbonSubViewEvent.RIBBON_REWARD_BUTTON_CLICK,this.onRibbonRewardButtonClickHandler);
         this.titleElement.addEventListener(EpicBattleInfoViewClickEvent.INFO_BUTTON_CLICK,this.onInfoButtonClickHandler);
         this.metaProgressElement.addEventListener(EpicBattleInfoViewClickEvent.PRESTIGE_BUTTON_CLICK,this.onPrestigeButtonClickHandler);
         this.combatReservesElement.addEventListener(EpicBattleInfoViewClickEvent.COMBAT_CONSUMABLES_CLICK,this.onCombatConsumablesClickHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TutorialLine = null;
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
         this.rewardRibbon.removeEventListener(RewardRibbonSubViewEvent.RIBBON_REWARD_BUTTON_CLICK,this.onRibbonRewardButtonClickHandler);
         this.metaProgressElement.removeEventListener(EpicBattleInfoViewClickEvent.PRESTIGE_BUTTON_CLICK,this.onPrestigeButtonClickHandler);
         this.combatReservesElement.removeEventListener(EpicBattleInfoViewClickEvent.COMBAT_CONSUMABLES_CLICK,this.onCombatConsumablesClickHandler);
         this.epicMetaLevelIcon.dispose();
         this.epicMetaLevelIcon = null;
         this.combatReservesElement.dispose();
         this.combatReservesElement = null;
         this.metaProgressElement.dispose();
         this.metaProgressElement = null;
         this.titleElement.removeEventListener(EpicBattleInfoViewClickEvent.INFO_BUTTON_CLICK,this.onInfoButtonClickHandler);
         this.titleElement.dispose();
         this.titleElement = null;
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.closeButton.dispose();
         this.closeButton = null;
         this.aboutButton.removeEventListener(ButtonEvent.CLICK,this.onAboutInfoButtonClickHandler);
         this.aboutButton.dispose();
         this.aboutButton = null;
         this.prestigeProgressPanel.dispose();
         this.prestigeProgressPanel = null;
         this.background.dispose();
         this.background = null;
         this.rewardRibbon.dispose();
         this.rewardRibbon = null;
         if(this._tutorialLines)
         {
            for each(_loc1_ in this._tutorialLines)
            {
               _loc1_.dispose();
            }
            this._tutorialLines.splice(0,this._tutorialLines.length);
            this._tutorialLines = null;
         }
         super.onDispose();
      }
      
      override protected function setData(param1:EpicBattlesInfoViewVO) : void
      {
         this.titleElement.setData(param1.smallPageTitleHtmlText,param1.bigPageTitleHtmlText,param1.pageDescriptionHtmlText);
         this._canClaimFinalReward = param1.canClaimFinalReward;
         this.epicMetaLevelIcon.setData(param1.epicMetaLevelIconData);
         this.combatReservesElement.setData(param1.combatReservesVO);
         this.metaProgressElement.setData(param1.metaProgressVO);
         this.prestigeProgressPanel.setData(param1.prestigeProgressVO);
         this.background.setBackground(param1.backgroundImageSrc);
         this.aboutButton.label = param1.aboutButtonLabel;
         if(param1.canClaimFinalReward)
         {
            this.rewardRibbon.setData(param1.rewardRibbonDataVO);
         }
      }
      
      public function as_showInfoLines(param1:Boolean) : void
      {
         if(param1)
         {
            this._tutorialLines = new Vector.<TutorialLine>(0);
            this._tutorialLines.push(this.createTutorialLine(Linkages.BOTTOM_RIGHT_TUTORIAL_LINE_LINKAGE,Values.EMPTY_STR));
            this._tutorialLines.push(this.createTutorialLine(Linkages.TOP_RIGHT_TUTORIAL_LINE_LINKAGE,Values.EMPTY_STR));
            this._tutorialLines.push(this.createTutorialLine(Linkages.BOTTOM_LEFT_TUTORIAL_LINE_LINKAGE,Values.EMPTY_STR));
            this._tutorialLines.push(this.createTutorialLine(Linkages.BOTTOM_LEFT_TUTORIAL_LINE_LINKAGE,Values.EMPTY_STR));
            this._tutorialLines.push(this.createTutorialLine(Linkages.TOP_LEFT_TUTORIAL_LINE_LINKAGE,Values.EMPTY_STR));
            this.positionTutorialLines();
         }
      }
      
      public function as_showFinalRewardClaimed() : void
      {
         if(this._canClaimFinalReward)
         {
            this.updateLayout();
            this.titleElement.visible = false;
            this.closeButton.visible = false;
            this.epicMetaLevelIcon.visible = false;
            this.combatReservesElement.visible = false;
            this.metaProgressElement.visible = false;
            this.prestigeProgressPanel.visible = false;
            this.aboutButton.visible = false;
            this.rewardRibbon.visible = true;
            this.rewardRibbon.show();
         }
      }
      
      private function createTutorialLine(param1:String, param2:String) : TutorialLine
      {
         var _loc3_:TutorialLine = App.utils.classFactory.getComponent(param1,TutorialLine);
         _loc3_.lineTF.text = param2;
         _loc3_.mouseEnabled = _loc3_.mouseChildren = false;
         addChild(_loc3_);
         return _loc3_;
      }
      
      private function updateLayout() : void
      {
         var _loc1_:int = this._currentWidth >> 1;
         var _loc2_:int = this._currentHeight >> 1;
         this.titleElement.x = _loc1_;
         this.metaProgressElement.y = _loc2_;
         this.combatReservesElement.y = _loc2_;
         var _loc3_:int = EpicHelper.calculateStaticMargin(this._currentHeight);
         var _loc4_:Number = _loc3_ + EpicHelper.MAIN_MENU_BUTTON_BAR_HEIGHT;
         if(this._isSmallMode)
         {
            this.combatReservesElement.x = _loc1_ - WINGS_SMALL_MODE_OFFSET;
            this.metaProgressElement.x = _loc1_ + WINGS_SMALL_MODE_OFFSET;
            this.epicMetaLevelIcon.x = _loc1_ - META_ICON_SMALL_MODE_HALF_WIDTH;
            this.epicMetaLevelIcon.y = _loc2_ - META_ICON_SMALL_MODE_HALF_HEIGHT;
            this.titleElement.y = _loc4_ - EpicHelper.VISUAL_HERO_TITLE_TOP_PADDING;
         }
         else
         {
            this.combatReservesElement.x = _loc1_;
            this.metaProgressElement.x = _loc1_;
            this.epicMetaLevelIcon.x = _loc1_ - META_ICON_BIG_MODE_HALF_WIDTH;
            this.epicMetaLevelIcon.y = _loc2_ - META_ICON_BIG_MODE_HALF_HEIGHT;
            this.titleElement.y = _loc4_ - EpicHelper.VISUAL_EPIC_TITLE_TOP_PADDING;
         }
         EpicHelper.positionCloseButton(this.closeButton,this._currentHeight,this._currentWidth);
         EpicHelper.positionAboutButton(this.aboutButton,this._currentHeight,this._currentWidth);
         this.prestigeProgressPanel.x = _loc1_;
         var _loc5_:int = !!this._isSmallMode ? int(this._currentHeight - this.prestigeProgressPanel.calculateHeight()) : int(this._currentHeight - _loc3_ - this.prestigeProgressPanel.calculateHeight());
         this.prestigeProgressPanel.y = _loc5_;
         if(this._tutorialLines)
         {
            this.positionTutorialLines();
         }
         this.rewardRibbon.x = 0;
         this.rewardRibbon.y = 0;
         this.background.x = 0;
         this.background.y = 0;
      }
      
      private function positionTutorialLines() : void
      {
         assert(this._tutorialLines.length == TUTORIAL_LINES_COUNT);
         var _loc1_:int = this._currentWidth >> 1;
         var _loc2_:int = this._currentHeight >> 1;
         this._tutorialLines[ABOUT_LINE_IDX].x = this.aboutButton.x + this.aboutButton.width >> 1;
         this._tutorialLines[ABOUT_LINE_IDX].y = this.aboutButton.y + this.aboutButton.height;
         this._tutorialLines[TIER_LINE_IDX].x = _loc1_ + FRONTLINE_TIER_TUTORIAL_X_OFFSET;
         this._tutorialLines[TIER_LINE_IDX].y = !!this._isSmallMode ? Number(_loc2_ - FRONTLINE_TIER_TUTORIAL_SMALL_Y_OFFSET) : Number(_loc2_ - FRONTLINE_TIER_TUTORIAL_REGULAR_Y_OFFSET);
         this._tutorialLines[PRESTIGE_LVL_LINE_IDX].x = !!this._isSmallMode ? Number(_loc1_ - PRESTIGE_LEVEL_TUTORIAL_SMALL_X_OFFSET) : Number(_loc1_ - PRESTIGE_LEVEL_TUTORIAL_REGULAR_X_OFFSET);
         this._tutorialLines[PRESTIGE_LVL_LINE_IDX].y = !!this._isSmallMode ? Number(_loc2_ + PRESTIGE_LEVEL_TUTORIAL_SMALL_Y_OFFSET) : Number(_loc2_ + PRESTIGE_LEVEL_TUTORIAL_REGULAR_Y_OFFSET);
         this._tutorialLines[COMBAT_RESERVES_LINE_IDX].x = !!this._isSmallMode ? Number(_loc1_ + COMBAT_RESERVES_TUTORIAL_SMALL_X_OFFSET) : Number(_loc1_ + COMBAT_RESERVES_TUTORIAL_REGULAR_X_OFFSET);
         this._tutorialLines[COMBAT_RESERVES_LINE_IDX].y = !!this._isSmallMode ? Number(_loc2_ + COMBAT_RESERVES_TUTORIAL_SMALL_Y_OFFSET) : Number(_loc2_ + COMBAT_RESERVES_TUTORIAL_REGULAR_Y_OFFSET);
         this._tutorialLines[PRESTIGE_PROGRESS_LINE_IDX].x = _loc1_ - PRESTIGE_PROGRESS_TUTORIAL_X_OFFSET;
         this._tutorialLines[PRESTIGE_PROGRESS_LINE_IDX].y = this.prestigeProgressPanel.y + PRESTIGE_PROGRESS_TUTORIAL_Y_OFFSET;
      }
      
      private function onRibbonRewardButtonClickHandler(param1:RewardRibbonSubViewEvent) : void
      {
         onShowRewardVehicleInGarageBtnClickS();
      }
      
      private function onAboutInfoButtonClickHandler(param1:ButtonEvent) : void
      {
         onGameRewardsBtnClickS();
      }
      
      private function onInfoButtonClickHandler(param1:EpicBattleInfoViewClickEvent) : void
      {
         onInfoBtnClickS();
      }
      
      private function onCombatConsumablesClickHandler(param1:EpicBattleInfoViewClickEvent) : void
      {
         onManageAbilitiesBtnClickS();
      }
      
      private function onPrestigeButtonClickHandler(param1:EpicBattleInfoViewClickEvent) : void
      {
         onPrestigeBtnClickS();
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         onCloseBtnClickS();
      }
      
      private function onEscapeKeyDownHandler(param1:InputEvent) : void
      {
         onCloseBtnClickS();
      }
   }
}
