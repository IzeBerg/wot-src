package net.wg.gui.components.advanced.calendar
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.events.CalendarEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class DayRenderer extends UIComponentEx
   {
      
      private static const STATE_EMPTY:int = 0;
      
      private static const STATE_DISABLED:int = 1;
      
      private static const STATE_ENABLED:int = 2;
      
      private static const STATE_TODAY:int = 4;
      
      private static const STATE_HIGHLIGHTED:int = 8;
       
      
      public var highlightArea:MovieClip = null;
      
      public var labelDisabled:TextField = null;
      
      public var labelUp:TextField = null;
      
      public var labelToday:TextField = null;
      
      public var labelTodayDisabled:TextField = null;
      
      private var _label:String = "";
      
      private var _state:int = 0;
      
      private var _date:Date = null;
      
      public function DayRenderer()
      {
         super();
         mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.highlightArea = null;
         this.labelToday = null;
         this.labelTodayDisabled = null;
         this.labelDisabled = null;
         this.labelUp = null;
         this._date = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         hitArea = this.highlightArea;
         this.labelToday.visible = this.labelUp.visible = this.labelDisabled.visible = this.labelTodayDisabled.visible = false;
         this.highlightArea.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(!this._state)
            {
               this.labelToday.visible = this.labelUp.visible = this.labelDisabled.visible = this.labelTodayDisabled.visible = false;
               this.highlightArea.visible = false;
               mouseEnabled = buttonMode = false;
            }
            else
            {
               _loc1_ = Boolean(this._state & STATE_TODAY);
               this.highlightArea.visible = Boolean(this._state & STATE_HIGHLIGHTED);
               _loc2_ = Boolean(this._state & STATE_DISABLED);
               mouseEnabled = buttonMode = !!_loc2_ ? Boolean(false) : Boolean(true);
               if(_loc2_)
               {
                  this.labelUp.visible = this.labelToday.visible = false;
                  this.labelTodayDisabled.visible = _loc1_;
                  this.labelDisabled.visible = !_loc1_;
               }
               else
               {
                  this.labelDisabled.visible = this.labelTodayDisabled.visible = false;
                  this.labelToday.visible = _loc1_;
                  this.labelUp.visible = !_loc1_;
               }
            }
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.labelDisabled.text = this.labelToday.text = this.labelUp.text = this.labelTodayDisabled.text = this._label;
         }
      }
      
      public function clear() : void
      {
         this._date = null;
         this._label = Values.EMPTY_STR;
         this._state = STATE_EMPTY;
         invalidate(InvalidationType.DATA,InvalidationType.STATE);
      }
      
      public function getDate() : Date
      {
         return this._date;
      }
      
      public function setDateAndState(param1:Date, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         if(param1)
         {
            this._date = param1;
            this._label = param1.date.toString();
            this._state = !!param2 ? int(STATE_ENABLED) : int(STATE_DISABLED);
            _loc3_ = App.utils.dateTime.isToday(param1);
            if(_loc3_)
            {
               this._state |= STATE_TODAY;
            }
            invalidate(InvalidationType.DATA,InvalidationType.STATE);
         }
         else
         {
            this.clear();
         }
      }
      
      public function switchHighlighted(param1:Boolean) : void
      {
         var _loc2_:Boolean = Boolean(this._state & STATE_ENABLED);
         var _loc3_:Boolean = !this._state || _loc2_;
         if(_loc2_)
         {
            if(param1)
            {
               this._state |= STATE_HIGHLIGHTED;
            }
            else if(this._state & STATE_HIGHLIGHTED)
            {
               this._state ^= STATE_HIGHLIGHTED;
            }
         }
         if(_loc3_)
         {
            invalidateState();
         }
      }
      
      private function dispatchCalendarEvent(param1:String) : void
      {
         var _loc2_:CalendarEvent = new CalendarEvent(param1,null,this.getDate(),true);
         dispatchEvent(_loc2_);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         if(!this._state || (this._state & STATE_DISABLED) == !param1 || (this._state & STATE_ENABLED) == param1)
         {
            return;
         }
         super.enabled = param1;
         if(!this._state)
         {
            this._state = !!param1 ? int(STATE_ENABLED) : int(STATE_DISABLED);
         }
         else if(param1 && this._state & STATE_DISABLED)
         {
            this._state ^= STATE_DISABLED;
            this._state |= STATE_ENABLED;
         }
         else
         {
            _loc2_ = Boolean(this._state & STATE_TODAY);
            this._state = !!param1 ? int(STATE_ENABLED) : int(STATE_DISABLED);
            if(_loc2_)
            {
               this._state |= STATE_TODAY;
            }
         }
         invalidateState();
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         if(this._state & STATE_ENABLED)
         {
            this.dispatchCalendarEvent(CalendarEvent.DAY_ROLL_OUT);
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._state & STATE_ENABLED)
         {
            this.dispatchCalendarEvent(CalendarEvent.DAY_ROLL_OVER);
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this._state & STATE_ENABLED)
         {
            this.dispatchCalendarEvent(CalendarEvent.DAY_CLICK);
         }
      }
   }
}
