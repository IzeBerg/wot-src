package net.wg.gui.lobby.epicBattles.views
{
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.lobby.epicBattles.components.BackgroundComponent;
   import net.wg.gui.lobby.epicBattles.components.EpicBattlesPrestigeProgress;
   import net.wg.gui.lobby.epicBattles.components.common.AlignedIconTextButton;
   import net.wg.gui.lobby.epicBattles.components.offlineView.CenterBlock;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesOfflineViewVO;
   import net.wg.gui.lobby.epicBattles.utils.EpicHelper;
   import net.wg.infrastructure.base.meta.IEpicBattlesOfflineViewMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattlesOfflineViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   
   public class EpicBattlesOfflineView extends EpicBattlesOfflineViewMeta implements IEpicBattlesOfflineViewMeta
   {
       
      
      public var aboutButton:AlignedIconTextButton = null;
      
      public var closeButton:CloseButtonText = null;
      
      public var title:TextField = null;
      
      public var centerBlock:CenterBlock = null;
      
      public var prestigeProgressPanel:EpicBattlesPrestigeProgress = null;
      
      public var background:BackgroundComponent = null;
      
      private var _initData:EpicBattlesOfflineViewVO;
      
      private var _currentWidth:int = 0;
      
      private var _currentHeight:int = 0;
      
      public function EpicBattlesOfflineView()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this._currentWidth = param1;
         this._currentHeight = param2;
         this.prestigeProgressPanel.updateStage(param1,param2);
         invalidateSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true);
         this.closeButton.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.aboutButton.addEventListener(ButtonEvent.CLICK,this.onAboutButtonClickHandler);
      }
      
      override protected function onDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.closeButton.dispose();
         this.closeButton = null;
         this.aboutButton.removeEventListener(ButtonEvent.CLICK,this.onAboutButtonClickHandler);
         this.aboutButton.dispose();
         this.aboutButton = null;
         this.title = null;
         this.background.dispose();
         this.background = null;
         this.centerBlock.dispose();
         this.centerBlock = null;
         this.prestigeProgressPanel.dispose();
         this.prestigeProgressPanel = null;
         this._initData = null;
         super.onDispose();
      }
      
      override protected function setData(param1:EpicBattlesOfflineViewVO) : void
      {
         this._initData = param1;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            this.title.htmlText = this._initData.headlineTitleHtmlTextBig;
            this.centerBlock.setData(this._initData.calendarText,this._initData.calendarSubTitleHtmlText,EPIC_BATTLE.EPICBATTLESOFFLINEVIEW_CALENDARDESCRIPTION);
            this.prestigeProgressPanel.setData(this._initData.prestigeProgressVO);
            this.background.setBackground(this._initData.backgroundImageSrc);
            this.aboutButton.label = EPIC_BATTLE.EPICBATTLESOFFLINEVIEW_GAMERULES;
            if(EpicHelper.isMinResolution(this._currentHeight))
            {
               this.title.htmlText = this._initData.headlineTitleHtmlTextSmall;
            }
            else
            {
               this.title.htmlText = this._initData.headlineTitleHtmlTextBig;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.layoutElements();
         }
      }
      
      public function layoutElements() : void
      {
         var _loc1_:int = EpicHelper.calculateStaticMargin(this._currentHeight);
         var _loc2_:Number = _loc1_ + EpicHelper.MAIN_MENU_BUTTON_BAR_HEIGHT;
         var _loc3_:Boolean = EpicHelper.isMinResolution(this._currentHeight);
         var _loc4_:int = 0;
         if(_loc3_)
         {
            this.title.y = _loc2_ - EpicHelper.VISUAL_HERO_TITLE_TOP_PADDING;
            _loc4_ = _loc2_ + EpicHelper.VISUAL_HERO_TITLE_FONT_HEIGHT;
         }
         else
         {
            this.title.y = _loc2_ - EpicHelper.VISUAL_EPIC_TITLE_TOP_PADDING;
            _loc4_ = _loc2_ + EpicHelper.VISUAL_EPIC_TITLE_FONT_HEIGHT;
         }
         this.title.x = this._currentWidth - this.title.width >> 1;
         var _loc5_:int = this.centerBlock.height;
         var _loc6_:int = this._currentHeight - _loc1_ - this.prestigeProgressPanel.calculateHeight();
         var _loc7_:int = _loc6_ - _loc4_ - _loc5_ >> 1;
         this.centerBlock.y = _loc4_ + _loc7_;
         this.centerBlock.x = this._currentWidth - this.centerBlock.width >> 1;
         EpicHelper.positionCloseButton(this.closeButton,this._currentHeight,this._currentWidth);
         EpicHelper.positionAboutButton(this.aboutButton,this._currentHeight,this._currentWidth);
         this.prestigeProgressPanel.x = this._currentWidth >> 1;
         this.prestigeProgressPanel.y = _loc6_;
         this.prestigeProgressPanel.x = this._currentWidth >> 1;
         var _loc8_:int = !!_loc3_ ? int(this._currentHeight - this.prestigeProgressPanel.calculateHeight()) : int(this._currentHeight - _loc1_ - this.prestigeProgressPanel.calculateHeight());
         this.prestigeProgressPanel.y = _loc8_;
         this.background.x = 0;
         this.background.y = 0;
         this.background.updateStage(this._currentWidth,this._currentHeight);
      }
      
      private function onAboutButtonClickHandler(param1:ButtonEvent) : void
      {
         onAboutButtonClickS();
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
