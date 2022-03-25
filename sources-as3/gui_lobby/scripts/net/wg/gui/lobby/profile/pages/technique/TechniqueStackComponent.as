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
         var _loc1_:String = null;
         var _loc2_:DisplayObject = null;
         var _loc3_:ICounterProps = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:CountersVo = null;
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
         if(this._countersToSet && isInvalid(INVALIDATE_BTN_COUNTERS))
         {
            _loc1_ = Values.EMPTY_STR;
            _loc2_ = null;
            _loc3_ = new CounterProps(CounterProps.DEFAULT_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y);
            this.removeCounters();
            _loc4_ = this._countersToSet.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = this._countersToSet[_loc5_];
               _loc1_ = _loc6_.componentId;
               _loc2_ = getChildByName(_loc1_);
               App.utils.asserter.assertNotNull(_loc2_,_loc1_ + " " + Errors.CANT_NULL);
               this._counterManager.setCounter(_loc2_,_loc6_.count,null,_loc3_);
               this._actualCounters.push(_loc2_);
               _loc5_++;
            }
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
   }
}
