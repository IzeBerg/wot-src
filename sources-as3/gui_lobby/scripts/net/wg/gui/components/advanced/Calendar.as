package net.wg.gui.components.advanced
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.calendar.DayRenderer;
   import net.wg.gui.components.advanced.calendar.WeekDayRenderer;
   import net.wg.gui.components.advanced.events.CalendarEvent;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.constants.ToolTipShowType;
   import net.wg.gui.components.controls.interfaces.IArrowButton;
   import net.wg.infrastructure.base.meta.ICalendarMeta;
   import net.wg.infrastructure.base.meta.impl.CalendarMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IDateTime;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class Calendar extends CalendarMeta implements ICalendarMeta, IFocusContainer
   {
      
      private static const TOTAL_RENDERERS:uint = 37;
      
      private static const STATUS_LBL_GAP:uint = 5;
      
      private static const SEPARATOR_LBL_GAP:int = 30;
      
      private static const INVALID_DISPLAY_DATE:String = "invalidDisplayDate";
      
      private static const INVALID_SELECTED_DATE:String = "invalidSelectedDate";
      
      private static const INVALID_HEADER:String = "invalidHeader";
      
      private static const INVALID_WEEK_START_DAY:String = "invalidWeekStartDay";
      
      private static const INVALID_WEEK_DAY_RENDERER:String = "invalidWeekDayRenderer";
      
      private static const INVALID_DAY_RENDERER:String = "invalidDayRenderer";
      
      private static const INVALID_DAYS_LAYOUT:String = "invalidDaysLayout";
      
      private static const INVALID_MONTH_EVENTS:String = "invalidMonthEvents";
      
      private static const INVALID_AVAILABLE_RANGE:String = "invalidAvailableRange";
      
      private static const INVALID_HIGHLIGHTED_DAYS:String = "invalidHighlightedDays";
      
      private static const INVALID_WEEK_DAY_HIGHLIGHT:String = "invalidWeekDayHighlight";
       
      
      public var monthTF:TextField = null;
      
      public var prevMonthButton:IArrowButton = null;
      
      public var nextMonthButton:IArrowButton = null;
      
      public var weekDaysContainer:Sprite = null;
      
      public var monthDaysContainer:Sprite = null;
      
      public var headerSeparator:Sprite = null;
      
      public var bottomSeparator:Sprite = null;
      
      public var statusLbl:LabelControl = null;
      
      public var defaultFocusToSelected:Boolean = false;
      
      public var needToInitFocus:Boolean = true;
      
      public var selectedMc:Sprite = null;
      
      private var _monthRenderers:Vector.<DisplayObject> = null;
      
      private var _weekRenderers:Vector.<DisplayObject> = null;
      
      private var _weekDayRenderer:String = "CalendarWeekDayUI";
      
      private var _dayRenderer:String = "CalendarDayUI";
      
      private var _showYear:Boolean = false;
      
      private var _weekStart:int = -1;
      
      private var _dayXStep:int = 36;
      
      private var _dayYStep:int = 36;
      
      private var _displayDate:Date = null;
      
      private var _currentSelectedDate:Date = null;
      
      private var _minAvailableDate:Date = null;
      
      private var _maxAvailableDate:Date = null;
      
      private var _dayVOClass:Class = null;
      
      private var _monthEvents:Array;
      
      private var _currentSelectedRenderer:DayRenderer = null;
      
      private var _highlightedDays:Array;
      
      private var _highlightedRenderers:Array;
      
      private var _isFocusInitialized:Boolean = false;
      
      private var _prevMonthNeedFocusUpdate:Boolean = false;
      
      private var _nextMonthNeedFocusUpdate:Boolean = false;
      
      private var _componentForFocus:InteractiveObject = null;
      
      private var _dateTime:IDateTime = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _highlightCurrentWeekDay:Boolean = false;
      
      private var _actualHeight:int = 0;
      
      private var _firstVisibleIndex:int = -1;
      
      private var _lastVisibleIndex:int = -1;
      
      private var _lastVisibleRow:int = -1;
      
      private var _dayTooltipType:String = "";
      
      public function Calendar()
      {
         this._monthEvents = [];
         this._highlightedDays = [];
         this._highlightedRenderers = [];
         super();
         this._dateTime = App.utils.dateTime;
         this._tooltipMgr = App.toolTipMgr;
         this._displayDate = this._dateTime.now();
      }
      
      private static function showComplexTT(param1:String, param2:String = "") : void
      {
         var _loc3_:String = App.toolTipMgr.getNewFormatter().addHeader(param1).addBody(param2).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.prevMonthButton.autoRepeat = true;
         this.nextMonthButton.autoRepeat = true;
         this.headerSeparator.mouseEnabled = false;
         this.headerSeparator.mouseChildren = false;
         this.bottomSeparator.mouseEnabled = false;
         this.bottomSeparator.mouseChildren = false;
         this.statusLbl.tooltipType = ToolTipShowType.SPECIAL;
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.prevMonthButton.addEventListener(ButtonEvent.CLICK,this.onMonthButtonClickHandler);
         this.nextMonthButton.addEventListener(ButtonEvent.CLICK,this.onMonthButtonClickHandler);
         this.prevMonthButton.addEventListener(MouseEvent.ROLL_OVER,this.onPrevMonthBtnRollOverHandler);
         this.prevMonthButton.addEventListener(MouseEvent.ROLL_OUT,this.onMonthBtnsRollOutHandler);
         this.nextMonthButton.addEventListener(MouseEvent.ROLL_OVER,this.onNextMonthBtnRollOverHandler);
         this.nextMonthButton.addEventListener(MouseEvent.ROLL_OUT,this.onMonthBtnsRollOutHandler);
         addEventListener(CalendarEvent.DAY_CLICK,this.onDayClickHandler);
         addEventListener(CalendarEvent.DAY_ROLL_OVER,this.onDayRollOverHandler);
         addEventListener(CalendarEvent.DAY_ROLL_OUT,this.onDayRollOutHandler);
         if(this.weekStart == -1)
         {
            this.weekStart = this._dateTime.getAS3FirstDayOfWeek();
         }
         this.monthTF.mouseEnabled = false;
         this.redrawMonthDays();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(InputEvent.INPUT,this.handleInput,false);
         removeEventListener(CalendarEvent.DAY_CLICK,this.onDayClickHandler);
         removeEventListener(CalendarEvent.DAY_ROLL_OVER,this.onDayRollOverHandler);
         removeEventListener(CalendarEvent.DAY_ROLL_OUT,this.onDayRollOutHandler);
         this.prevMonthButton.removeEventListener(ButtonEvent.CLICK,this.onMonthButtonClickHandler);
         this.nextMonthButton.removeEventListener(ButtonEvent.CLICK,this.onMonthButtonClickHandler);
         this.prevMonthButton.removeEventListener(MouseEvent.ROLL_OVER,this.onPrevMonthBtnRollOverHandler);
         this.prevMonthButton.removeEventListener(MouseEvent.ROLL_OUT,this.onMonthBtnsRollOutHandler);
         this.nextMonthButton.removeEventListener(MouseEvent.ROLL_OVER,this.onNextMonthBtnRollOverHandler);
         this.nextMonthButton.removeEventListener(MouseEvent.ROLL_OUT,this.onMonthBtnsRollOutHandler);
         this.statusLbl.dispose();
         this.statusLbl = null;
         this.prevMonthButton.dispose();
         this.prevMonthButton = null;
         this.nextMonthButton.dispose();
         this.nextMonthButton = null;
         this.selectedMc = null;
         if(this._highlightedRenderers)
         {
            this._highlightedRenderers.splice(0,this._highlightedRenderers.length);
            this._highlightedRenderers = null;
         }
         if(this._highlightedDays)
         {
            this._highlightedDays.splice(0,this._highlightedDays.length);
            this._highlightedDays = null;
         }
         this.clearWeekDays();
         this.clearMonthDays();
         this.monthTF = null;
         this.weekDaysContainer = null;
         this.monthDaysContainer = null;
         this.headerSeparator = null;
         this.bottomSeparator = null;
         this._dayVOClass = null;
         if(this._componentForFocus)
         {
            this._componentForFocus = null;
         }
         this._monthEvents = null;
         this._displayDate = null;
         this._currentSelectedDate = null;
         this._minAvailableDate = null;
         this._maxAvailableDate = null;
         this._currentSelectedRenderer = null;
         this._dateTime = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(isInvalid(INVALID_DISPLAY_DATE,INVALID_HEADER))
         {
            if(this._showYear)
            {
               _loc1_ = this._dateTime.toPyTimestamp(this._displayDate);
               this.monthTF.text = formatYMHeaderS(_loc1_);
            }
            else
            {
               this.monthTF.text = this._dateTime.getMonthName(this._displayDate.month,false);
            }
         }
         if(isInvalid(INVALID_WEEK_DAY_RENDERER))
         {
            this.redrawWeekDays();
         }
         if(isInvalid(INVALID_WEEK_START_DAY,INVALID_DAYS_LAYOUT))
         {
            this.updateWeekDays();
         }
         if(this._highlightCurrentWeekDay && isInvalid(INVALID_WEEK_DAY_HIGHLIGHT) || isInvalid(INVALID_DISPLAY_DATE,INVALID_WEEK_START_DAY,INVALID_WEEK_DAY_RENDERER))
         {
            this.updateHighlightedWeekDay();
         }
         if(isInvalid(INVALID_DAY_RENDERER))
         {
            if(this._componentForFocus && this._componentForFocus.parent == this.monthDaysContainer)
            {
               this.requestNewFocus(this);
            }
            this.redrawMonthDays();
            this.updateMonthDays();
            this.updateFocus();
         }
         if(isInvalid(INVALID_DISPLAY_DATE))
         {
            if(this._componentForFocus && this._componentForFocus.parent == this.monthDaysContainer)
            {
               this.requestNewFocus(this);
            }
            this.updateMonthDays();
            this.updateFocus();
         }
         if(isInvalid(INVALID_DAYS_LAYOUT))
         {
            this.updateMonthDays();
         }
         if(isInvalid(INVALID_AVAILABLE_RANGE,INVALID_DISPLAY_DATE))
         {
            this.updateAvailableRange();
            this.updateNavigationButtons();
         }
         if(isInvalid(INVALID_SELECTED_DATE,INVALID_DISPLAY_DATE,INVALID_DAY_RENDERER))
         {
            this.updateSelectedRenderer();
         }
         if(isInvalid(INVALID_HIGHLIGHTED_DAYS))
         {
            this.updateHighlightedDays();
         }
      }
      
      override protected function setHighlightedDays(param1:Array) : void
      {
         this._highlightedDays = param1;
         invalidate(INVALID_HIGHLIGHTED_DAYS);
      }
      
      public function as_openMonth(param1:Number) : void
      {
         this.displayDate = this._dateTime.fromPyTimestamp(param1);
      }
      
      public function as_selectDate(param1:Number) : void
      {
         this.currentSelectedDate = this._dateTime.fromPyTimestamp(param1);
      }
      
      public function as_setDayTooltipType(param1:String) : void
      {
         if(param1 == this._dayTooltipType)
         {
            return;
         }
         this._dayTooltipType = param1;
      }
      
      public function as_setMaxAvailableDate(param1:Number) : void
      {
         this.maxAvailableDate = this._dateTime.fromPyTimestamp(param1);
      }
      
      public function as_setMinAvailableDate(param1:Number) : void
      {
         this.minAvailableDate = this._dateTime.fromPyTimestamp(param1);
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this._componentForFocus;
      }
      
      public function setStatus(param1:String, param2:String) : void
      {
         this.statusLbl.visible = true;
         this.statusLbl.htmlText = param1;
         this.statusLbl.toolTip = param2;
         this.monthDaysContainer.y += this.statusLbl.height + STATUS_LBL_GAP;
         this.weekDaysContainer.y += this.statusLbl.height + STATUS_LBL_GAP;
         this.headerSeparator.y += this.statusLbl.height + STATUS_LBL_GAP;
         this.bottomSeparator.y += this.statusLbl.height + STATUS_LBL_GAP;
      }
      
      private function updateHighlightedDays() : void
      {
         var _loc1_:DayRenderer = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Date = null;
         var _loc6_:Date = null;
         var _loc9_:int = 0;
         if(this._highlightedRenderers)
         {
            for each(_loc1_ in this._highlightedRenderers)
            {
               _loc1_.switchHighlighted(false);
            }
            this._highlightedRenderers.splice(0,this._highlightedRenderers.length);
         }
         this._highlightedRenderers = [];
         var _loc7_:int = Values.DEFAULT_INT;
         var _loc8_:int = Values.DEFAULT_INT;
         _loc2_ = this._highlightedDays.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._highlightedDays[_loc3_];
            if(_loc4_ == 0)
            {
               _loc5_ = null;
            }
            else if(_loc5_)
            {
               if(this._dateTime.timeDiff(this._displayDate,_loc5_) < 0 && this._displayDate.month < _loc5_.month)
               {
                  _loc5_ = null;
               }
               else
               {
                  _loc7_ = Values.DEFAULT_INT;
                  _loc8_ = Values.DEFAULT_INT;
                  _loc6_ = this._dateTime.fromPyTimestamp(_loc4_);
                  if(!this._dateTime.isSameMonth(_loc5_,this._displayDate))
                  {
                     _loc7_ = 0;
                  }
                  else
                  {
                     _loc7_ = this.getRendererIndexByDate(_loc5_);
                  }
                  if(this._dateTime.timeDiff(this._displayDate,_loc6_) > 0 && this._displayDate.month > _loc6_.month || this._displayDate.fullYear > _loc6_.fullYear)
                  {
                     _loc5_ = null;
                     _loc6_ = null;
                  }
                  else
                  {
                     if(!this._dateTime.isSameMonth(_loc6_,this._displayDate))
                     {
                        _loc8_ = this._monthRenderers.length - 1;
                     }
                     else
                     {
                        _loc8_ = this.getRendererIndexByDate(_loc6_);
                     }
                     if(_loc7_ > Values.DEFAULT_INT && _loc8_ > Values.DEFAULT_INT)
                     {
                        _loc9_ = _loc7_;
                        while(_loc9_ <= _loc8_)
                        {
                           _loc1_ = DayRenderer(this._monthRenderers[_loc9_]);
                           _loc1_.switchHighlighted(true);
                           this._highlightedRenderers.push(_loc1_);
                           _loc9_++;
                        }
                     }
                     _loc6_ = null;
                     _loc5_ = null;
                  }
               }
            }
            else
            {
               _loc5_ = this._dateTime.fromPyTimestamp(_loc4_);
               if(_loc3_ == _loc2_ - 1)
               {
                  _loc1_ = this.getRendererByDate(_loc5_);
                  if(_loc1_)
                  {
                     _loc1_.switchHighlighted(true);
                     this._highlightedRenderers.push(_loc1_);
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function updateSelectedRenderer() : void
      {
         this._currentSelectedRenderer = this.getRendererByDate(this._currentSelectedDate);
         this.selectedMc.visible = this._currentSelectedRenderer != null;
         if(this._currentSelectedRenderer)
         {
            this.selectedMc.x = this.monthDaysContainer.x + this._currentSelectedRenderer.x + 1;
            this.selectedMc.y = this.monthDaysContainer.y + this._currentSelectedRenderer.y - 7;
         }
      }
      
      private function updateAvailableRange() : void
      {
         var _loc2_:DayRenderer = null;
         var _loc3_:Date = null;
         var _loc1_:IDateTime = this._dateTime;
         var _loc4_:Boolean = true;
         var _loc5_:int = 0;
         while(_loc5_ < TOTAL_RENDERERS)
         {
            _loc2_ = DayRenderer(this._monthRenderers[_loc5_]);
            if(_loc5_ >= this._firstVisibleIndex && _loc5_ <= this._lastVisibleIndex)
            {
               _loc3_ = _loc2_.getDate();
               if(this._minAvailableDate)
               {
                  _loc4_ = _loc1_.isSameDay(_loc3_,this._minAvailableDate) || _loc1_.timeDiff(_loc3_,this._minAvailableDate) > 0;
               }
               if(_loc4_ && this._maxAvailableDate)
               {
                  _loc4_ = _loc1_.isSameDay(_loc3_,this._maxAvailableDate) || _loc1_.timeDiff(_loc3_,this._maxAvailableDate) < 0;
               }
               _loc2_.enabled = _loc4_;
            }
            else
            {
               _loc2_.enabled = false;
            }
            _loc5_++;
         }
      }
      
      private function updateNavigationButtons() : void
      {
         this.prevMonthButton.visible = this.canNavigateToPrevMonth;
         this.nextMonthButton.visible = this.canNavigateToNextMonth;
      }
      
      private function updateHighlightedWeekDay() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:WeekDayRenderer = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._highlightCurrentWeekDay)
         {
            _loc1_ = this._dateTime.isCurrentMonth(this._displayDate);
            _loc2_ = this._dateTime.now().day;
            _loc4_ = this._weekRenderers.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc3_ = WeekDayRenderer(this.weekDaysContainer.getChildAt(_loc5_));
               if(_loc1_)
               {
                  if(this.getDayNumByColumn(_loc5_) == _loc2_)
                  {
                     _loc3_.state = WeekDayRenderer.STATE_HIGHLIGHTED;
                  }
                  else
                  {
                     _loc3_.state = WeekDayRenderer.STATE_NORMAL;
                  }
               }
               else
               {
                  _loc3_.state = WeekDayRenderer.STATE_NORMAL;
               }
               _loc5_++;
            }
         }
      }
      
      private function redrawWeekDays() : void
      {
         var _loc1_:WeekDayRenderer = null;
         this.clearWeekDays();
         this._weekRenderers = new Vector.<DisplayObject>();
         var _loc2_:Class = App.utils.classFactory.getClass(this._weekDayRenderer);
         var _loc3_:Array = App.utils.getWeekDayNamesS(false,false,true);
         var _loc4_:int = 0;
         while(_loc4_ < Time.DAYS_IN_WEEK)
         {
            _loc1_ = App.utils.classFactory.getComponent(this._weekDayRenderer,_loc2_);
            _loc1_.x = _loc4_ * this._dayXStep;
            _loc1_.label = _loc3_[_loc4_];
            _loc1_.state = WeekDayRenderer.STATE_NORMAL;
            this.weekDaysContainer.addChild(_loc1_);
            this._weekRenderers.push(_loc1_);
            _loc4_++;
         }
      }
      
      private function updateWeekDays() : void
      {
         var _loc1_:WeekDayRenderer = null;
         var _loc2_:Array = App.utils.getWeekDayNamesS(false,false,true);
         var _loc3_:int = 0;
         while(_loc3_ < Time.DAYS_IN_WEEK)
         {
            _loc1_ = WeekDayRenderer(this._weekRenderers[_loc3_]);
            _loc1_.x = _loc3_ * this._dayXStep;
            _loc1_.label = _loc2_[_loc3_];
            _loc3_++;
         }
      }
      
      private function clearWeekDays() : void
      {
         while(this.weekDaysContainer.numChildren > 0)
         {
            this.weekDaysContainer.removeChildAt(0);
         }
         if(this._weekRenderers)
         {
            this._weekRenderers.splice(0,this._weekRenderers.length);
            this._weekRenderers = null;
         }
      }
      
      private function redrawMonthDays() : void
      {
         var _loc1_:DayRenderer = null;
         this.clearMonthDays();
         this._monthRenderers = new Vector.<DisplayObject>();
         var _loc2_:Class = App.utils.classFactory.getClass(this._dayRenderer);
         var _loc3_:int = 0;
         while(_loc3_ < TOTAL_RENDERERS)
         {
            _loc1_ = App.utils.classFactory.getComponent(this._dayRenderer,_loc2_);
            _loc1_.x = _loc3_ % Time.DAYS_IN_WEEK * this._dayXStep;
            _loc1_.y = (_loc3_ / Time.DAYS_IN_WEEK | 0) * this._dayYStep;
            this.monthDaysContainer.addChild(_loc1_);
            this._monthRenderers.push(_loc1_);
            _loc3_++;
         }
         this._actualHeight = this.monthDaysContainer.y + this.monthDaysContainer.height;
         this.dispatchCalendarEvent(CalendarEvent.LAYOUT_CHANGED);
      }
      
      private function updateMonthDays() : void
      {
         var _loc1_:DayRenderer = null;
         var _loc2_:uint = this._dateTime.getMonthDaysCount(this._displayDate);
         var _loc3_:Date = this._dateTime.cloneDate(this._displayDate);
         _loc3_.date = 1;
         this._firstVisibleIndex = this.getWeekShift(this._displayDate);
         this._lastVisibleIndex = this._firstVisibleIndex + _loc2_ - 1;
         var _loc4_:int = 0;
         while(_loc4_ < TOTAL_RENDERERS)
         {
            _loc1_ = DayRenderer(this._monthRenderers[_loc4_]);
            if(_loc4_ >= this._firstVisibleIndex && _loc4_ <= this._lastVisibleIndex)
            {
               _loc1_.visible = true;
               _loc1_.setDateAndState(_loc3_,true);
               _loc3_ = this._dateTime.shiftDate(_loc3_,Time.DAY);
            }
            else
            {
               _loc1_.visible = false;
               _loc1_.clear();
            }
            _loc4_++;
         }
         var _loc5_:int = this._lastVisibleIndex / Time.DAYS_IN_WEEK | 0;
         if(_loc5_ != this._lastVisibleRow)
         {
            this._lastVisibleRow = _loc5_;
            this._actualHeight = this.monthDaysContainer.y + (this._lastVisibleRow + 1) * this._dayYStep;
            this.dispatchCalendarEvent(CalendarEvent.LAYOUT_CHANGED);
         }
         this.bottomSeparator.y = this.monthDaysContainer.y + this._lastVisibleRow * this._dayYStep - SEPARATOR_LBL_GAP;
         this.updateHighlightedDays();
      }
      
      private function clearMonthDays() : void
      {
         var _loc1_:DayRenderer = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._currentSelectedRenderer)
         {
            this._currentSelectedRenderer = null;
         }
         if(this._monthRenderers)
         {
            _loc2_ = this._monthRenderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = DayRenderer(this._monthRenderers[_loc3_]);
               this.monthDaysContainer.removeChild(_loc1_);
               _loc1_.dispose();
               _loc3_++;
            }
            this._monthRenderers.splice(0,_loc2_);
            this._monthRenderers = null;
         }
      }
      
      private function changeDisplayDate(param1:Date) : void
      {
         this.displayDate = param1;
         this.dispatchCalendarEvent(CalendarEvent.MONTH_CHANGED);
         if(isDAAPIInited)
         {
            onMonthChangedS(this._dateTime.toPyTimestamp(this._displayDate));
         }
      }
      
      private function dispatchCalendarEvent(param1:String) : void
      {
         dispatchEvent(new CalendarEvent(param1,this._dateTime.cloneDate(this._displayDate),Boolean(this._currentSelectedDate) ? this._dateTime.cloneDate(this._currentSelectedDate) : null));
      }
      
      private function getDayNumByColumn(param1:uint) : uint
      {
         return int(this._weekStart + (param1 < Time.DAYS_IN_WEEK - this._weekStart ? param1 : param1 - Time.DAYS_IN_WEEK));
      }
      
      private function getDayColumnByDate(param1:Date) : Number
      {
         return uint(this._weekStart > param1.day ? uint(Time.DAYS_IN_WEEK - this._weekStart + param1.day) : uint(param1.day - this._weekStart));
      }
      
      private function getDayRowByDate(param1:Date, param2:Number = -1) : Number
      {
         if(param2 == -1)
         {
            param2 = this.getWeekShift(param1);
         }
         return uint((param1.date - 1 + param2) / Time.DAYS_IN_WEEK);
      }
      
      private function getWeekShift(param1:Date) : uint
      {
         var _loc2_:Date = this._dateTime.cloneDate(param1);
         _loc2_.date = 1;
         return uint(_loc2_.day < this._weekStart ? uint(Time.DAYS_IN_WEEK - this._weekStart + _loc2_.day) : uint(_loc2_.day - this._weekStart));
      }
      
      private function getRendererByDate(param1:Date) : DayRenderer
      {
         var _loc2_:DayRenderer = null;
         var _loc3_:int = this.getRendererIndexByDate(param1);
         if(_loc3_ != Values.DEFAULT_INT)
         {
            _loc2_ = DayRenderer(this._monthRenderers[_loc3_]);
         }
         return _loc2_;
      }
      
      private function getRendererIndexByDate(param1:Date) : int
      {
         var _loc2_:int = Values.DEFAULT_INT;
         if(param1 && this._dateTime.isSameMonth(param1,this._displayDate))
         {
            _loc2_ = this._firstVisibleIndex + int(param1.date - 1);
         }
         return _loc2_;
      }
      
      private function updateFocus() : void
      {
         if(!this._isFocusInitialized && this.needToInitFocus)
         {
            this.requestNewFocus(this.getElementForInitialFocus());
            this._isFocusInitialized = true;
         }
         else if(this._nextMonthNeedFocusUpdate)
         {
            this.requestNewFocus(this.getFirstMonthDayRenderer());
            this._nextMonthNeedFocusUpdate = false;
         }
         else if(this._prevMonthNeedFocusUpdate)
         {
            this.requestNewFocus(this.getLastMonthDayRenderer());
            this._prevMonthNeedFocusUpdate = false;
         }
      }
      
      private function getElementForInitialFocus() : InteractiveObject
      {
         var _loc2_:InteractiveObject = null;
         var _loc3_:Date = null;
         var _loc1_:Date = this.defaultFocusToSelected && this._currentSelectedDate != null ? this._currentSelectedDate : this._dateTime.now();
         if(this._dateTime.isSameMonth(_loc1_,this._displayDate))
         {
            _loc2_ = this.getRendererByDate(_loc1_);
         }
         else
         {
            _loc3_ = this._dateTime.cloneDate(this._displayDate);
            _loc3_.date = 1;
            _loc2_ = this.getRendererByDate(_loc3_);
         }
         return _loc2_;
      }
      
      private function getFocusedRenderer() : DayRenderer
      {
         var _loc1_:DayRenderer = null;
         var _loc2_:DayRenderer = null;
         var _loc3_:int = 0;
         while(_loc3_ < TOTAL_RENDERERS)
         {
            _loc1_ = DayRenderer(this._monthRenderers[_loc3_]);
            if(_loc1_.focused)
            {
               _loc2_ = _loc1_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getFirstMonthDayRenderer() : DayRenderer
      {
         var _loc1_:DayRenderer = null;
         if(this._firstVisibleIndex != Values.DEFAULT_INT)
         {
            _loc1_ = DayRenderer(this._monthRenderers[this._firstVisibleIndex]);
         }
         return _loc1_;
      }
      
      private function getLastMonthDayRenderer() : DayRenderer
      {
         var _loc1_:DayRenderer = null;
         if(this._lastVisibleIndex != Values.DEFAULT_INT)
         {
            _loc1_ = DayRenderer(this._monthRenderers[this._lastVisibleIndex]);
         }
         return _loc1_;
      }
      
      private function getNextMonth() : Date
      {
         var _loc1_:Date = null;
         if(this._displayDate.month != Time.MONTHS_IN_YEAR - 1)
         {
            _loc1_ = new Date(this._displayDate.fullYear,this._displayDate.month + 1,Time.FIRST_DAY_IN_MONTH,this._displayDate.hours,this._displayDate.minutes,this._displayDate.seconds);
         }
         else
         {
            _loc1_ = new Date(this._displayDate.fullYear + 1,0,Time.FIRST_DAY_IN_MONTH,this._displayDate.hours,this._displayDate.minutes,this._displayDate.seconds);
         }
         return _loc1_;
      }
      
      private function getPrevMonth() : Date
      {
         var _loc1_:Date = null;
         if(this._displayDate.month != 0)
         {
            _loc1_ = new Date(this._displayDate.fullYear,this._displayDate.month - 1,Time.FIRST_DAY_IN_MONTH,this._displayDate.hours);
         }
         else
         {
            _loc1_ = new Date(this._displayDate.fullYear - 1,Time.MONTHS_IN_YEAR - 1,Time.FIRST_DAY_IN_MONTH,this._displayDate.hours);
         }
         return _loc1_;
      }
      
      private function requestNewFocus(param1:InteractiveObject) : void
      {
         this._componentForFocus = param1;
         dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
      }
      
      override public function get height() : Number
      {
         return this._actualHeight;
      }
      
      public function get canNavigateToPrevMonth() : Boolean
      {
         return !(this._minAvailableDate && this._dateTime.isSameMonth(this._minAvailableDate,this._displayDate));
      }
      
      public function get canNavigateToNextMonth() : Boolean
      {
         return !(this._maxAvailableDate && this._dateTime.isSameMonth(this._maxAvailableDate,this._displayDate));
      }
      
      public function get displayDate() : Date
      {
         return this._displayDate;
      }
      
      public function set displayDate(param1:Date) : void
      {
         this._displayDate = param1;
         invalidate(INVALID_DISPLAY_DATE);
      }
      
      [Inspectable(defaultValue="CalendarWeekDayUI",name="weekDayRenderer",type="String")]
      public function get weekDayRenderer() : String
      {
         return this._weekDayRenderer;
      }
      
      public function set weekDayRenderer(param1:String) : void
      {
         this._weekDayRenderer = param1;
         invalidate(INVALID_WEEK_DAY_RENDERER);
      }
      
      [Inspectable(defaultValue="CalendarDayUI",name="dayRenderer",type="String")]
      public function get dayRenderer() : String
      {
         return this._dayRenderer;
      }
      
      public function set dayRenderer(param1:String) : void
      {
         this._dayRenderer = param1;
         invalidate(INVALID_DAY_RENDERER);
      }
      
      [Inspectable(defaultValue="false",name="showYear",type="Boolean")]
      public function get showYear() : Boolean
      {
         return this._showYear;
      }
      
      public function set showYear(param1:Boolean) : void
      {
         this._showYear = param1;
         invalidate(INVALID_HEADER);
      }
      
      [Inspectable(defaultValue="-1",name="weekStart",type="Number")]
      public function get weekStart() : int
      {
         return this._weekStart;
      }
      
      public function set weekStart(param1:int) : void
      {
         this._weekStart = param1;
         invalidate(INVALID_WEEK_START_DAY);
      }
      
      [Inspectable(defaultValue="36",name="dayXStep",type="Number")]
      public function get dayXStep() : Number
      {
         return this._dayXStep;
      }
      
      public function set dayXStep(param1:Number) : void
      {
         this._dayXStep = param1;
         invalidate(INVALID_DAYS_LAYOUT);
      }
      
      [Inspectable(defaultValue="36",name="dayYStep",type="Number")]
      public function get dayYStep() : Number
      {
         return this._dayYStep;
      }
      
      public function set dayYStep(param1:Number) : void
      {
         this._dayYStep = param1;
         invalidate(INVALID_DAYS_LAYOUT);
      }
      
      public function get currentSelectedDate() : Date
      {
         return this._currentSelectedDate;
      }
      
      public function set currentSelectedDate(param1:Date) : void
      {
         this._currentSelectedDate = param1;
         invalidate(INVALID_SELECTED_DATE);
      }
      
      public function get minAvailableDate() : Date
      {
         return this._minAvailableDate;
      }
      
      public function set minAvailableDate(param1:Date) : void
      {
         this._minAvailableDate = param1;
         invalidate(INVALID_AVAILABLE_RANGE);
      }
      
      public function get maxAvailableDate() : Date
      {
         return this._maxAvailableDate;
      }
      
      public function set maxAvailableDate(param1:Date) : void
      {
         this._maxAvailableDate = param1;
         invalidate(INVALID_AVAILABLE_RANGE);
      }
      
      [Inspectable(defaultValue="-1",name="year",type="Number")]
      public function get year() : int
      {
         return this._displayDate.fullYear;
      }
      
      public function set year(param1:int) : void
      {
         if(param1 == -1 || param1 == this._displayDate.fullYear)
         {
            return;
         }
         var _loc2_:Date = this._dateTime.cloneDate(this._displayDate);
         _loc2_.fullYear = param1;
         this.currentSelectedDate = _loc2_;
      }
      
      [Inspectable(defaultValue="-1",name="month",type="Number")]
      public function get month() : int
      {
         return this._displayDate.month;
      }
      
      public function set month(param1:int) : void
      {
         if(param1 == -1 || param1 == this._displayDate.month)
         {
            return;
         }
         var _loc2_:Date = this._dateTime.cloneDate(this._displayDate);
         _loc2_.month = param1;
         this.currentSelectedDate = _loc2_;
      }
      
      public function get dayVOClass() : Class
      {
         return this._dayVOClass;
      }
      
      public function set dayVOClass(param1:Class) : void
      {
         this._dayVOClass = param1;
         invalidate(INVALID_MONTH_EVENTS);
      }
      
      public function get monthEvents() : Array
      {
         return this._monthEvents;
      }
      
      public function set monthEvents(param1:Array) : void
      {
         this._monthEvents = param1;
         invalidate(INVALID_MONTH_EVENTS);
      }
      
      public function get highlightCurrentWeekDay() : Boolean
      {
         return this._highlightCurrentWeekDay;
      }
      
      public function set highlightCurrentWeekDay(param1:Boolean) : void
      {
         this._highlightCurrentWeekDay = param1;
         invalidate(INVALID_WEEK_DAY_HIGHLIGHT);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc3_:Date = null;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:InputDetails = null;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Date = null;
         if(param1.handled)
         {
            return;
         }
         var _loc2_:DayRenderer = this.getFocusedRenderer();
         if(_loc2_)
         {
            _loc3_ = _loc2_.getDate();
            _loc4_ = this._dateTime.getMonthDaysCount(this._displayDate);
            _loc5_ = _loc3_.date <= Time.DAYS_IN_WEEK;
            _loc6_ = _loc3_.date > _loc4_ - Time.DAYS_IN_WEEK;
            _loc7_ = _loc2_ == this.getFirstMonthDayRenderer();
            _loc8_ = _loc2_ == this.getLastMonthDayRenderer();
            _loc9_ = param1.details;
            _loc10_ = _loc9_.value == InputValue.KEY_DOWN || _loc9_.value == InputValue.KEY_HOLD;
            _loc11_ = false;
            _loc12_ = false;
            if(_loc10_)
            {
               switch(_loc9_.navEquivalent)
               {
                  case NavigationCode.UP:
                     if(_loc5_)
                     {
                        _loc12_ = true;
                     }
                     break;
                  case NavigationCode.DOWN:
                     if(_loc6_)
                     {
                        _loc11_ = true;
                     }
                     break;
                  case NavigationCode.LEFT:
                     if(_loc7_)
                     {
                        _loc12_ = true;
                     }
                     else if(this.getDayColumnByDate(_loc3_) == 0)
                     {
                        _loc13_ = this._dateTime.shiftDate(_loc3_,-Time.DAY);
                     }
                     break;
                  case NavigationCode.RIGHT:
                     if(_loc8_)
                     {
                        _loc11_ = true;
                     }
                     else if(this.getDayColumnByDate(_loc3_) == Time.DAYS_IN_WEEK - 1)
                     {
                        _loc13_ = this._dateTime.shiftDate(_loc3_,Time.DAY);
                     }
               }
            }
            if(_loc13_)
            {
               this.requestNewFocus(this.getRendererByDate(_loc13_));
               param1.handled = true;
            }
            else if(_loc11_ && this.canNavigateToNextMonth)
            {
               this._nextMonthNeedFocusUpdate = true;
               this.changeDisplayDate(this.getNextMonth());
               param1.handled = true;
            }
            else if(_loc12_ && this.canNavigateToPrevMonth)
            {
               this._prevMonthNeedFocusUpdate = true;
               this.changeDisplayDate(this.getPrevMonth());
               param1.handled = true;
            }
         }
      }
      
      private function onDayClickHandler(param1:CalendarEvent) : void
      {
         param1.stopImmediatePropagation();
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.NORMAL_BTN,null);
         this.currentSelectedDate = this._dateTime.cloneDate(param1.selectedDate);
         this.dispatchCalendarEvent(CalendarEvent.DAY_SELECTED);
         if(isDAAPIInited)
         {
            onDateSelectedS(this._dateTime.toPyTimestamp(this._currentSelectedDate));
         }
      }
      
      private function onMonthButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:Boolean = param1.currentTarget == this.nextMonthButton;
         if(_loc2_)
         {
            this.changeDisplayDate(this.getNextMonth());
         }
         else
         {
            this.changeDisplayDate(this.getPrevMonth());
         }
      }
      
      private function onDayRollOverHandler(param1:CalendarEvent) : void
      {
         param1.stopImmediatePropagation();
         if(StringUtils.isNotEmpty(this._dayTooltipType))
         {
            this._tooltipMgr.showSpecial(this._dayTooltipType,null,this._dateTime.toPyTimestamp(param1.selectedDate));
         }
      }
      
      private function onDayRollOutHandler(param1:CalendarEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onPrevMonthBtnRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(TOOLTIPS.CALENDAR_PREVMONTH);
      }
      
      private function onNextMonthBtnRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(TOOLTIPS.CALENDAR_NEXTMONTH);
      }
      
      private function onMonthBtnsRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
