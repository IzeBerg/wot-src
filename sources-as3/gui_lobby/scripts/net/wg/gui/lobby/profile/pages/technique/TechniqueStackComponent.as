package net.wg.gui.lobby.profile.pages.technique
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.components.ResizableViewStack;
   import net.wg.gui.lobby.profile.components.ResizableContent;
   import net.wg.gui.lobby.profile.pages.technique.data.RatingButtonVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   
   public class TechniqueStackComponent extends UIComponentEx
   {
      
      private static const PRESTIGE_SIZE:uint = 48;
      
      private static const PRESTIGE_X:uint = 26;
      
      private static const PRESTIGE_Y:int = 1;
      
      private static const PRESTIGE_EMBLEM_WIDGET_NAME:String = "prestigeEmblemWidget";
      
      private static const INVALIDATE_PRESTIGE_VISIBILITY:String = "invPrestigeVisibility";
      
      private static const INVALIDATE_BTN_COUNTERS:String = "invBtnCounters";
       
      
      public var vNameTF:TextField = null;
      
      public var viewRatingBtn:SoundButtonEx = null;
      
      public var typeIcon:UILoaderAlt = null;
      
      public var tabsBg:MovieClip = null;
      
      public var buttonBar:ButtonBarEx = null;
      
      public var viewStack:ResizableViewStack = null;
      
      private var _resizeTask:Function = null;
      
      private var _scheduler:IScheduler;
      
      private var _enableRating:Boolean = true;
      
      private var _visibleRating:Boolean = true;
      
      private var _isStatisticSection:Boolean = true;
      
      private var _prestigeWidgetInject:GFInjectComponent = null;
      
      private var _showPrestigeEmblem:Boolean = false;
      
      private var _isOtherPlayerMode:Boolean = false;
      
      private var _nameDefaultX:int;
      
      private var _typeDefaultX:int;
      
      private var _counterManager:ICounterManager;
      
      private var _countersToSet:Vector.<CountersVo> = null;
      
      private var _actualCounters:Vector.<SoundButtonEx>;
      
      public function TechniqueStackComponent()
      {
         this._scheduler = App.utils.scheduler;
         this._counterManager = App.utils.counterManager;
         this._actualCounters = new Vector.<SoundButtonEx>();
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._nameDefaultX = this.vNameTF.x;
         this._typeDefaultX = this.typeIcon.x;
         this.buttonBar.dataProvider = new DataProvider([{
            "label":PROFILE.SECTION_TECHNIQUE_TABBTN_STATISTIC,
            "linkage":Linkages.TECHNIQUE_STATISTIC_TAB,
            "tooltip":PROFILE.SECTION_TECHNIQUE_TABBTN_STATISTIC_TOOLTIP
         },{
            "label":PROFILE.SECTION_TECHNIQUE_TABBTN_ACHIEVEMENTS,
            "linkage":Linkages.TECHNIQUE_ACHIEVEMENT_TAB,
            "tooltip":PROFILE.SECTION_TECHNIQUE_TABBTN_AWARDS_TOOLTIP
         }]);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.viewStack.cache = true;
         this.buttonBar.selectedIndex = 0;
         this.buttonBar.validateNow();
         this.buttonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         this.viewRatingBtn.label = PROFILE.SECTION_HOF_VEHICLESRATINGSBTN;
         this.viewRatingBtn.mouseEnabledOnDisabled = true;
         this.viewRatingBtn.addEventListener(ButtonEvent.CLICK,this.onViewRatingBtnClickHandler);
         this.viewRatingBtn.addEventListener(MouseEvent.ROLL_OVER,this.onViewRatingBtnRollOverHandler);
         this.viewRatingBtn.addEventListener(MouseEvent.ROLL_OUT,this.onViewRatingBtnRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:TechniqueStatisticTab = null;
         var _loc2_:String = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:ICounterProps = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:CountersVo = null;
         var _loc8_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.viewRatingBtn.visible = this._visibleRating && this._isStatisticSection;
            if(this.viewRatingBtn.visible)
            {
               invalidate(INVALIDATE_BTN_COUNTERS);
            }
            else
            {
               this.removeCounters();
            }
            if(this._visibleRating)
            {
               this.viewRatingBtn.enabled = this._enableRating;
            }
         }
         if(isInvalid(INVALIDATE_PRESTIGE_VISIBILITY))
         {
            if(this._isOtherPlayerMode)
            {
               if(this._prestigeWidgetInject == null && this._showPrestigeEmblem)
               {
                  this.addPrestigeEmblem();
               }
               else if(this._prestigeWidgetInject && !this._showPrestigeEmblem)
               {
                  this.removePrestigeEmblem();
               }
            }
            else if(this.viewStack && this.viewStack.currentView != null && this._isStatisticSection)
            {
               _loc1_ = this.viewStack.currentView as TechniqueStatisticTab;
               if(_loc1_ && !_loc1_.isDisposed())
               {
                  _loc1_.updatePrestigeVisibility(this._showPrestigeEmblem);
               }
            }
         }
         if(this._countersToSet && isInvalid(INVALIDATE_BTN_COUNTERS))
         {
            _loc2_ = Values.EMPTY_STR;
            _loc3_ = null;
            _loc4_ = new CounterProps(CounterProps.DEFAULT_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y);
            this.removeCounters();
            _loc5_ = this._countersToSet.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = this._countersToSet[_loc6_];
               _loc2_ = _loc7_.componentId;
               _loc3_ = getChildByName(_loc2_);
               App.utils.asserter.assertNotNull(_loc3_,_loc2_ + " " + Errors.CANT_NULL);
               this._counterManager.setCounter(_loc3_,_loc7_.count,null,_loc4_);
               this._actualCounters.push(_loc3_);
               _loc6_++;
            }
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            _loc8_ = this._prestigeWidgetInject != null ? int(PRESTIGE_SIZE) : int(0);
            this.vNameTF.x = this._nameDefaultX + _loc8_;
            this.typeIcon.x = this._typeDefaultX + _loc8_;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._resizeTask != null)
         {
            this._scheduler.cancelTask(this._resizeTask);
            this._resizeTask = null;
         }
         this.buttonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         this.buttonBar.dispose();
         this.buttonBar = null;
         this.viewStack.dispose();
         this.viewStack = null;
         this.typeIcon.dispose();
         this.typeIcon = null;
         this.tabsBg = null;
         this.vNameTF = null;
         this._scheduler = null;
         this.viewRatingBtn.removeEventListener(ButtonEvent.CLICK,this.onViewRatingBtnClickHandler);
         this.viewRatingBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onViewRatingBtnRollOverHandler);
         this.viewRatingBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onViewRatingBtnRollOutHandler);
         this.viewRatingBtn.dispose();
         this.viewRatingBtn = null;
         if(this._countersToSet)
         {
            this._countersToSet.splice(0,this._countersToSet.length);
            this._countersToSet = null;
         }
         if(this._actualCounters)
         {
            while(this._actualCounters.length)
            {
               this._counterManager.removeCounter(this._actualCounters.pop());
            }
            this._actualCounters = null;
         }
         this._counterManager = null;
         super.onDispose();
      }
      
      public function enableAwardsButton(param1:Boolean) : void
      {
         if(!param1 && this.buttonBar.selectedIndex > 0)
         {
            this.buttonBar.selectedIndex = 0;
         }
         var _loc2_:Button = this.buttonBar.getButtonAt(1);
         if(_loc2_)
         {
            _loc2_.enabled = param1;
         }
      }
      
      public function setBtnCounters(param1:Vector.<CountersVo>) : void
      {
         this._countersToSet = param1;
         invalidate(INVALIDATE_BTN_COUNTERS);
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         this.tabsBg.scrollRect = new Rectangle(0,0,this.tabsBg.width,param2);
         this.viewStack.setAvailableSize(param1 - this.viewStack.x,param2 - this.viewStack.y);
      }
      
      public function updateLabel(param1:String, param2:String) : void
      {
         this.vNameTF.htmlText = param1;
         if(param2 == null)
         {
            this.typeIcon.unload();
         }
         else
         {
            this.typeIcon.source = param2;
         }
      }
      
      public function updatePrestigeVisibility(param1:Boolean, param2:Boolean) : void
      {
         if(this._showPrestigeEmblem == param1 && this._isOtherPlayerMode == param2)
         {
            return;
         }
         this._showPrestigeEmblem = param1;
         this._isOtherPlayerMode = param2;
         invalidate(INVALIDATE_PRESTIGE_VISIBILITY);
      }
      
      public function updateRatingButton(param1:RatingButtonVO) : void
      {
         this._enableRating = param1.enabled;
         this._visibleRating = param1.visible;
         invalidateData();
      }
      
      public function updateTankData(param1:Object) : void
      {
         this.viewStack.updateData(param1);
         if(this._resizeTask != null)
         {
            this._scheduler.cancelTask(this._resizeTask);
         }
         if(this.viewStack.currentView == null)
         {
            return;
         }
         this._resizeTask = ResizableContent(this.viewStack.currentView).applyResizing;
         this._scheduler.scheduleOnNextFrame(this._resizeTask);
      }
      
      private function addPrestigeEmblem() : void
      {
         if(!this._prestigeWidgetInject)
         {
            this._prestigeWidgetInject = new GFInjectComponent();
            this._prestigeWidgetInject.name = PRESTIGE_EMBLEM_WIDGET_NAME;
            this._prestigeWidgetInject.setManageSize(true);
            this._prestigeWidgetInject.width = PRESTIGE_SIZE;
            this._prestigeWidgetInject.height = PRESTIGE_SIZE;
            this._prestigeWidgetInject.x = PRESTIGE_X;
            this._prestigeWidgetInject.y = PRESTIGE_Y;
            addChild(this._prestigeWidgetInject);
            dispatchEvent(new ProfileTechniqueEvent(ProfileTechniqueEvent.PRESTIGE_WIDGET_ENABLED,true));
            invalidateLayout();
         }
      }
      
      private function removePrestigeEmblem() : void
      {
         if(this._prestigeWidgetInject)
         {
            removeChild(this._prestigeWidgetInject);
            this._prestigeWidgetInject = null;
            dispatchEvent(new ProfileTechniqueEvent(ProfileTechniqueEvent.PRESTIGE_WIDGET_DISABLED,true));
            invalidateLayout();
         }
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
      
      private function onViewRatingBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new ProfileTechniqueEvent(ProfileTechniqueEvent.VIEW_RATING_BTN_CLICK,true));
      }
      
      private function onTabIndexChangeHandler(param1:IndexEvent) : void
      {
         this._isStatisticSection = param1.index == 0;
         invalidateData();
         if(this._isStatisticSection)
         {
            invalidate(INVALIDATE_PRESTIGE_VISIBILITY);
         }
      }
      
      private function onViewRatingBtnRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._enableRating)
         {
            App.toolTipMgr.showComplex(PROFILE.SECTION_HOF_NOTAVAILABLE_TOOLTIP);
         }
      }
      
      private function onViewRatingBtnRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      public function get prestigeWidget() : GFInjectComponent
      {
         var _loc1_:TechniqueStatisticTab = null;
         if(this._isOtherPlayerMode)
         {
            return this._prestigeWidgetInject;
         }
         _loc1_ = this.viewStack.currentView as TechniqueStatisticTab;
         if(_loc1_)
         {
            return _loc1_.prestigeWidget;
         }
         return null;
      }
   }
}
