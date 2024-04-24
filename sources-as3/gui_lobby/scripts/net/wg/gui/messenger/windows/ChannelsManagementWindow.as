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
   import net.wg.gui.messenger.forms.ChannelsCreateForm;
   import net.wg.gui.messenger.forms.ChannelsSearchForm;
   import net.wg.gui.messenger.meta.IChannelsManagementWindowMeta;
   import net.wg.gui.messenger.meta.impl.ChannelsManagementWindowMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   
   public class ChannelsManagementWindow extends ChannelsManagementWindowMeta implements IChannelsManagementWindowMeta
   {
      
      private static const WND_PADDING:Padding = new Padding(40,10,17,8);
      
      private static const WND_MAX_WIDTH:Number = 650;
      
      private static const WND_MAX_HEIGHT:Number = 400;
      
      private static const SEARCH_RESULT_LIST_LABEL_FIELD:String = "name";
       
      
      public var tabs:ButtonBarEx = null;
      
      public var tabLine:Sprite = null;
      
      public var viewStack:ViewStack = null;
      
      protected var searchResDataProvider:DAAPIDataProvider;
      
      private var _searchLimitLabel:String = null;
      
      private var _currentTab:Number = 0;
      
      private var _isHideChannelNameInput:Boolean = false;
      
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
         this.searchResDataProvider = new DAAPIDataProvider();
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         super.onSetModalFocus(param1);
         this.onViewStackViewChangedHandler();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ChannelsCreateForm = null;
         super.draw();
         if(this.tabs.selectedIndex == -1)
         {
            this.tabs.selectedIndex = this._currentTab;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = ChannelsCreateForm(this.tryGetView(this.CREATE_CHANNEL_FORM_ID));
            if(_loc1_)
            {
               _loc1_.hideChannelNameInput(this._isHideChannelNameInput);
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateViewSize();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement(this.tabLine.name,this.tabLine,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement(this.tabs.name,this.tabs,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         this.initTabs();
         this._searchLimitLabel = getSearchLimitLabelS();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = false;
         window.title = MESSENGER.LOBBY_BUTTONS_CHANNELS;
         window.contentPadding = WND_PADDING;
         window.setMaxWidth(WND_MAX_WIDTH);
         window.setMaxHeight(WND_MAX_HEIGHT);
         updateStage(App.appWidth,App.appHeight);
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CHANNELS_WINDOW);
      }
      
      override protected function onDispose() : void
      {
         this.tabLine = null;
         this._searchLimitLabel = null;
         if(this.viewStack)
         {
            this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
            this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewStackNeedUpdateHandler);
            this.viewStack.removeEventListener(ChannelsFormEvent.SEARCH_CHANNEL_CLICK,this.onViewStackSearchChannelClickHandler);
            this.viewStack.removeEventListener(ChannelsFormEvent.JOIN,this.onViewStackJoinHandler);
            this.viewStack.removeEventListener(ChannelsFormEvent.CREATE_CHANNEL,this.onViewStackCreateChannelHandler);
            this.viewStack.dispose();
            this.viewStack = null;
         }
         if(this.tabs)
         {
            this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
            this.tabs.dispose();
            this.tabs = null;
         }
         if(this.searchResDataProvider)
         {
            this.searchResDataProvider.cleanUp();
            this.searchResDataProvider = null;
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
         return this.searchResDataProvider;
      }
      
      public function as_hideChannelNameInput(param1:Boolean) : void
      {
         this._isHideChannelNameInput = param1;
         invalidateData();
      }
      
      private function updateViewSize() : void
      {
         var _loc1_:* = null;
         var _loc2_:UIComponent = null;
         if(this.viewStack)
         {
            for(_loc1_ in this.viewStack.cachedViews)
            {
               _loc2_ = UIComponent(this.viewStack.cachedViews[_loc1_]);
               _loc2_.setSize(width,height - this.viewStack.y);
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
         if(this.viewStack != null)
         {
            this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
            this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewStackNeedUpdateHandler);
            this.viewStack.addEventListener(ChannelsFormEvent.SEARCH_CHANNEL_CLICK,this.onViewStackSearchChannelClickHandler);
            this.viewStack.addEventListener(ChannelsFormEvent.JOIN,this.onViewStackJoinHandler);
            this.viewStack.addEventListener(ChannelsFormEvent.CREATE_CHANNEL,this.onViewStackCreateChannelHandler);
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
         if(!this.viewStack)
         {
            return null;
         }
         if(this.viewStack.cachedViews[param1] != null)
         {
            _loc2_ = this.viewStack.cachedViews[param1];
         }
         return _loc2_;
      }
      
      private function onViewStackNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         var _loc3_:ChannelsSearchForm = null;
         var _loc2_:IViewStackContent = param1.view;
         if(param1.viewId == this.SEARCH_CHANNEL_FORM_ID)
         {
            _loc3_ = ChannelsSearchForm(_loc2_);
            _loc3_.searchResultText = this._searchLimitLabel;
            _loc3_.searchResultList.dataProvider = this.searchResDataProvider;
            _loc3_.searchResultList.labelField = SEARCH_RESULT_LIST_LABEL_FIELD;
         }
         this.updateView(_loc2_);
         this.updateViewSize();
      }
      
      private function onViewStackViewChangedHandler(param1:ViewStackEvent = null) : void
      {
         if(this.viewStack && this.viewStack.currentView && param1 == null)
         {
            this.updateView(this.viewStack.currentView);
         }
         else if(param1 != null)
         {
            this.updateView(param1.view);
         }
         invalidateData();
      }
      
      private function onTabIndexChangeHandler(param1:IndexEvent) : void
      {
         this._currentTab = param1.index;
         this.updateViewSize();
      }
      
      private function onViewStackSearchChannelClickHandler(param1:ChannelsFormEvent) : void
      {
         searchTokenS(param1.channelName);
      }
      
      private function onViewStackJoinHandler(param1:ChannelsFormEvent) : void
      {
         joinToChannelS(param1.index);
      }
      
      private function onViewStackCreateChannelHandler(param1:ChannelsFormEvent) : void
      {
         var _loc2_:Boolean = !(param1.channelPass == null && param1.channelRetypePass == null);
         createChannelS(param1.channelName,_loc2_,param1.channelPass,param1.channelRetypePass);
      }
   }
}
