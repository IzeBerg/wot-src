package net.wg.gui.lobby.sessionStats
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.ButtonPropertiesVO;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.SESSION_STATS_CONSTANTS;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.IResizableContent;
   import net.wg.gui.lobby.sessionStats.components.SessionStatsAnimatedCounter;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsOverviewVO;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsTabVO;
   import net.wg.gui.lobby.sessionStats.events.SessionStatsPopoverResizeEvent;
   import net.wg.infrastructure.base.meta.ISessionStatsOverviewMeta;
   import net.wg.infrastructure.base.meta.impl.SessionStatsOverviewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   
   public class SessionStatsOverview extends SessionStatsOverviewMeta implements IResizableContent, ISessionStatsOverviewMeta
   {
      
      private static const MIN_TAB_WIDTH:int = 142;
      
      private static const BUTTON_STATES_INVALID:String = "buttonStatesInvalid";
       
      
      public var battleStats:SessionBattleStatsView = null;
      
      public var vehicleStats:SessionVehicleStatsView = null;
      
      public var buttonBar:ContentTabBar = null;
      
      public var moreBtn:ISoundButtonEx = null;
      
      public var resetBtn:ISoundButtonEx = null;
      
      public var settingsBtn:IButtonIconLoader = null;
      
      public var lipBg:MovieClip = null;
      
      public var headerBg:Image = null;
      
      public var title:TextField = null;
      
      public var overlay:MovieClip = null;
      
      public var counterAnimated:SessionStatsAnimatedCounter = null;
      
      private var _titleTooltip:String = "";
      
      private var _data:SessionStatsOverviewVO = null;
      
      private var _buttons:Array = null;
      
      private var _buttonStates:Vector.<ButtonPropertiesVO> = null;
      
      private var _isExpanded:Boolean;
      
      public function SessionStatsOverview()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:SessionStatsTabVO = null;
         var _loc4_:ISoundButtonEx = null;
         var _loc5_:ButtonPropertiesVO = null;
         var _loc6_:Number = NaN;
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.battleStats.update(this._data);
            this.headerBg.source = this._data.headerImg;
            this.buttonBar.dataProvider = this._data.tabs;
            _loc2_ = this._data.tabs.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this._data.tabs[_loc1_];
               if(_loc3_.selected)
               {
                  this.buttonBar.selectedIndex = _loc1_;
                  this.updateTabsView();
                  break;
               }
               _loc1_++;
            }
            this.title.htmlText = this._data.title;
            this.counterAnimated.goToNumber(this._data.lastBattleCount);
            this.counterAnimated.animateTo(this._data.battleCount);
            this.counterAnimated.x = width >> 1;
         }
         if(this._buttonStates && isInvalid(BUTTON_STATES_INVALID))
         {
            _loc2_ = this._buttons.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this._buttons[_loc1_];
               _loc5_ = this._buttonStates[_loc1_];
               _loc4_.tooltip = _loc5_.btnTooltip;
               _loc4_.label = _loc5_.btnLabel;
               _loc4_.enabled = _loc5_.btnEnabled;
               if(_loc4_ is IButtonIconLoader)
               {
                  (_loc4_ as IButtonIconLoader).iconSource = _loc5_.btnIcon;
               }
               _loc1_++;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.lipBg.y = height - (this.lipBg.height >> 1);
            this.moreBtn.y = this.resetBtn.y = this.settingsBtn.y = this.lipBg.y + (height - this.lipBg.y - this.moreBtn.height >> 1);
            _loc6_ = height - this.battleStats.y - (this.lipBg.height >> 1);
            this.battleStats.setViewSize(width,_loc6_);
            this.vehicleStats.setViewSize(width,_loc6_);
         }
         super.draw();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.battleStats.addEventListener(SessionStatsPopoverResizeEvent.EXPANDED,this.onContentExpandedHandler);
         this.buttonBar.minRendererWidth = MIN_TAB_WIDTH;
         this.buttonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
         this.title.addEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.title.addEventListener(MouseEvent.ROLL_OUT,this.onTitleRollOutHandler);
         this.moreBtn.addEventListener(ButtonEvent.CLICK,this.onMoreBtnClickHandler);
         this.resetBtn.addEventListener(ButtonEvent.CLICK,this.onResetBtnClickHandler);
         this.settingsBtn.addEventListener(ButtonEvent.CLICK,this.onSettingsBtnClickHandler);
         this.moreBtn.mouseEnabledOnDisabled = true;
         this.resetBtn.mouseEnabledOnDisabled = true;
         this.settingsBtn.mouseEnabledOnDisabled = true;
         this._buttons = [this.moreBtn,this.resetBtn,this.settingsBtn];
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.registerComponents();
      }
      
      private function registerComponents() : void
      {
         if(!isFlashComponentRegisteredS(SESSION_STATS_CONSTANTS.SESSION_BATTLE_STATS_VIEW_PY_ALIAS))
         {
            registerFlashComponentS(this.battleStats,SESSION_STATS_CONSTANTS.SESSION_BATTLE_STATS_VIEW_PY_ALIAS);
         }
         if(!isFlashComponentRegisteredS(SESSION_STATS_CONSTANTS.SESSION_VEHICLE_STATS_VIEW_PY_ALIAS))
         {
            registerFlashComponentS(this.vehicleStats,SESSION_STATS_CONSTANTS.SESSION_VEHICLE_STATS_VIEW_PY_ALIAS);
         }
         invalidateSize();
      }
      
      override protected function onDispose() : void
      {
         this.buttonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
         this.buttonBar.dispose();
         this.buttonBar = null;
         this.battleStats.removeEventListener(SessionStatsPopoverResizeEvent.EXPANDED,this.onContentExpandedHandler);
         this.battleStats = null;
         this.vehicleStats = null;
         this.moreBtn.removeEventListener(ButtonEvent.CLICK,this.onMoreBtnClickHandler);
         this.moreBtn.dispose();
         this.moreBtn = null;
         this.resetBtn.removeEventListener(ButtonEvent.CLICK,this.onResetBtnClickHandler);
         this.resetBtn.dispose();
         this.resetBtn = null;
         this.settingsBtn.removeEventListener(ButtonEvent.CLICK,this.onSettingsBtnClickHandler);
         this.settingsBtn.dispose();
         this.settingsBtn = null;
         this.headerBg.dispose();
         this.headerBg = null;
         this.counterAnimated.dispose();
         this.counterAnimated = null;
         this.title.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.title.removeEventListener(MouseEvent.ROLL_OUT,this.onTitleRollOutHandler);
         this.title = null;
         this._buttons.splice(0,this._buttons.length);
         this._buttons = null;
         this.overlay = null;
         this.lipBg = null;
         this._data = null;
         this._buttonStates = null;
         super.onDispose();
      }
      
      override protected function setData(param1:SessionStatsOverviewVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function setButtonsState(param1:Vector.<ButtonPropertiesVO>) : void
      {
         this._buttonStates = param1;
         invalidate(BUTTON_STATES_INVALID);
      }
      
      private function onContentExpandedHandler(param1:SessionStatsPopoverResizeEvent) : void
      {
         var _loc2_:Boolean = Boolean(param1.data);
         this.expand(_loc2_);
         onExpandedS(_loc2_);
      }
      
      private function expand(param1:Boolean) : void
      {
         this._isExpanded = param1;
         invalidateSize();
      }
      
      private function updateTabsView() : void
      {
         if(this.buttonBar.selectedIndex == 0)
         {
            this.battleStats.visible = true;
            this.vehicleStats.visible = false;
         }
         else
         {
            this.battleStats.visible = false;
            this.vehicleStats.visible = true;
         }
      }
      
      private function onButtonBarIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:SessionStatsTabVO = null;
         if(param1.lastIndex != -1 && param1.data)
         {
            this.updateTabsView();
            _loc2_ = SessionStatsTabVO(param1.data);
            onTabSelectedS(_loc2_.alias);
         }
      }
      
      private function onTitleRollOverHandler(param1:MouseEvent) : void
      {
         if(this._titleTooltip != Values.EMPTY_STR)
         {
            App.toolTipMgr.showComplex(this._titleTooltip,null);
         }
      }
      
      private function onTitleRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onMoreBtnClickHandler(param1:ButtonEvent) : void
      {
         if(this.moreBtn.enabled)
         {
            onClickMoreBtnS();
         }
      }
      
      private function onResetBtnClickHandler(param1:ButtonEvent) : void
      {
         if(this.resetBtn.enabled)
         {
            onClickResetBtnS();
         }
      }
      
      private function onSettingsBtnClickHandler(param1:ButtonEvent) : void
      {
         if(this.settingsBtn.enabled)
         {
            onClickSettingsBtnS();
         }
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         _width = param1;
         _height = param2;
         invalidateSize();
      }
      
      public function get centerOffset() : int
      {
         return 0;
      }
      
      public function set centerOffset(param1:int) : void
      {
      }
      
      public function get active() : Boolean
      {
         return false;
      }
      
      public function set active(param1:Boolean) : void
      {
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function update(param1:Object) : void
      {
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return undefined;
      }
      
      public function as_setHeaderTooltip(param1:String) : void
      {
         this._titleTooltip = param1;
      }
   }
}
