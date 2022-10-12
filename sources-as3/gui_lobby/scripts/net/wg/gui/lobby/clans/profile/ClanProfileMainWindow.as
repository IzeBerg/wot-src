package net.wg.gui.lobby.clans.profile
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.Dummy;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.advanced.events.DummyEvent;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.components.common.waiting.WaitingComponent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.clans.common.ClanTabDataProviderVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileMainWindowVO;
   import net.wg.gui.lobby.clans.profile.views.ClanProfileBaseView;
   import net.wg.infrastructure.base.meta.IClanProfileMainWindowMeta;
   import net.wg.infrastructure.base.meta.impl.ClanProfileMainWindowMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.utils.IUtils;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.utils.Padding;
   
   public class ClanProfileMainWindow extends ClanProfileMainWindowMeta implements IClanProfileMainWindowMeta
   {
      
      private static const BG_WINDOW_SPACE:int = 4;
       
      
      public var tabs:ButtonBarEx = null;
      
      public var waitingCmp:WaitingComponent = null;
      
      public var viewStack:ViewStack = null;
      
      public var windowBG:Sprite = null;
      
      public var dummy:Dummy = null;
      
      private var _windowWidth:int = -1;
      
      private var _windowHeight:int = -1;
      
      private var _windowPadding:Padding = null;
      
      private var _registeredLinkages:Vector.<String> = null;
      
      private var _currentLinkage:String = "";
      
      private var _utils:IUtils = null;
      
      public function ClanProfileMainWindow()
      {
         super();
         this._utils = App.utils;
      }
      
      override protected function onDispose() : void
      {
         this._utils.scheduler.cancelTask(this.updateWindowSize);
         this.removeListeners();
         this._windowPadding = null;
         this.waitingCmp.dispose();
         this.waitingCmp = null;
         this.viewStack.dispose();
         this.viewStack = null;
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         this.tabs.dispose();
         this.tabs = null;
         if(this._registeredLinkages)
         {
            this._registeredLinkages.splice(0,this._registeredLinkages.length);
            this._registeredLinkages = null;
         }
         this._utils = null;
         this.removeChild(this.windowBG);
         this.windowBG = null;
         this.dummy.dispose();
         this.dummy = null;
         super.onDispose();
      }
      
      override protected function setData(param1:ClanProfileMainWindowVO) : void
      {
         this.waitingCmp.setMessage(param1.waitingMsg);
         this.tabs.dataProvider = param1.tabDataProvider;
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         this.tabs.selectedIndex = 0;
         this._utils.scheduler.scheduleOnNextFrame(this.updateWindowSize);
      }
      
      override protected function onPopulate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.onPopulate();
         this.waitingCmp.x = this.viewStack.x ^ 0;
         this.waitingCmp.y = this.viewStack.y ^ 0;
         _loc1_ = this.windowBG.width - BG_WINDOW_SPACE ^ 0;
         _loc2_ = this.windowBG.height - BG_WINDOW_SPACE ^ 0;
         this.waitingCmp.setSize(_loc1_,_loc2_);
         this.waitingCmp.visible = false;
         this.waitingCmp.setAnimationStatus(true);
         this.dummy.x = this.viewStack.x ^ 0;
         this.dummy.y = this.viewStack.y ^ 0;
         this.dummy.setSize(_loc1_,_loc2_);
         this.hideDummy();
         showWindowBgForm = false;
         this._windowPadding = Padding(window.contentPadding);
         this.addListeners();
      }
      
      public function as_setWindowTitle(param1:String) : void
      {
         window.title = param1;
      }
      
      private function addListeners() : void
      {
         this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
         this.addEventListener(ClanProfileEvent.NAVIGATION_BY_LINKAGE,this.onNavigationByLinkageHandler);
         this.addEventListener(ClanProfileEvent.SHOW_WAITING,this.onShowWaitingHandler);
         this.addEventListener(ClanProfileEvent.HIDE_WAITING,this.onHideWaitingHandler);
         this.addEventListener(DummyEvent.SHOW_DUMMY,this.onShowDummyHandler);
         this.addEventListener(DummyEvent.HIDE_DUMMY,this.onHideDummyHandler);
      }
      
      private function removeListeners() : void
      {
         this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
         this.removeEventListener(ClanProfileEvent.NAVIGATION_BY_LINKAGE,this.onNavigationByLinkageHandler);
         this.removeEventListener(ClanProfileEvent.SHOW_WAITING,this.onShowWaitingHandler);
         this.removeEventListener(ClanProfileEvent.HIDE_WAITING,this.onHideWaitingHandler);
         this.removeEventListener(DummyEvent.SHOW_DUMMY,this.onShowDummyHandler);
         this.removeEventListener(DummyEvent.HIDE_DUMMY,this.onHideDummyHandler);
      }
      
      private function updateWindowSize() : void
      {
         var _loc1_:IViewStackContent = this.viewStack.currentView;
         assertNotNull(_loc1_,"updateWindowSize view");
         var _loc2_:int = _loc1_.width + this._windowPadding.horizontal;
         var _loc3_:int = _loc1_.height + this._windowPadding.vertical;
         if(_loc3_ == this._windowHeight && _loc2_ == this._windowWidth)
         {
            return;
         }
         window.updateSize(_loc2_,_loc3_);
         this._windowWidth = _loc2_;
         this._windowHeight = _loc3_;
      }
      
      private function changeWaitingState(param1:Boolean) : void
      {
         var _loc2_:Boolean = this._currentLinkage == this.viewStack.currentViewId;
         if(!param1 && _loc2_)
         {
            this.viewStack.currentView.visible = true;
         }
         if(this.waitingCmp.visible == param1 || !_loc2_)
         {
            return;
         }
         this.waitingCmp.visible = param1;
         this.waitingCmp.setAnimationStatus(!param1);
      }
      
      private function checkCurrentLinkages(param1:Boolean, param2:String) : void
      {
         if(param2 == this._currentLinkage)
         {
            this.changeWaitingState(param1);
         }
      }
      
      private function changeDummyState(param1:DummyVO) : void
      {
         if(param1 != null)
         {
            this.showDummy(param1);
         }
         else
         {
            this.hideDummy();
         }
      }
      
      private function showDummy(param1:DummyVO) : void
      {
         this.dummy.visible = true;
         this.dummy.setData(param1);
         this.viewStack.visible = false;
      }
      
      private function hideDummy() : void
      {
         this.dummy.visible = false;
         this.viewStack.visible = true;
      }
      
      private function onNavigationByLinkageHandler(param1:ClanProfileEvent) : void
      {
         var _loc6_:String = null;
         var _loc2_:DataProvider = DataProvider(this.tabs.dataProvider);
         var _loc3_:int = 0;
         var _loc4_:int = _loc2_.length;
         var _loc5_:String = param1.getTargetLinkage();
         while(_loc3_ < _loc4_)
         {
            _loc6_ = ClanTabDataProviderVO(_loc2_[_loc3_]).linkage;
            if(_loc6_ == _loc5_)
            {
               this.tabs.selectedIndex = _loc3_;
               break;
            }
            _loc3_++;
         }
      }
      
      private function onViewStackViewChangedHandler(param1:ViewStackEvent) : void
      {
         if(!this._registeredLinkages)
         {
            this._registeredLinkages = new Vector.<String>();
         }
         this._currentLinkage = param1.viewId;
         var _loc2_:ClanProfileBaseView = ClanProfileBaseView(param1.view);
         this.changeWaitingState(_loc2_.isShowWaiting());
         if(this._registeredLinkages.indexOf(this._currentLinkage) == -1)
         {
            this._registeredLinkages.push(this._currentLinkage);
            var _loc3_:String = Values.EMPTY_STR;
            if(this._currentLinkage == CLANS_ALIASES.CLAN_PROFILE_SUMMARY_VIEW_LINKAGE)
            {
               _loc3_ = CLANS_ALIASES.CLAN_PROFILE_SUMMARY_VIEW_ALIAS;
               registerFlashComponentS(IDAAPIModule(param1.view),_loc3_);
            }
            else if(this._currentLinkage == CLANS_ALIASES.CLAN_PROFILE_PERSONNEL_VIEW_LINKAGE)
            {
               _loc3_ = CLANS_ALIASES.CLAN_PROFILE_PERSONNEL_VIEW_ALIAS;
               registerFlashComponentS(IDAAPIModule(param1.view),_loc3_);
            }
            else if(this._currentLinkage == CLANS_ALIASES.CLAN_PROFILE_STRONGHOLDS_VIEW_LINKAGE)
            {
               _loc3_ = CLANS_ALIASES.CLAN_PROFILE_STRONGHOLDS_VIEW_ALIAS;
               registerFlashComponentS(IDAAPIModule(param1.view),_loc3_);
               this.changeWaitingState(false);
            }
            else if(this._currentLinkage == CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_VIEW_LINKAGE)
            {
               _loc3_ = CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_VIEW_ALIAS;
               registerFlashComponentS(IDAAPIModule(param1.view),_loc3_);
            }
            return;
         }
         this.changeDummyState(_loc2_.getDummyData());
      }
      
      private function onTabsIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:String = ClanTabDataProviderVO(param1.data).linkage;
         this.viewStack.show(_loc2_,_loc2_);
      }
      
      private function onShowWaitingHandler(param1:ClanProfileEvent) : void
      {
         this.checkCurrentLinkages(true,param1.getTargetLinkage());
      }
      
      private function onHideWaitingHandler(param1:ClanProfileEvent) : void
      {
         this.checkCurrentLinkages(false,param1.getTargetLinkage());
      }
      
      private function onShowDummyHandler(param1:DummyEvent) : void
      {
         var _loc2_:ClanProfileBaseView = ClanProfileBaseView(param1.target);
         if(_loc2_.currentLinkage == this._currentLinkage)
         {
            this.showDummy(param1.data);
         }
      }
      
      private function onHideDummyHandler(param1:DummyEvent) : void
      {
         var _loc2_:ClanProfileBaseView = ClanProfileBaseView(param1.target);
         if(_loc2_.currentLinkage == this._currentLinkage)
         {
            this.hideDummy();
         }
      }
   }
}
