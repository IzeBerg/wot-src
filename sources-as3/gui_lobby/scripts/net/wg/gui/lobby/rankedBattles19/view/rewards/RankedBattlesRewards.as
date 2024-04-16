package net.wg.gui.lobby.rankedBattles19.view.rewards
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.ViewStackExPadding;
   import net.wg.gui.components.controls.tabs.OrangeTabButton;
   import net.wg.gui.components.controls.tabs.OrangeTabMenu;
   import net.wg.gui.components.controls.tabs.OrangeTabsMenuVO;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.infrastructure.base.meta.IRankedBattlesRewardsMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesRewardsMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.utils.Padding;
   
   public class RankedBattlesRewards extends RankedBattlesRewardsMeta implements IRankedBattlesRewardsMeta, IStageSizeDependComponent
   {
      
      private static const CONTENT_TOP_SHIFT:int = 91;
      
      private static const CONTENT_TOP_SHIFT_SMALL:int = 71;
      
      private static const INV_TABS_SIZE:String = "invalidateTabsSize";
      
      private static const HEADER_TABS_OFFSET:int = 20;
      
      private static const VERTICAL_SIZE_ID_HIGH:String = "verticalSizeIdHigh";
      
      private static const VERTICAL_SIZE_ID_SMALL:String = "verticalSizeIdSmall";
      
      private static const NEW_COUNTER_CONTAINER_ID:String = "RankedBattlesRewards";
      
      private static const COUNTERS_INVALID:String = "countersInvalid";
      
      private static const COUNTER_PROPS:CounterProps = new CounterProps(10,-2,TextFormatAlign.RIGHT);
       
      
      public var tabButtonBar:OrangeTabMenu = null;
      
      public var content:ViewStackExPadding = null;
      
      private var _tabsDataProvider:DataProvider = null;
      
      private var _verticalSizeID:String = "";
      
      private var _countersData:Vector.<CountersVo> = null;
      
      private var _counterManager:ICounterManager;
      
      public function RankedBattlesRewards()
      {
         this._counterManager = App.utils.counterManager;
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.content.cache = true;
         this.content.targetGroup = this.tabButtonBar.name;
         this.content.isApplyPadding = false;
         this.content.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tabButtonBar.autoSize = TextFieldAutoSize.LEFT;
         this.tabButtonBar.addEventListener(Event.COMPLETE,this.onTabButtonBarCompleteHandler);
         this.tabButtonBar.tabsSoundType = SoundTypes.RANKED_BATTLES_REWARDS_TAB;
      }
      
      override protected function draw() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:DisplayObject = null;
         var _loc7_:CountersVo = null;
         super.draw();
         var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
         var _loc2_:Boolean = isInvalid(INV_VIEW_PADDING);
         if(this._tabsDataProvider)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.tabButtonBar.dataProvider = this._tabsDataProvider;
               invalidate(INV_TABS_SIZE);
            }
            _loc3_ = isInvalid(INV_TABS_SIZE) || _loc1_;
            if(_loc3_)
            {
               this.tabButtonBar.width = _width;
               this.tabButtonBar.validateNow();
               this.tabButtonBar.x = _width - this.tabButtonBar.getWidth() >> 1;
            }
            if(_loc2_ || _loc3_)
            {
               _loc4_ = Values.ZERO;
               _loc5_ = CONTENT_TOP_SHIFT_SMALL;
               if(this._verticalSizeID == VERTICAL_SIZE_ID_HIGH)
               {
                  _loc4_ = HEADER_TABS_OFFSET;
                  _loc5_ = CONTENT_TOP_SHIFT;
               }
               this.tabButtonBar.y = viewPadding.top + _loc4_;
               this.content.x = viewPadding.left;
               this.content.y = this.tabButtonBar.y + _loc5_;
               this.content.setSizePadding(new Padding(this.content.y,0,0,this.content.x));
               this.content.setSize(_width - this.content.x,_height - this.content.y);
            }
            if(this._countersData && isInvalid(COUNTERS_INVALID))
            {
               this._counterManager.disposeCountersForContainer(NEW_COUNTER_CONTAINER_ID);
               for each(_loc7_ in this._countersData)
               {
                  _loc6_ = this.getCounterTarget(_loc7_.componentId);
                  if(_loc6_)
                  {
                     this._counterManager.setCounter(_loc6_,_loc7_.count,NEW_COUNTER_CONTAINER_ID,COUNTER_PROPS);
                  }
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.content.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
         this.tabButtonBar.removeEventListener(Event.COMPLETE,this.onTabButtonBarCompleteHandler);
         this.tabButtonBar.dispose();
         this.tabButtonBar = null;
         this.content.dispose();
         this.content = null;
         this._tabsDataProvider = null;
         this._counterManager.disposeCountersForContainer(NEW_COUNTER_CONTAINER_ID);
         this._counterManager = null;
         this._countersData = null;
         super.onDispose();
      }
      
      override protected function setTabsData(param1:DataProvider) : void
      {
         this._tabsDataProvider = param1;
         this.tabButtonBar.visible = this._tabsDataProvider.length > 1;
         invalidateData();
      }
      
      override protected function setCounters(param1:Vector.<CountersVo>) : void
      {
         this._countersData = param1;
         invalidate(COUNTERS_INVALID);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:String = param2 >= StageSizeBoundaries.HEIGHT_900 ? VERTICAL_SIZE_ID_HIGH : VERTICAL_SIZE_ID_SMALL;
         if(this._verticalSizeID != _loc3_)
         {
            this._verticalSizeID = _loc3_;
            invalidateSize();
         }
      }
      
      private function getCounterTarget(param1:String) : DisplayObject
      {
         var _loc2_:IDataProvider = null;
         var _loc3_:OrangeTabsMenuVO = null;
         var _loc4_:OrangeTabButton = null;
         _loc2_ = this.tabButtonBar.dataProvider;
         var _loc5_:int = _loc2_.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = OrangeTabsMenuVO(_loc2_.requestItemAt(_loc6_));
            if(_loc3_.id == param1)
            {
               _loc4_ = OrangeTabButton(this.tabButtonBar.getButtonAt(_loc6_));
               return _loc4_.background;
            }
            _loc6_++;
         }
         return null;
      }
      
      private function onTabButtonBarCompleteHandler(param1:Event) : void
      {
         invalidate(INV_TABS_SIZE);
      }
      
      private function onContentViewChangedHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:String = param1.viewId;
         if(!isFlashComponentRegisteredS(_loc2_))
         {
            registerFlashComponentS(IDAAPIModule(param1.view),_loc2_);
         }
         dispatchEvent(new Event(Event.CHANGE));
         onTabChangedS(_loc2_);
      }
   }
}
