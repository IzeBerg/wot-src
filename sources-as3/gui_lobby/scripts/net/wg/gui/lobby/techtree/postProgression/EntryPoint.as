package net.wg.gui.lobby.techtree.postProgression
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.POSTPROGRESSION_CONSTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.common.counters.Counter;
   import net.wg.gui.lobby.components.vehPostProgression.EntryPointButton;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.data.vo.ResearchPostProgressionDataVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IScheduler;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.MouseEventEx;
   
   public class EntryPoint extends UIComponentEx implements IStageSizeDependComponent
   {
      
      private static const FADE_DURATION:int = 200;
      
      private static const CONTENT_HEIGHT_BIG:int = 44;
      
      private static const CONTENT_HEIGHT_SMALL:int = 36;
      
      private static const LABEL_OFFSET_Y_BIG:int = 6;
      
      private static const LABEL_OFFSET_Y_SMALL:int = 3;
      
      private static const OFFSET_Y_BIG:int = 25;
      
      private static const OFFSET_Y_SMALL:int = -8;
      
      private static const CORNER_SIZE:int = 5;
      
      private static const LINE_COLOR:uint = 16777215;
      
      private static const BORDER_ALPHA:Number = 0.2;
      
      private static const CORNER_ALHPA:Number = 0.5;
      
      private static const LINE_GAP:int = 8;
      
      private static const MARGIN:int = 50;
      
      private static const MAX_Y:int = 220;
      
      private static const TOOLTIP_CUSTOM_DELAY:int = 1600;
      
      private static const LABEL_MIN_WIDTH:int = 400;
      
      private static const LABEL_MAX_WIDTH:int = 800;
      
      private static const OFFSET_TO_FIX_LINES_BLUR:Number = 0.25;
      
      private static const COUNTER_OFFSET_Y_BIG:int = 8;
      
      private static const COUNTER_OFFSET_Y_SMALL:int = 16;
      
      private static const UNLOCK_STATE:String = "unlock";
      
      private static const ENTRY_POINT_PARENT_SCREEN:String = "research_page";
      
      private static const POST_PROGRESSION_ENTRY:String = "postProgressionEntry";
       
      
      public var content:EntryPointButton = null;
      
      public var label:TextField = null;
      
      private var _tooltipsContainer:DisplayObjectContainer;
      
      private var _data:ResearchPostProgressionDataVO = null;
      
      private var _isHoverState:Boolean = false;
      
      private var _fadeTween:Tween = null;
      
      private var _labelCont:Sprite;
      
      private var _lines:Sprite;
      
      private var _hitMc:Sprite;
      
      private var _isSmall:Boolean = false;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _scheduler:IScheduler;
      
      private var _counterManager:ICounterManager;
      
      private var _soundMgr:ISoundManager;
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      public function EntryPoint()
      {
         this._labelCont = new Sprite();
         this._lines = new Sprite();
         this._hitMc = new Sprite();
         this._tooltipMgr = App.toolTipMgr;
         this._scheduler = App.utils.scheduler;
         this._counterManager = App.utils.counterManager;
         this._soundMgr = App.soundMgr;
         super();
         name = POST_PROGRESSION_ENTRY;
         this._tooltipsContainer = this._tooltipMgr.getContainer();
         hitArea = this._hitMc;
         this.label.wordWrap = true;
         this.label.multiline = true;
         this.label.filters = [new DropShadowFilter(0,0,16711680,1,16,16,2,2)];
         this._labelCont.mouseChildren = this._labelCont.mouseEnabled = false;
         this._labelCont.addChild(this.label);
         this._labelCont.alpha = 0;
         this._lines.x = OFFSET_TO_FIX_LINES_BLUR;
         this._lines.y = OFFSET_TO_FIX_LINES_BLUR;
         addChildAt(this._lines,0);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.content.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseEventRollOverHandler);
         this.content.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseEventRollOutHandler);
         this.content.removeEventListener(ButtonEvent.CLICK,this.onButtonEventClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         graphics.clear();
         removeChild(this._hitMc);
         this._hitMc.graphics.clear();
         this._hitMc = null;
         hitArea = null;
         this.content.dispose();
         this.content = null;
         this._labelCont.removeChild(this.label);
         this._tooltipsContainer.removeChild(this._labelCont);
         this._labelCont = null;
         this._tooltipsContainer = null;
         this._counterManager.removeCounter(this.content);
         this._counterManager = null;
         this.label = null;
         this._data = null;
         this._tooltipMgr = null;
         this._soundMgr = null;
         this._scheduler.cancelTask(this.showTooltip);
         this._scheduler = null;
         this._lines = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         buttonMode = true;
         mouseEnabled = false;
         addChild(this._hitMc);
         this._tooltipsContainer.addChild(this._labelCont);
         this.content.addEventListener(MouseEvent.ROLL_OVER,this.onMouseEventRollOverHandler);
         this.content.addEventListener(MouseEvent.ROLL_OUT,this.onMouseEventRollOutHandler);
         this.content.addEventListener(ButtonEvent.CLICK,this.onButtonEventClickHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Point = null;
         var _loc2_:int = 0;
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.LAYOUT))
            {
               x = this._x;
               y = this._y + (!!this._isSmall ? OFFSET_Y_SMALL : OFFSET_Y_BIG);
               _loc1_ = parent.localToGlobal(new Point(x,y));
               this._labelCont.x = _loc1_.x / App.appScale >> 0;
               this._labelCont.y = _loc1_.y / App.appScale >> 0;
            }
            if(isInvalid(InvalidationType.DATA))
            {
               this.label.text = this._data.label;
               App.utils.commons.updateTextFieldSize(this.label);
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.content.height = !!this._isSmall ? Number(CONTENT_HEIGHT_SMALL) : Number(CONTENT_HEIGHT_BIG);
               this.content.validateNow();
               this.showCounter(this._data.showCounter);
               _width = Math.max(_width,this.content.width + MARGIN) | 0;
               hitArea.x = this.content.x = _width - this.content.width >> 1;
               this.label.width = !!this._isSmall ? Number(LABEL_MAX_WIDTH) : Number(LABEL_MIN_WIDTH);
               App.utils.commons.updateTextFieldSize(this.label);
               this.label.x = _width - this.label.width >> 1;
               _loc2_ = this._isSmall && y > MAX_Y ? int(LABEL_OFFSET_Y_SMALL) : int(LABEL_OFFSET_Y_BIG);
               this.label.y = this.content.y + this.content.height + _loc2_ | 0;
               this.drawEarLines();
            }
            if(isInvalid(InvalidationType.STATE))
            {
               this.clearTween();
               this._fadeTween = new Tween(FADE_DURATION,this._labelCont,{"alpha":(!!this._isHoverState ? 1 : 0)});
            }
         }
      }
      
      public function setData(param1:ResearchPostProgressionDataVO) : void
      {
         if(this._data != param1)
         {
            this._data = param1;
            this.content.state = param1.state;
            invalidateData();
         }
      }
      
      public function setPosition(param1:int, param2:int) : void
      {
         this._x = param1;
         this._y = param2;
         invalidateLayout();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = param2 < StageSizeBoundaries.HEIGHT_900;
         if(_loc3_ != this._isSmall)
         {
            this._isSmall = _loc3_;
            invalidateSize();
            invalidateLayout();
         }
      }
      
      public function showUnlockAnimation() : void
      {
         this._soundMgr.playControlsSnd(UNLOCK_STATE,SoundTypes.POST_PROGRESSION_MODULES,null);
         this.content.showUnlockAnimation();
      }
      
      private function showCounter(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:CounterProps = null;
         if(param1)
         {
            _loc2_ = !!this._isSmall ? int(COUNTER_OFFSET_Y_SMALL) : int(COUNTER_OFFSET_Y_BIG);
            _loc3_ = new CounterProps(4,_loc2_,TextFormatAlign.LEFT,true,Linkages.COUNTER_UI,CounterProps.DEFAULT_TF_PADDING,false,Counter.EMPTY_STATE);
            this._counterManager.setCounter(this.content,CounterManager.COUNTER_EMPTY,null,_loc3_);
         }
         else
         {
            this._counterManager.removeCounter(this.content);
         }
      }
      
      private function clearTween() : void
      {
         if(this._fadeTween)
         {
            this._fadeTween.paused = true;
            this._fadeTween.dispose();
            this._fadeTween = null;
         }
      }
      
      private function drawEarLines() : void
      {
         var _loc1_:int = this.content.height >> 1;
         var _loc2_:int = this.content.x - LINE_GAP;
         var _loc3_:int = this.content.x + this.content.width + LINE_GAP;
         var _loc4_:Graphics = this._lines.graphics;
         _loc4_.clear();
         _loc4_.lineStyle(1,LINE_COLOR,BORDER_ALPHA);
         _loc4_.moveTo(_loc2_,_loc1_);
         _loc4_.lineTo(0,_loc1_);
         _loc4_.lineTo(0,0);
         _loc4_.moveTo(_loc3_,_loc1_);
         _loc4_.lineTo(_width,_loc1_);
         _loc4_.lineTo(_width,0);
         _loc4_.lineStyle(1,LINE_COLOR,CORNER_ALHPA);
         _loc4_.moveTo(_loc2_,_loc1_);
         _loc4_.lineTo(_loc2_ - CORNER_SIZE,_loc1_);
         _loc4_.moveTo(0,CORNER_SIZE);
         _loc4_.lineTo(0,0);
         _loc4_.moveTo(_loc3_,_loc1_);
         _loc4_.lineTo(_loc3_ + CORNER_SIZE,_loc1_);
         _loc4_.moveTo(_width,CORNER_SIZE);
         _loc4_.lineTo(_width,0);
         this._hitMc.graphics.clear();
         this._hitMc.graphics.beginFill(0,0);
         this._hitMc.graphics.drawRect(0,0,this.content.width,this.content.height);
         this._hitMc.graphics.endFill();
      }
      
      private function showTooltip() : void
      {
         if(this._data == null)
         {
            return;
         }
         this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.VEH_POST_PROGRESSION_ENTRY_POINT,this._data.vehicleId,ENTRY_POINT_PARENT_SCREEN);
      }
      
      private function set isHoverState(param1:Boolean) : void
      {
         if(this._isHoverState == param1)
         {
            return;
         }
         this._isHoverState = param1;
         invalidateState();
      }
      
      private function onMouseEventRollOverHandler(param1:MouseEvent) : void
      {
         this.isHoverState = true;
         if(this._data && this._data.label)
         {
            this._scheduler.scheduleTask(this.showTooltip,TOOLTIP_CUSTOM_DELAY);
         }
         else
         {
            this.showTooltip();
         }
         if(this._data.state == POSTPROGRESSION_CONSTS.RESEARCH_STATE_LOCKED)
         {
            this._soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.POST_PROGRESSION_MODULES,null);
         }
         else
         {
            this._soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
         }
      }
      
      private function onMouseEventRollOutHandler(param1:MouseEvent) : void
      {
         this.isHoverState = false;
         this._scheduler.cancelTask(this.showTooltip);
         this._tooltipMgr.hide();
      }
      
      private function onButtonEventClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            this._isHoverState = false;
            this.clearTween();
            this._labelCont.alpha = 0;
            this._scheduler.cancelTask(this.showTooltip);
            dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_POST_PROGRESSION));
            this._soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.OK_BTN,null);
         }
      }
   }
}
