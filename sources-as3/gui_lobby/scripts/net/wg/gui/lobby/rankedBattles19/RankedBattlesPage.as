package net.wg.gui.lobby.rankedBattles19
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.text.TextFormatAlign;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.components.advanced.ViewStackExPadding;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.components.BrowserViewStackExPadding;
   import net.wg.gui.lobby.components.SideBar;
   import net.wg.gui.lobby.components.SideBarRenderer;
   import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeader;
   import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeaderHelper;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageVO;
   import net.wg.infrastructure.base.meta.IRankedBattlesPageMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesPageMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.utils.Padding;
   
   public class RankedBattlesPage extends RankedBattlesPageMeta implements IRankedBattlesPageMeta, IStageSizeDependComponent
   {
      
      private static const DELAY_FRAMES_FOR_BROWSER_SHOW:int = 3;
      
      private static const PROPERTY_ID:String = "id";
      
      private static const MENU_RENDERER_NORMAL_HEIGHT:int = 78;
      
      private static const MENU_RENDERER_SMALL_HEIGHT:int = 54;
      
      private static const MENU_EXTRA_HEIGHT:int = 22;
      
      private static const CONTENT_H_OFFSET_BIG:int = 50;
      
      private static const CONTENT_H_OFFSET_SMALL:int = 20;
      
      private static const CLOSE_BUTTON_OFFSET:int = 51;
      
      private static const MENU_RIGHT_PADDING:int = 50;
      
      private static const HEADER_BOTTOM_PADDING:int = 10;
      
      private static const NEW_COUNTER_CONTAINER_ID:String = "RankedBattlesPage";
      
      private static const COUNTERS_INVALID:String = "countersInvalid";
      
      private static const COUNTER_PROPS_BIG:CounterProps = new CounterProps(12,8,TextFormatAlign.RIGHT);
      
      private static const COUNTER_PROPS_SMALL:CounterProps = new CounterProps(20,4,TextFormatAlign.RIGHT);
       
      
      public var menu:SideBar = null;
      
      public var content:ViewStackExPadding = null;
      
      public var header:RankedBattlesPageHeader = null;
      
      private var _data:RankedBattlesPageVO = null;
      
      private var _counterManager:ICounterManager;
      
      private var _countersData:Vector.<CountersVo> = null;
      
      private var _counterProps:CounterProps = null;
      
      private var _itemRendererName:String = "";
      
      private var _itemRendererHeight:int = 78;
      
      private var _headerHelper:RankedBattlesPageHeaderHelper = null;
      
      private var _countFrames:int = 0;
      
      public function RankedBattlesPage()
      {
         this._counterManager = App.utils.counterManager;
         super();
         this._headerHelper = RankedBattlesPageHeaderHelper.getInstance();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
         this.updateContentSize();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.content.cache = true;
         this.content.targetGroup = this.menu.name;
         this.content.isApplyPadding = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         closeBtn.label = RANKED_BATTLES.RANKEDBATTLEPAGE_CLOSEBTN;
         closeBtn.validateNow();
         this.content.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
         this.header.addEventListener(Event.RESIZE,this.onHeaderResizeHandler);
         this.menu.addEventListener(Event.RESIZE,this.onMenuResizeHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function draw() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:CountersVo = null;
         super.draw();
         var _loc1_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc2_:Boolean = isInvalid(InvalidationType.SIZE);
         if(this._data)
         {
            if(_loc1_ || _loc2_)
            {
               this.menu.height = this._itemRendererHeight * this._data.menuDP.length + MENU_EXTRA_HEIGHT;
            }
            if(_loc1_)
            {
               this.menu.dataProvider = this._data.menuDP;
               this.menu.selectedIndex = this._data.selectedIndex;
               _loc2_ = true;
            }
            if(_loc2_)
            {
               this.menu.y = height - this.menu.height >> 1;
               closeBtn.x = _width - closeBtn.width - CLOSE_BUTTON_OFFSET;
            }
         }
         if(this._countersData && isInvalid(COUNTERS_INVALID))
         {
            this._counterManager.disposeCountersForContainer(NEW_COUNTER_CONTAINER_ID);
            for each(_loc4_ in this._countersData)
            {
               _loc3_ = this.getCounterTarget(_loc4_.componentId);
               if(_loc3_)
               {
                  this._counterManager.setCounter(_loc3_,_loc4_.count,NEW_COUNTER_CONTAINER_ID,this._counterProps);
               }
            }
         }
      }
      
      override protected function setData(param1:RankedBattlesPageVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function setHeaderData(param1:RankedBattlesPageHeaderVO) : void
      {
         this.header.setData(param1);
      }
      
      override protected function setCounters(param1:Vector.<CountersVo>) : void
      {
         this._countersData = param1;
         invalidate(COUNTERS_INVALID);
      }
      
      override protected function onDispose() : void
      {
         this._counterManager.disposeCountersForContainer(NEW_COUNTER_CONTAINER_ID);
         this._counterManager = null;
         this._countersData = null;
         this.menu.removeEventListener(Event.RESIZE,this.onMenuResizeHandler);
         this.menu.dispose();
         this.menu = null;
         var _loc1_:DisplayObject = this.content.cachedViews[RANKEDBATTLES_ALIASES.RANKED_BATTLES_SHOP_ALIAS];
         if(_loc1_)
         {
            _loc1_.removeEventListener(Event.COMPLETE,this.onShopBrowserCompleteHandler);
         }
         this.content.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
         this.content.dispose();
         this.content = null;
         this.header.removeEventListener(Event.RESIZE,this.onHeaderResizeHandler);
         this.header.dispose();
         this.header = null;
         this._counterProps = null;
         this._data = null;
         this._headerHelper = null;
         super.onDispose();
      }
      
      override protected function onEscapeKeyDown() : void
      {
         onCloseS();
      }
      
      override protected function onCloseBtn() : void
      {
         onCloseS();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:String = this._headerHelper.getSizeId(param1,param2);
         this.header.setSizeId(_loc3_);
         this.header.y = this._headerHelper.getYOffset(_loc3_);
         closeBtn.y = this.header.y + this._headerHelper.getCloseBtnYOffset(_loc3_);
         var _loc4_:String = Values.EMPTY_STR;
         if(param1 == StageSizeBoundaries.WIDTH_1024)
         {
            _loc4_ = Linkages.SIDE_BAR_SMALL_RENDERER;
            this._itemRendererHeight = MENU_RENDERER_SMALL_HEIGHT;
            this._counterProps = COUNTER_PROPS_SMALL;
            this.menu.x = CONTENT_H_OFFSET_SMALL;
         }
         else
         {
            _loc4_ = Linkages.SIDE_BAR_NORMAL_RENDERER;
            this._itemRendererHeight = MENU_RENDERER_NORMAL_HEIGHT;
            this._counterProps = COUNTER_PROPS_BIG;
            this.menu.x = CONTENT_H_OFFSET_BIG;
         }
         this.menu.itemRendererName = _loc4_;
         if(_loc4_ != this._itemRendererName)
         {
            this._itemRendererName = _loc4_;
            invalidate(COUNTERS_INVALID);
         }
      }
      
      private function getCounterTarget(param1:String) : DisplayObject
      {
         var _loc4_:Object = null;
         var _loc5_:SideBarRenderer = null;
         var _loc2_:IDataProvider = this.menu.dataProvider;
         var _loc3_:int = _loc2_.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = _loc2_.requestItemAt(_loc6_);
            if(_loc4_.hasOwnProperty(PROPERTY_ID) && _loc4_.id == param1)
            {
               _loc5_ = this.menu.getButtonAt(_loc6_) as SideBarRenderer;
               if(_loc5_)
               {
                  return _loc5_.counterTarget;
               }
            }
            _loc6_++;
         }
         return null;
      }
      
      private function updateContentSize() : void
      {
         var _loc1_:int = this.menu.x + this.menu.width + MENU_RIGHT_PADDING;
         var _loc2_:int = this.header.y + this.header.height + HEADER_BOTTOM_PADDING;
         this.content.setSize(_width,_height);
         this.content.setSizePadding(new Padding(_loc2_,0,0,_loc1_));
         this.header.x = width - this.header.width >> 1;
      }
      
      private function checkBrowserShow() : void
      {
         if(this._countFrames > 0)
         {
            --this._countFrames;
            App.utils.scheduler.scheduleOnNextFrame(this.checkBrowserShow);
         }
         else
         {
            BrowserViewStackExPadding(this.content.currentView).isDisableShowBrowser = false;
         }
      }
      
      override protected function get autoShowViewProperty() : int
      {
         return SHOW_VIEW_PROP_AFTER_BG_READY;
      }
      
      private function onHeaderResizeHandler(param1:Event) : void
      {
         this.updateContentSize();
      }
      
      private function onMenuResizeHandler(param1:Event) : void
      {
         this.updateContentSize();
         invalidate(COUNTERS_INVALID);
      }
      
      private function onContentViewChangedHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:BrowserViewStackExPadding = null;
         if(!isFlashComponentRegisteredS(param1.viewId))
         {
            registerFlashComponentS(IDAAPIModule(param1.view),param1.viewId);
         }
         if(param1.viewId == RANKEDBATTLES_ALIASES.RANKED_BATTLES_SHOP_ALIAS)
         {
            _loc2_ = BrowserViewStackExPadding(this.content.currentView);
            _loc2_.waiting.backgroundVisibility = false;
            _loc2_.addEventListener(Event.COMPLETE,this.onShopBrowserCompleteHandler);
            _loc2_.isDisableShowBrowser = true;
         }
         setBackground(this.menu.selectedItem.background);
         onPageChangedS(param1.viewId);
      }
      
      private function onShopBrowserCompleteHandler(param1:Event) : void
      {
         var _loc2_:BrowserViewStackExPadding = BrowserViewStackExPadding(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.onShopBrowserCompleteHandler);
         App.utils.scheduler.scheduleOnNextFrame(this.checkBrowserShow);
         this._countFrames = DELAY_FRAMES_FOR_BROWSER_SHOW;
      }
   }
}
