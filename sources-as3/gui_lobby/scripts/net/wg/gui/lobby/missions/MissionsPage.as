package net.wg.gui.lobby.missions
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.components.windows.ScreenBg;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.battleMatters.data.BattleMattersAnimVO;
   import net.wg.gui.lobby.missions.components.BattleMattersAnimWrapper;
   import net.wg.gui.lobby.missions.components.MissionsCounterDelegate;
   import net.wg.gui.lobby.missions.components.MissionsFilter;
   import net.wg.gui.lobby.missions.data.MissionTabCounterVO;
   import net.wg.gui.lobby.missions.data.MissionTabVO;
   import net.wg.gui.lobby.missions.event.MissionViewEvent;
   import net.wg.infrastructure.base.interfaces.IWaiting;
   import net.wg.infrastructure.base.meta.IMissionsPageMeta;
   import net.wg.infrastructure.base.meta.impl.MissionsPageMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class MissionsPage extends MissionsPageMeta implements IMissionsPageMeta
   {
      
      private static const SCROLL_WIDTH:int = 13;
      
      private static const MIN_BTN_WIDTH:int = 140;
      
      private static const FILTER_OFFSET_LEFT:int = 479;
      
      private static const INV_TABS_COUNTER_DATA:String = "invTabsCounterData";
       
      
      public var tabBar:ContentTabBar;
      
      public var viewStack:ViewStack;
      
      public var filter:MissionsFilter;
      
      public var topShadowBg:Sprite;
      
      public var bg:ScreenBg;
      
      public var separator:ISeparatorAsset;
      
      public var waiting:IWaiting = null;
      
      private var _tabsDataProvider:IDataProvider;
      
      private var _counterHelper:MissionsCounterDelegate;
      
      private var _tabsCounterData:Vector.<MissionTabCounterVO>;
      
      private var _isFilterVisible:Boolean = true;
      
      private var _isTopShadowVisible:Boolean = true;
      
      private var _battleMattersAnimWrapper:BattleMattersAnimWrapper;
      
      public function MissionsPage()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setViewSize(param1,param2);
         this.updateViewSize();
         if(this._battleMattersAnimWrapper)
         {
            this._battleMattersAnimWrapper.updateStage(param1,param2);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MissionViewEvent.SHOW_WAITING,this.onShowWaitingHandler);
         this.viewStack.cache = true;
         this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
         this.tabBar.selectedIndex = -1;
         this.tabBar.enableOversize = true;
         this.tabBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabBarIndexChangeHandler);
         this.tabBar.minRendererWidth = MIN_BTN_WIDTH;
         this.filter.addEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFilterResetAllFiltersHandler);
         this.waiting.setMessage(WAITING.LOADCONTENT);
         this.waiting.backgroundVisibility = false;
         this._counterHelper = new MissionsCounterDelegate();
         this.bg.isShowHeaderBg = false;
         this.separator.setType(SeparatorConstants.MEDIUM_TYPE);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyHandler,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MissionTabVO = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.waiting.width = _width;
            this.waiting.height = _height;
            this.bg.setSize(_width,_height);
            this.tabBar.x = _width - this.tabBar.width >> 1;
            this.separator.x = _width - this.separator.width >> 1;
            this.topShadowBg.x = SCROLL_WIDTH;
            this.topShadowBg.width = _width - (SCROLL_WIDTH << 1);
            this.updateViewSize();
            this.filter.x = (_width >> 1) - FILTER_OFFSET_LEFT;
         }
         if(this._tabsDataProvider && isInvalid(InvalidationType.DATA))
         {
            setFocus(this);
            _loc1_ = -1;
            for each(_loc2_ in this._tabsDataProvider)
            {
               _loc1_++;
               if(_loc2_.selected)
               {
                  this.tabBar.selectedIndex = _loc1_;
                  if(this.viewStack.currentViewId != _loc2_.linkage)
                  {
                     this.viewStack.show(_loc2_.linkage,_loc2_.linkage);
                  }
                  break;
               }
            }
         }
         if(this._tabsCounterData && isInvalid(INV_TABS_COUNTER_DATA))
         {
            this._counterHelper.setSettingsItems(this._tabsCounterData,this.tabBar);
            this.setTabBarLabels();
         }
      }
      
      override protected function setTabsDataProvider(param1:DataProvider) : void
      {
         this._tabsDataProvider = param1;
         this.tabBar.dataProvider = this._tabsDataProvider;
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyHandler);
         removeEventListener(MissionViewEvent.SHOW_WAITING,this.onShowWaitingHandler);
         this._counterHelper.dispose();
         this._counterHelper = null;
         this.tabBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabBarIndexChangeHandler);
         this.tabBar.dispose();
         this.tabBar = null;
         if(this._battleMattersAnimWrapper)
         {
            this._battleMattersAnimWrapper.dispose();
            this._battleMattersAnimWrapper = null;
         }
         this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
         this.viewStack.dispose();
         this.viewStack = null;
         this.filter.removeEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFilterResetAllFiltersHandler);
         this.filter.dispose();
         this.filter = null;
         this.separator.dispose();
         this.separator = null;
         this.bg.dispose();
         this.bg = null;
         this.waiting.dispose();
         this.waiting = null;
         this.topShadowBg = null;
         this._tabsDataProvider = null;
         this._tabsCounterData = null;
         super.onDispose();
      }
      
      override protected function setTabsCounterData(param1:Vector.<MissionTabCounterVO>) : void
      {
         this._tabsCounterData = param1;
         invalidate(INV_TABS_COUNTER_DATA);
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         if(param1 == null)
         {
            param1 = this;
         }
         super.onSetModalFocus(param1);
      }
      
      public function as_blinkFilterCounter() : void
      {
         this.filter.blink();
      }
      
      override protected function showBattleMattersAnimation(param1:String, param2:BattleMattersAnimVO) : void
      {
         if(!this._battleMattersAnimWrapper)
         {
            this._battleMattersAnimWrapper = new BattleMattersAnimWrapper(this);
            addChildAt(this._battleMattersAnimWrapper,getChildIndex(this.tabBar));
            this._battleMattersAnimWrapper.updateStage(_originalWidth,_originalHeight);
         }
         this._battleMattersAnimWrapper.showAnimation(param1,param2);
      }
      
      public function as_showFilter(param1:Boolean, param2:Boolean) : void
      {
         this._isFilterVisible = param1;
         this._isTopShadowVisible = param2;
         this.filter.visible = this._isFilterVisible;
         this.topShadowBg.visible = this._isTopShadowVisible;
      }
      
      public function as_showFilterCounter(param1:String, param2:Boolean) : void
      {
         this.filter.showFilterCounter(param1,param2);
      }
      
      private function updateViewSize() : void
      {
         if(this.viewStack.currentView)
         {
            this.viewStack.currentView.height = _height - this.viewStack.y;
            this.viewStack.currentView.width = _width;
         }
      }
      
      private function setContentVisible(param1:Boolean) : void
      {
         this.tabBar.visible = param1;
         this.viewStack.visible = param1;
         if(this._isFilterVisible)
         {
            this.filter.visible = param1;
         }
         if(this._isTopShadowVisible)
         {
            this.topShadowBg.visible = param1;
         }
         this.separator.visible = param1;
      }
      
      private function setTabBarLabels() : void
      {
         var _loc2_:MissionTabCounterVO = null;
         var _loc3_:Button = null;
         var _loc1_:int = this._tabsCounterData.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = this._tabsCounterData[_loc4_];
            _loc3_ = this.tabBar.getButtonAt(_loc4_);
            _loc3_.label = _loc2_.label;
            _loc4_++;
         }
      }
      
      private function getAliasByLinkage(param1:String) : String
      {
         var _loc2_:MissionTabVO = null;
         for each(_loc2_ in this._tabsDataProvider)
         {
            if(_loc2_.linkage == param1)
            {
               return _loc2_.alias;
            }
         }
         return null;
      }
      
      override protected function get autoShowViewProperty() : int
      {
         return SHOW_VIEW_PROP_FORBIDDEN;
      }
      
      override public function get isModal() : Boolean
      {
         return true;
      }
      
      private function onEscapeKeyHandler(param1:Event) : void
      {
         onCloseS();
      }
      
      private function onViewStackViewChangedHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:String = this.getAliasByLinkage(param1.viewId);
         App.utils.asserter.assertNotNull(_loc2_,"Alias for linkage " + _loc2_ + Errors.WASNT_FOUND);
         if(!isFlashComponentRegisteredS(_loc2_))
         {
            registerFlashComponentS(IDAAPIModule(param1.view),_loc2_);
         }
         this.updateViewSize();
      }
      
      private function onTabBarIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:MissionTabVO = null;
         if(param1.lastIndex != -1 && param1.data)
         {
            _loc2_ = MissionTabVO(param1.data);
            this.viewStack.currentView.dispatchEvent(new ComponentEvent(ComponentEvent.HIDE));
            this.viewStack.show(_loc2_.linkage,_loc2_.linkage);
            onTabSelectedS(_loc2_.alias,_loc2_.prefix);
         }
      }
      
      private function onFilterResetAllFiltersHandler(param1:Event) : void
      {
         resetFiltersS();
      }
      
      private function onShowWaitingHandler(param1:MissionViewEvent) : void
      {
         this.setContentVisible(!param1.isWaiting);
         if(param1.isWaiting)
         {
            this.waiting.show();
         }
         else
         {
            this.waiting.hide();
         }
         invalidateSize();
      }
   }
}
