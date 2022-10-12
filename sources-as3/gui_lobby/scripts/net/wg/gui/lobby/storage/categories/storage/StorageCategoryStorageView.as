package net.wg.gui.lobby.storage.categories.storage
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.ViewStackEx;
   import net.wg.gui.components.controls.tabs.OrangeTabMenu;
   import net.wg.gui.components.controls.tabs.OrangeTabsMenuVO;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.storage.categories.ICategory;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.base.meta.IStorageCategoryStorageViewMeta;
   import net.wg.infrastructure.base.meta.impl.StorageCategoryStorageViewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IViewStackExContent;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import net.wg.utils.IUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   
   public class StorageCategoryStorageView extends StorageCategoryStorageViewMeta implements IStorageCategoryStorageViewMeta, IViewStackExContent, ICategory
   {
      
      public static var COUNTER_CONTAINER_ID:String = "StorageCategoryStorageViewContainer";
      
      private static var _counterProps:ICounterProps = new CounterProps(-30,5);
      
      private static const SIDE_BAR_COUNTER:String = "sideBarCounter";
       
      
      public var title:TextField;
      
      public var tabButtonBar:OrangeTabMenu = null;
      
      public var content:ViewStackEx;
      
      private var _utils:IUtils = null;
      
      private var _counterManager:ICounterManager = null;
      
      private var _tabCounters:Object;
      
      private var _hitArea:Sprite;
      
      public function StorageCategoryStorageView()
      {
         this._tabCounters = {};
         super();
         this._utils = App.utils;
         this._counterManager = this._utils.counterManager;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         this.content.setSize(param1 - this.content.x,param2 - this.content.y);
         this.tabButtonBar.width = param1 - this.content.x;
         this.tabButtonBar.validateNow();
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this._tabCounters);
         this._tabCounters = null;
         this._utils = null;
         this._counterManager.disposeCountersForContainer(COUNTER_CONTAINER_ID);
         this._counterManager = null;
         this.content.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
         this.content.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onContentNeedUpdateHandler);
         this.content.dispose();
         this.content = null;
         this.tabButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabButtonBarIndexChangeHandler);
         this.tabButtonBar.dispose();
         this.tabButtonBar = null;
         this.title = null;
         this._hitArea = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.tabButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabButtonBarIndexChangeHandler);
         this.content.addEventListener(ViewStackEvent.NEED_UPDATE,this.onContentNeedUpdateHandler);
         this.content.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.title.text = STORAGE.STORAGE_SECTIONTITLE;
         this.title.mouseWheelEnabled = this.title.mouseEnabled = false;
         this.tabButtonBar.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function draw() : void
      {
         var _loc1_:ICategory = null;
         super.draw();
         if(this.content.currentView)
         {
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc1_ = ICategory(this.content.currentView);
               this.title.x = this.tabButtonBar.x = width - _loc1_.contentWidth >> 1;
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               UIComponentEx(this.content.currentView).invalidate(InvalidationType.LAYOUT);
            }
         }
         if(isInvalid(SIDE_BAR_COUNTER))
         {
            this.updateCounters();
         }
      }
      
      override protected function setTabsData(param1:DataProvider) : void
      {
         this.tabButtonBar.dataProvider = param1;
      }
      
      public function as_setTabCounter(param1:int, param2:int) : void
      {
         this._tabCounters[param1] = param2;
         invalidate(SIDE_BAR_COUNTER);
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function setActive(param1:Boolean) : void
      {
         setActiveStateS(param1);
      }
      
      public function setHitArea(param1:Sprite) : void
      {
         this._hitArea = param1;
         if(this.content.currentView)
         {
            ICategory(this.content.currentView).setHitArea(this._hitArea);
         }
      }
      
      public function update(param1:Object) : void
      {
      }
      
      private function updateCounters() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Button = null;
         var _loc3_:* = null;
         this.tabButtonBar.validateNow();
         for(_loc3_ in this._tabCounters)
         {
            _loc1_ = this._tabCounters[_loc3_];
            _loc2_ = this.tabButtonBar.getButtonAt(int(_loc3_));
            this._utils.asserter.assertNotNull(_loc2_,"tabButtonBar sectionIdx: " + _loc3_ + Errors.WASNT_FOUND);
            this._counterManager.removeCounter(_loc2_,COUNTER_CONTAINER_ID);
            if(_loc1_ > 0)
            {
               this._counterManager.setCounter(_loc2_,String(_loc1_),COUNTER_CONTAINER_ID,_counterProps);
            }
         }
      }
      
      public function get contentWidth() : int
      {
         return Boolean(this.content.currentView) ? int(ICategory(this.content.currentView).contentWidth) : int(0);
      }
      
      private function onContentViewChangedHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:UIComponentEx = param1.view as UIComponentEx;
         if(_loc2_)
         {
            _loc2_.invalidateLayout();
         }
      }
      
      private function onTabButtonBarIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:OrangeTabsMenuVO = OrangeTabsMenuVO(param1.data);
         onOpenTabS(_loc2_.id);
      }
      
      private function onContentNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         if(this._hitArea)
         {
            ICategory(param1.view).setHitArea(this._hitArea);
         }
         registerFlashComponentS(IDAAPIModule(param1.view),param1.viewId);
      }
   }
}
