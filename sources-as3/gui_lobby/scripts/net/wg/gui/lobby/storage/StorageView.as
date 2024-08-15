package net.wg.gui.lobby.storage
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.ViewStackEx;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.components.SideBar;
   import net.wg.gui.lobby.storage.categories.ICategory;
   import net.wg.gui.lobby.storage.categories.NoItemsView;
   import net.wg.gui.lobby.storage.categories.cards.configs.CardConfigs;
   import net.wg.gui.lobby.storage.data.StorageVO;
   import net.wg.infrastructure.base.meta.IStorageViewMeta;
   import net.wg.infrastructure.base.meta.impl.StorageViewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.IUtils;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   
   public class StorageView extends StorageViewMeta implements IStorageViewMeta, IStageSizeDependComponent
   {
      
      public static var COUNTER_CONTAINER_ID:String = "StorageViewCountersContainer";
      
      private static const HIT_AREA_NAME:String = "hitArea";
      
      private static const MENU_SIZE_FLAG:String = "menuSizeFlag";
      
      private static const SIDE_BAR_COUNTER:String = "sideBarCounter";
      
      private static const SMALL_CONTENT_V_OFFSET:int = 66;
      
      private static const NORMAL_CONTENT_V_OFFSET:int = 88;
      
      public static const COUNTER_SMALL_OFFSET_X:int = -9;
      
      public static const COUNTER_SMALL_OFFSET_Y:int = 12;
      
      public static const COUNTER_NORMAL_OFFSET_X:int = -12;
      
      public static const COUNTER_NORMAL_OFFSET_Y:int = 14;
      
      private static const WARNING_SIDEBAR_INDEX_NOT_FOUND:String = "SideBar sectionIdx: ";
       
      
      public var menu:SideBar;
      
      public var content:ViewStackEx;
      
      public var noItemsView:NoItemsView;
      
      private var _hitArea:Sprite;
      
      private var _utils:IUtils = null;
      
      private var _counterManager:ICounterManager = null;
      
      private var _sidebarCounter:Object;
      
      private var _sideBarCounterProps:ICounterProps;
      
      public function StorageView()
      {
         this._sidebarCounter = {};
         super();
         this._utils = App.utils;
         this._counterManager = this._utils.counterManager;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
         this.menu.height = height;
         this.content.setSize(width - this.content.x,height - this.content.y);
         var _loc3_:Graphics = this._hitArea.graphics;
         _loc3_.clear();
         _loc3_.beginFill(16711680,0);
         _loc3_.drawRect(0,0,param1,param2);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._hitArea = new Sprite();
         this._hitArea.name = HIT_AREA_NAME;
         addChildAt(this._hitArea,0);
         this.content.addEventListener(ViewStackEvent.NEED_UPDATE,this.onContentNeedUpdateHandler);
         this.content.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
         this.menu.addEventListener(Event.RESIZE,this.onMenuResizeHandler);
         this.noItemsView.setTexts(STORAGE.NOTAVAILABLE_TITLE,STORAGE.NOTAVAILABLE_NAVIGATIONBUTTON);
         this.noItemsView.addEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
         this.noItemsView.addEventListener(Event.RESIZE,this.onNoItemsViewResizeEventHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         this.menu.removeEventListener(Event.RESIZE,this.onMenuResizeHandler);
         this.menu.dispose();
         this.menu = null;
         this.content.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onContentNeedUpdateHandler);
         this.content.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
         this.content.dispose();
         this.content = null;
         this.noItemsView.removeEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
         this.noItemsView.removeEventListener(Event.RESIZE,this.onNoItemsViewResizeEventHandler);
         this.noItemsView.dispose();
         this.noItemsView = null;
         App.utils.data.cleanupDynamicObject(this._sidebarCounter);
         this._sidebarCounter = null;
         this._sideBarCounterProps = null;
         this._counterManager.disposeCountersForContainer(COUNTER_CONTAINER_ID);
         this._counterManager = null;
         this._hitArea = null;
         this._utils = null;
         CardConfigs.getInstance().dispose();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ICategory = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.noItemsView.width = width;
            this.noItemsView.validateNow();
            this.noItemsView.y = height - this.noItemsView.actualHeight >> 1;
            this.noItemsView.updateVisibility();
            invalidate(MENU_SIZE_FLAG);
         }
         if(isInvalid(SIDE_BAR_COUNTER))
         {
            this.menu.validateNow();
            this.updateCounters();
         }
         if(this.content.currentView && isInvalid(MENU_SIZE_FLAG))
         {
            _loc1_ = ICategory(this.content.currentView);
            this.menu.x = (this.content.x + width - _loc1_.contentWidth >> 1) - this.menu.width >> 1;
         }
      }
      
      override protected function setData(param1:StorageVO) : void
      {
         if(param1.showDummyScreen)
         {
            this.noItemsView.visible = true;
            this.menu.visible = false;
            this.content.visible = false;
         }
         else
         {
            this.updateCounters(true);
            this.noItemsView.visible = false;
            this.content.visible = true;
            this.menu.visible = true;
            this.menu.dataProvider = param1.sections;
            invalidate(SIDE_BAR_COUNTER);
         }
         setBackground(param1.bgSource);
         this.updateStage(width,height);
      }
      
      override protected function onEscapeKeyDown() : void
      {
         super.onEscapeKeyDown();
         onCloseS();
      }
      
      override protected function onCloseBtn() : void
      {
         super.onCloseBtn();
         onCloseS();
      }
      
      public function as_selectSection(param1:int) : void
      {
         this.menu.selectedIndex = param1;
      }
      
      public function as_setButtonCounter(param1:int, param2:int) : void
      {
         this._sidebarCounter[param1] = param2;
         invalidate(SIDE_BAR_COUNTER);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this.updateCounters(true);
         if(param1 == StageSizeBoundaries.WIDTH_1024)
         {
            this.menu.y = this.content.y = SMALL_CONTENT_V_OFFSET;
            this.menu.itemRendererName = Linkages.SIDE_BAR_SMALL_RENDERER;
            this._sideBarCounterProps = new CounterProps(COUNTER_SMALL_OFFSET_X,COUNTER_SMALL_OFFSET_Y);
         }
         else
         {
            this.menu.y = this.content.y = NORMAL_CONTENT_V_OFFSET;
            this.menu.itemRendererName = Linkages.SIDE_BAR_NORMAL_RENDERER;
            this._sideBarCounterProps = new CounterProps(COUNTER_NORMAL_OFFSET_X,COUNTER_NORMAL_OFFSET_Y);
         }
         invalidate(SIDE_BAR_COUNTER);
      }
      
      private function updateCounters(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Button = null;
         var _loc4_:* = null;
         for(_loc4_ in this._sidebarCounter)
         {
            _loc2_ = this._sidebarCounter[_loc4_];
            _loc3_ = this.menu.getButtonAt(int(_loc4_));
            if(_loc3_)
            {
               this._counterManager.removeCounter(_loc3_,COUNTER_CONTAINER_ID);
               if(!param1 && _loc2_ > 0)
               {
                  this._counterManager.setCounter(_loc3_,String(_loc2_),COUNTER_CONTAINER_ID,this._sideBarCounterProps);
               }
            }
            else
            {
               DebugUtils.LOG_WARNING(WARNING_SIDEBAR_INDEX_NOT_FOUND + _loc4_ + Errors.WASNT_FOUND);
            }
         }
      }
      
      private function onContentViewChangedHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:IUIComponentEx = param1.view as IUIComponentEx;
         if(_loc2_)
         {
            _loc2_.invalidate(InvalidationType.LAYOUT);
         }
      }
      
      private function onNoItemsViewResizeEventHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onContentNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:ICategory = ICategory(param1.view);
         _loc2_.setHitArea(this._hitArea);
         registerFlashComponentS(IDAAPIModule(_loc2_),param1.viewId);
      }
      
      private function onMenuResizeHandler(param1:Event) : void
      {
         invalidate(MENU_SIZE_FLAG);
      }
      
      private function onNoItemViewCloseHandler(param1:Event) : void
      {
         navigateToHangarS();
      }
   }
}
