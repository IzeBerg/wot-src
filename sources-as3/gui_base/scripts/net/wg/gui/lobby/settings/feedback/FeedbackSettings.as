package net.wg.gui.lobby.settings.feedback
{
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.settings.SettingsBaseView;
   import net.wg.gui.lobby.settings.SettingsNewCountersForm;
   import net.wg.gui.lobby.settings.events.SettingViewEvent;
   import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
   import net.wg.gui.lobby.settings.feedback.questsProgress.QuestsProgressForm;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.SettingsTabNewCounterVo;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.gui.lobby.settings.vo.config.FeedbackSettingsDataVo;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class FeedbackSettings extends SettingsBaseView
   {
      
      private static const FEEDBACK_COUNTER_CONTAINER_ID:String = "FEEDBACK_COUNTER_CONTAINER_ID";
       
      
      public var tabs:ButtonBarEx = null;
      
      public var viewStack:ViewStack = null;
      
      private var _currentTabIdx:int = 0;
      
      private var _currentViewLinkage:String;
      
      private var _tabsDataProvider:IDataProvider = null;
      
      private var _feedbackData:FeedbackSettingsDataVo = null;
      
      private var _isEvent:Boolean = false;
      
      private var _dynamicFeedbackData:Object = null;
      
      private var _setDataInProgress:Boolean = false;
      
      private var _settingsTabsNewCountersVo:Vector.<SettingsTabNewCounterVo> = null;
      
      public function FeedbackSettings()
      {
         super();
      }
      
      override protected function getContainerId() : String
      {
         return FEEDBACK_COUNTER_CONTAINER_ID;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tabs.enableOversize = true;
         this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewViewChangedHandler);
         this.viewStack.addEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onViewStackOnControlChangeHandler,true);
         this.viewStack.addEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onViewStackOnControlNewCountersVisitedHandler,true);
      }
      
      override protected function setData(param1:SettingsDataVo) : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:SettingsControlProp = null;
         var _loc13_:int = 0;
         super.setData(param1);
         this._feedbackData = FeedbackSettingsDataVo(param1);
         App.utils.data.cleanupDynamicObject(this._dynamicFeedbackData);
         this._dynamicFeedbackData = {};
         this._setDataInProgress = true;
         var _loc2_:Vector.<String> = param1.keys;
         var _loc3_:Vector.<Object> = param1.values;
         var _loc4_:int = _loc2_.length;
         var _loc9_:SettingsDataVo = null;
         var _loc10_:Vector.<String> = null;
         var _loc11_:Vector.<Object> = null;
         var _loc12_:int = 0;
         while(_loc12_ < _loc4_)
         {
            _loc6_ = _loc2_[_loc12_];
            _loc9_ = SettingsDataVo(_loc3_[_loc12_]);
            App.utils.asserter.assertNotNull(_loc9_,Errors.CANT_NULL);
            _loc10_ = _loc9_.keys;
            _loc11_ = _loc9_.values;
            _loc5_ = _loc10_.length;
            _loc13_ = 0;
            while(_loc13_ < _loc5_)
            {
               _loc7_ = _loc10_[_loc13_];
               if(!this._dynamicFeedbackData.hasOwnProperty(_loc6_))
               {
                  this._dynamicFeedbackData[_loc6_] = {};
               }
               _loc8_ = SettingsControlProp(_loc11_[_loc13_]);
               this._dynamicFeedbackData[_loc6_][_loc7_] = _loc8_.current;
               _loc13_++;
            }
            _loc12_++;
         }
         this._setDataInProgress = false;
      }
      
      override protected function onDispose() : void
      {
         this._dynamicFeedbackData = App.utils.data.cleanupDynamicObject(this._dynamicFeedbackData);
         this._dynamicFeedbackData = null;
         this._settingsTabsNewCountersVo = null;
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         this.tabs.dispose();
         this.tabs = null;
         this.viewStack.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onViewStackOnControlChangeHandler,true);
         this.viewStack.removeEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onViewStackOnControlNewCountersVisitedHandler,true);
         this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewViewChangedHandler);
         this.viewStack.dispose();
         this.viewStack = null;
         this._tabsDataProvider = null;
         this._feedbackData = null;
         super.onDispose();
      }
      
      override protected function getButtonBar() : ButtonBarEx
      {
         return this.tabs;
      }
      
      override protected function getButtonBarDP() : IDataProvider
      {
         return this._tabsDataProvider;
      }
      
      override protected function updateNewCountersControls(param1:Vector.<SettingsTabNewCounterVo>) : void
      {
         this._settingsTabsNewCountersVo = param1;
         this.updateNewCounterForCurrentView(FeedbackBaseForm(this.viewStack.currentView));
      }
      
      override protected function getAvailableMarkVisitedCountersIds(param1:String, param2:Vector.<CountersVo>) : Array
      {
         var _loc3_:Array = [];
         if(StringUtils.isEmpty(param1))
         {
            return _loc3_;
         }
         return super.getAvailableMarkVisitedCountersIds(param1,param2);
      }
      
      override protected function isCounterCanMarkAsVisited(param1:String, param2:CountersVo) : Boolean
      {
         var _loc3_:SettingsControlProp = this._feedbackData[param1][param2.componentId];
         if(_loc3_ && LINE_COUNTER_TYPES.indexOf(_loc3_.type) != Values.DEFAULT_INT)
         {
            return true;
         }
         return super.isCounterCanMarkAsVisited(param1,param2);
      }
      
      public function setDataProvider(param1:DataProvider) : void
      {
         if(this._tabsDataProvider != param1 && param1 != null)
         {
            this._tabsDataProvider = param1;
            if(this.tabs.dataProvider)
            {
               this.tabs.dataProvider.cleanUp();
            }
            this.tabs.dataProvider = this._tabsDataProvider;
            this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
            this.tabs.selectedIndex = this._currentTabIdx;
         }
      }
      
      public function setIsEvent(param1:Boolean) : void
      {
         this._isEvent = param1;
         if(this.viewStack.currentView is QuestsProgressForm)
         {
            (this.viewStack.currentView as QuestsProgressForm).setIsEvent(this._isEvent);
         }
      }
      
      private function updateNewCounterForCurrentView(param1:SettingsNewCountersForm) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 && this._settingsTabsNewCountersVo)
         {
            _loc2_ = param1.formId;
            _loc3_ = this._settingsTabsNewCountersVo.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_loc2_ == this._settingsTabsNewCountersVo[_loc4_].subTabId)
               {
                  param1.updateNewCounters(this._settingsTabsNewCountersVo[_loc4_].counters);
                  return;
               }
               _loc4_++;
            }
         }
      }
      
      private function onViewStackOnControlNewCountersVisitedHandler(param1:SettingViewEvent) : void
      {
         var _loc2_:String = Boolean(param1.viewId) ? param1.viewId : viewId;
         var _loc3_:SettingViewEvent = new SettingViewEvent(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,_loc2_,param1.subViewId,param1.controlId,param1.controlValue);
         dispatchEvent(_loc3_);
      }
      
      private function onViewViewChangedHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:FeedbackBaseForm = FeedbackBaseForm(param1.view);
         _loc2_.setData(this._feedbackData[this._currentViewLinkage]);
         _loc2_.updateContent(this._dynamicFeedbackData[this._currentViewLinkage]);
         this.updateNewCounterForCurrentView(_loc2_);
      }
      
      private function onTabsIndexChangeHandler(param1:IndexEvent) : void
      {
         this._currentTabIdx = param1.index;
         this._currentViewLinkage = this._tabsDataProvider[this._currentTabIdx].linkage;
         this.viewStack.show(this._currentViewLinkage,this._currentViewLinkage);
         if(this.viewStack.currentView is QuestsProgressForm)
         {
            (this.viewStack.currentView as QuestsProgressForm).setIsEvent(this._isEvent);
         }
      }
      
      private function onViewStackOnControlChangeHandler(param1:SettingsSubVewEvent) : void
      {
         if(this._setDataInProgress)
         {
            return;
         }
         var _loc2_:String = param1.subViewId;
         var _loc3_:String = param1.controlId;
         this._dynamicFeedbackData[_loc2_][_loc3_] = param1.controlValue;
         FeedbackBaseForm(param1.target).updateContent(this._dynamicFeedbackData[this._currentViewLinkage]);
         var _loc4_:SettingViewEvent = new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,_loc2_,_loc3_,param1.controlValue);
         dispatchEvent(_loc4_);
      }
   }
}
