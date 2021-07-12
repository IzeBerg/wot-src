package net.wg.gui.messenger.windows
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.events.MessengerBarEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.messenger.evnts.ChannelsFormEvent;
   import net.wg.gui.messenger.forms.ChannelsSearchForm;
   import net.wg.gui.messenger.meta.impl.ChannelsManagementWindowMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   
   public class ChannelsManagementWindow extends ChannelsManagementWindowMeta
   {
      
      private static const WND_PADDING:Padding = new Padding(40,10,17,8);
      
      private static const WND_MAX_WIDTH:Number = 650;
      
      private static const WND_MAX_HEIGHT:Number = 400;
      
      private static const SEARCH_RESULT_LIST_LABEL_FIELD:String = "name";
       
      
      public var tabs:ButtonBarEx = null;
      
      public var tabLine:Sprite = null;
      
      public var view:ViewStack = null;
      
      protected var _searchResDataProvider:DAAPIDataProvider;
      
      private var searchLimitLabel:String = null;
      
      private var __currentTab:Number = 0;
      
      private const SEARCH_CHANNEL_FORM_ID:String = "searchChannelFormUI";
      
      private const CREATE_CHANNEL_FORM_ID:String = "createChannelFormUI";
      
      private const tabsDataProvider:Array = [{
         "label":MESSENGER.DIALOGS_CHANNELS_BUTTONS_SEARCHANDJOIN,
         "linkage":this.SEARCH_CHANNEL_FORM_ID
      },{
         "label":MESSENGER.DIALOGS_CHANNELS_BUTTONS_CREATE,
         "linkage":this.CREATE_CHANNEL_FORM_ID
      }];
      
      public function ChannelsManagementWindow()
      {
         super();
         showWindowBgForm = false;
         this._searchResDataProvider = new DAAPIDataProvider();
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         super.onSetModalFocus(param1);
         this.onViewChangeHandler();
      }
      
      override protected function draw() : void
      {
         if(this.tabs.selectedIndex == -1)
         {
            this.tabs.selectedIndex = this.__currentTab;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateViewSize();
         }
         super.draw();
      }
      
      override protected function onPopulate() : void
      {
         window.useBottomBtns = false;
         window.title = MESSENGER.LOBBY_BUTTONS_CHANNELS;
         window.contentPadding = WND_PADDING;
         window.setMaxWidth(WND_MAX_WIDTH);
         window.setMaxHeight(WND_MAX_HEIGHT);
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement(this.tabLine.name,this.tabLine,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement(this.tabs.name,this.tabs,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         updateStage(App.appWidth,App.appHeight);
         super.onPopulate();
         this.initTabs();
         this.searchLimitLabel = getSearchLimitLabelS();
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CHANNELS_WINDOW);
      }
      
      override protected function onDispose() : void
      {
         this.tabLine = null;
         this.searchLimitLabel = null;
         if(this.view)
         {
            this.view.dispose();
            this.view.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangeHandler);
            this.view.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
            this.view.removeEventListener(ChannelsFormEvent.ON_SEARCH_CHANNEL_CLICK,this.onSearchClickHandler);
            this.view.removeEventListener(ChannelsFormEvent.ON_JOIN,this.onJoinHandler);
            this.view.removeEventListener(ChannelsFormEvent.ON_CREATE_CHANNEL,this.onCreateChannelHandler);
         }
         this.view = null;
         if(this.tabs)
         {
            this.tabs.dispose();
            this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         }
         this.tabs = null;
         if(this._searchResDataProvider)
         {
            this._searchResDataProvider.cleanUp();
            this._searchResDataProvider = null;
         }
         super.onDispose();
      }
      
      public function as_freezSearchButton(param1:Boolean) : void
      {
         var _loc2_:ChannelsSearchForm = ChannelsSearchForm(this.tryGetView(this.SEARCH_CHANNEL_FORM_ID));
         if(_loc2_)
         {
            _loc2_.lockSearchButton(!param1);
         }
      }
      
      public function as_getDataProvider() : Object
      {
         return this._searchResDataProvider;
      }
      
      private function updateViewSize() : void
      {
         var _loc1_:* = null;
         var _loc2_:UIComponent = null;
         if(this.view)
         {
            for(_loc1_ in this.view.cachedViews)
            {
               _loc2_ = UIComponent(this.view.cachedViews[_loc1_]);
               _loc2_.setSize(width,height - this.view.y);
               _loc2_.validateNow();
            }
         }
      }
      
      private function initTabs() : void
      {
         if(this.tabs != null)
         {
            this.tabs.dataProvider = new DataProvider(this.tabsDataProvider);
            this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         }
         if(this.view != null)
         {
            this.view.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangeHandler);
            this.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
            this.view.addEventListener(ChannelsFormEvent.ON_SEARCH_CHANNEL_CLICK,this.onSearchClickHandler);
            this.view.addEventListener(ChannelsFormEvent.ON_JOIN,this.onJoinHandler);
            this.view.addEventListener(ChannelsFormEvent.ON_CREATE_CHANNEL,this.onCreateChannelHandler);
         }
      }
      
      private function updateView(param1:IViewStackContent, param2:Object = null) : void
      {
         param1.update(param2);
         if(param1.getComponentForFocus())
         {
            this.setFocus(param1.getComponentForFocus());
         }
      }
      
      private function tryGetView(param1:String) : MovieClip
      {
         var _loc2_:MovieClip = null;
         if(!this.view)
         {
            return null;
         }
         if(this.view.cachedViews[param1] != null)
         {
            _loc2_ = this.view.cachedViews[param1];
         }
         return _loc2_;
      }
      
      private function onViewNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         var _loc3_:ChannelsSearchForm = null;
         var _loc2_:IViewStackContent = param1.view;
         if(param1.viewId == this.SEARCH_CHANNEL_FORM_ID)
         {
            _loc3_ = ChannelsSearchForm(_loc2_);
            _loc3_.searchResultText = this.searchLimitLabel;
            _loc3_.searchResultList.dataProvider = this._searchResDataProvider;
            _loc3_.searchResultList.labelField = SEARCH_RESULT_LIST_LABEL_FIELD;
         }
         this.updateView(_loc2_);
         this.updateViewSize();
      }
      
      private function onViewChangeHandler(param1:ViewStackEvent = null) : void
      {
         if(this.view && this.view.currentView && param1 == null)
         {
            this.updateView(this.view.currentView);
         }
         else if(param1 != null)
         {
            this.updateView(param1.view);
         }
      }
      
      private function onTabIndexChangeHandler(param1:IndexEvent) : void
      {
         this.__currentTab = param1.index;
         this.updateViewSize();
      }
      
      private function onSearchClickHandler(param1:ChannelsFormEvent) : void
      {
         searchTokenS(param1.channelName);
      }
      
      private function onJoinHandler(param1:ChannelsFormEvent) : void
      {
         joinToChannelS(param1.index);
      }
      
      private function onCreateChannelHandler(param1:ChannelsFormEvent) : void
      {
         var _loc2_:Boolean = !(param1.channelPass == null && param1.channelRetypePass == null);
         createChannelS(param1.channelName,_loc2_,param1.channelPass,param1.channelRetypePass);
      }
   }
}
