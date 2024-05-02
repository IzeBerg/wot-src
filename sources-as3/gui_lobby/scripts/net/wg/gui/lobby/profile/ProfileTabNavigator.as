package net.wg.gui.lobby.profile
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.Aliases;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.components.ResizableViewStack;
   import net.wg.gui.lobby.profile.pages.ProfileSection;
   import net.wg.infrastructure.base.meta.IProfileTabNavigatorMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileTabNavigatorMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ProfileTabNavigator extends ProfileTabNavigatorMeta implements IProfileTabNavigatorMeta
   {
      
      private static const COUNTER_OFFSET_X:int = -15;
      
      private static const MENU_OFFSET_X:int = 40;
      
      private static const MENU_OFFSET_SMALL_X:int = 17;
      
      private static const MENU_OFFSET_Y:int = 60;
      
      private static const MENU_OFFSET_SMALL_Y:int = 60;
      
      private static const OFFSET_INVALID:String = "layoutInv";
      
      private static const MENU_POSITION_INVALID:String = "menyPositionInvalid";
      
      private static const INIT_DATA_INV:String = "initDataInv";
      
      private static const INVALIDATE_TAB_COUNTERS:String = "invTabCounters";
       
      
      public var menu:ButtonBarEx = null;
      
      public var viewStack:ResizableViewStack = null;
      
      private var _data:ProfileMenuInfoVO = null;
      
      private var _sectionsDataUtil:LinkageUtils;
      
      private var _centerOffset:int = 0;
      
      private var _countersToSet:Vector.<CountersVo> = null;
      
      private var _actualCounters:Vector.<DisplayObject>;
      
      private var _counterManager:ICounterManager;
      
      private var _isButtonBarReady:Boolean = false;
      
      private var _isWindowed:Boolean = false;
      
      public function ProfileTabNavigator()
      {
         this._sectionsDataUtil = new LinkageUtils();
         this._actualCounters = new Vector.<DisplayObject>();
         this._counterManager = App.utils.counterManager;
         super();
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_TOTAL_PAGE,Linkages.PROFILE_TOTAL_PAGE);
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_SUMMARY_PAGE,Linkages.PROFILE_SUMMARY_PAGE);
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_SECTION,Linkages.PROFILE_TEST);
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_SUMMARY_WINDOW,Linkages.PROFILE_SUMMARY_WINDOW);
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_AWARDS,Linkages.PROFILE_AWARDS);
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_STATISTICS,Linkages.PROFILE_STATISTICS);
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_WINDOW,Linkages.PROFILE_TECHNIQUE_WINDOW);
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_PAGE,Linkages.PROFILE_TECHNIQUE_PAGE);
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_FORMATIONS_PAGE,Linkages.PROFILE_FORMATIONS);
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_HOF,Linkages.PROFILE_HOF);
         this._sectionsDataUtil.addEntity(Aliases.PROFILE_COLLECTIONS_PAGE,Linkages.PROFILE_COLLECTIONS_PAGE);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.viewStack.cache = true;
         this.menu.enableOversize = true;
         this.menu.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabBarIndexChanged,false,0,true);
         this.menu.addEventListener(Event.COMPLETE,this.onButtonBarCompleteHandler);
         this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onSectionViewShowed,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Array = null;
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:DisplayObject = null;
         var _loc12_:ICounterProps = null;
         var _loc13_:int = 0;
         super.draw();
         if(isInvalid(INIT_DATA_INV) && this._data)
         {
            _loc1_ = this._data.sectionsData;
            _loc2_ = _loc1_.length;
            _loc3_ = [];
            _loc5_ = 0;
            _loc6_ = this._data.selectedAlias;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc4_ = _loc1_[_loc7_];
               _loc8_ = _loc4_.alias;
               _loc3_.push(new SectionInfo(_loc8_,this._sectionsDataUtil.getLinkageByAlias(_loc8_),_loc4_.label,_loc4_.tooltip,_loc4_.enabled,_loc4_.id));
               if(_loc6_ == _loc8_)
               {
                  _loc5_ = _loc7_;
               }
               _loc7_++;
            }
            if(this.menu.dataProvider != null)
            {
               this.menu.dataProvider.cleanUp();
            }
            this.menu.dataProvider = new DataProvider(_loc3_);
            if(_loc3_.length > 0)
            {
               this.menu.selectedIndex = _loc5_;
            }
            this.menu.validateNow();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            invalidate(OFFSET_INVALID);
            invalidate(MENU_POSITION_INVALID);
         }
         if(isInvalid(MENU_POSITION_INVALID))
         {
            this.updateMenu();
         }
         if(isInvalid(OFFSET_INVALID))
         {
            this.viewStack.centerOffset = this._centerOffset;
         }
         if(this._isButtonBarReady && isInvalid(INVALIDATE_TAB_COUNTERS))
         {
            _loc9_ = 0;
            _loc10_ = Values.EMPTY_STR;
            _loc11_ = null;
            this.removeCounters();
            _loc12_ = new CounterProps(COUNTER_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y);
            if(this._countersToSet)
            {
               _loc9_ = this._countersToSet.length;
               _loc13_ = 0;
               while(_loc13_ < _loc9_)
               {
                  _loc10_ = this._countersToSet[_loc13_].componentId;
                  _loc11_ = this.getTabRenderer(_loc10_);
                  App.utils.asserter.assertNotNull(_loc11_,_loc10_ + " " + Errors.CANT_NULL);
                  this._counterManager.setCounter(_loc11_,this._countersToSet[_loc13_].count,null,_loc12_);
                  this._actualCounters.push(_loc11_);
                  _loc13_++;
               }
            }
         }
      }
      
      private function updateMenu() : void
      {
         if(this._isWindowed)
         {
            return;
         }
         var _loc1_:Boolean = width <= StageSizeBoundaries.WIDTH_1366;
         var _loc2_:int = !!_loc1_ ? int(MENU_OFFSET_SMALL_X) : int(MENU_OFFSET_X);
         var _loc3_:int = !!_loc1_ ? int(MENU_OFFSET_SMALL_Y) : int(MENU_OFFSET_Y);
         this.removeCounters();
         this.menu.itemRendererName = !!_loc1_ ? Linkages.SIDE_BAR_SMALL_RENDERER : Linkages.SIDE_BAR_NORMAL_RENDERER;
         this.menu.validateNow();
         this.menu.x = _loc2_;
         this.menu.y = (height - this.menu.actualHeight >> 1) + _loc3_;
         invalidate(INVALIDATE_TAB_COUNTERS);
      }
      
      override protected function onDispose() : void
      {
         this._sectionsDataUtil.dispose();
         this._sectionsDataUtil = null;
         this.menu.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabBarIndexChanged,false);
         this.menu.removeEventListener(Event.COMPLETE,this.onButtonBarCompleteHandler);
         this.menu.dispose();
         this.menu = null;
         this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onSectionViewShowed,false);
         this.viewStack.dispose();
         this.viewStack = null;
         this._data = null;
         if(this._countersToSet)
         {
            this._countersToSet.splice(0,this._countersToSet.length);
            this._countersToSet = null;
         }
         this.removeCounters();
         this._actualCounters = null;
         this._counterManager = null;
         super.onDispose();
      }
      
      override protected function setInitData(param1:ProfileMenuInfoVO) : void
      {
         this._data = param1;
         invalidate(INIT_DATA_INV);
      }
      
      override protected function setBtnTabCounters(param1:Vector.<CountersVo>) : void
      {
         this._countersToSet = param1;
         invalidate(INVALIDATE_TAB_COUNTERS);
      }
      
      public function setAvailableSize(param1:Number, param2:Number) : void
      {
         this.viewStack.setAvailableSize(param1,param2 - this.viewStack.y);
         setSize(param1,param2);
      }
      
      private function getTabRenderer(param1:String) : DisplayObject
      {
         var _loc2_:IDataProvider = this.menu.dataProvider;
         var _loc3_:SectionInfo = null;
         var _loc4_:int = _loc2_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = SectionInfo(_loc2_.requestItemAt(_loc5_));
            if(_loc3_.alias == param1)
            {
               return this.menu.getButtonAt(_loc5_) as DisplayObject;
            }
            _loc5_++;
         }
         return null;
      }
      
      private function removeCounters() : void
      {
         if(this._actualCounters)
         {
            while(this._actualCounters.length)
            {
               this._counterManager.removeCounter(this._actualCounters.pop());
            }
         }
      }
      
      public function set centerOffset(param1:int) : void
      {
         this._centerOffset = param1;
         invalidate(OFFSET_INVALID);
      }
      
      private function onSectionViewShowed(param1:ViewStackEvent) : void
      {
         var _loc2_:String = this._sectionsDataUtil.getAliasByLinkage(param1.viewId);
         if(!isFlashComponentRegisteredS(_loc2_))
         {
            registerFlashComponentS(IDAAPIModule(param1.view),_loc2_);
         }
      }
      
      private function onTabBarIndexChanged(param1:IndexEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:IViewStackContent = null;
         if(param1.index != -1)
         {
            _loc2_ = SectionInfo(param1.data).alias;
            _loc3_ = this._sectionsDataUtil.getLinkageByAlias(_loc2_);
            _loc4_ = this.viewStack.show(_loc3_,_loc3_);
            if(_loc4_ is ProfileSection)
            {
               (_loc4_ as ProfileSection).isWindowed = this._isWindowed;
            }
            onTabChangeS(_loc2_);
            invalidate(INVALIDATE_TAB_COUNTERS);
         }
      }
      
      private function onButtonBarCompleteHandler(param1:Event) : void
      {
         if(!this._isButtonBarReady)
         {
            this._isButtonBarReady = true;
            invalidate(INVALIDATE_TAB_COUNTERS);
         }
      }
      
      public function set isWindowed(param1:Boolean) : void
      {
         this._isWindowed = param1;
      }
   }
}
