package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
   import net.wg.gui.battle.views.vehicleMarkers.event.EventConstants;
   import net.wg.gui.battle.views.vehicleMarkers.event.EventVolotBase;
   import net.wg.gui.battle.views.vehicleMarkers.event.EventVolotProgress;
   import net.wg.gui.battle.views.vehicleMarkers.event.EventVolotTimer;
   
   public class EventVolotMarker extends BaseActionMarker
   {
      
      private static const SEPARATOR:String = " ";
      
      private static const REPLIED_ME_STATE:int = 1;
      
      public static const ARROW_RADIUS:int = 68;
      
      public static const PROGRESS_REPLAY_POSITION:Point = new Point(36,-15);
      
      public static const TIMER_REPLAY_POSITION:Point = new Point(47,-19);
      
      protected static const DISTANCE_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      protected static const PROGRESS_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      protected static const PROGRESS_STATE_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      protected static const HOVER_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;
      
      protected static const REPLIED_ME_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 5;
      
      protected static const ALL_INV:uint = DISTANCE_INV | PROGRESS_INV | PROGRESS_STATE_INV | HOVER_INV | REPLIED_ME_INV;
      
      private static const STATE_PROGRESS:int = 1;
      
      private static const STATE_TIMER:int = 2;
       
      
      public var marker:MovieClip = null;
      
      public var progress:EventVolotProgress = null;
      
      public var timer:EventVolotTimer = null;
      
      private var _isHidden:Boolean;
      
      private var _isHovered:Boolean;
      
      private var _currentProgress:int = 0;
      
      private var _maximumProgress:int = 0;
      
      private var _distance:Number = 120;
      
      private var _isProgressActive:Boolean;
      
      private var _state:int;
      
      private var _repliedMeVisible:Boolean;
      
      private var _unitsLocale:String;
      
      public function EventVolotMarker()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.progress.visible = false;
         this.timer.visible = false;
         stickyMarker.setArrowRadius(ARROW_RADIUS);
         replyMarker.filters = [EventConstants.REPLY_FILTER];
      }
      
      override protected function onDispose() : void
      {
         this.marker = null;
         replyMarker.filters = null;
         this.progress.dispose();
         this.progress = null;
         this.timer.dispose();
         this.timer = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc3_:EventVolotBase = null;
         super.draw();
         var _loc1_:Boolean = this._state == STATE_PROGRESS && !this._isHidden;
         var _loc2_:Boolean = this._state == STATE_TIMER && !this._isHidden;
         if(isInvalid(InvalidationType.STATE))
         {
            this.progress.visible = _loc1_;
            this.timer.visible = _loc2_;
            replyMarker.setReplyElementPosition(this.resolveReplayPosition());
            invalidate(ALL_INV);
         }
         if(_loc1_)
         {
            if(isInvalid(PROGRESS_STATE_INV))
            {
               this.progress.setEnabled(this._isProgressActive);
               invalidate(DISTANCE_INV);
            }
            if(isInvalid(PROGRESS_INV))
            {
               this.progress.setEnergyLeft(this._maximumProgress - this._currentProgress);
            }
            _loc3_ = this.progress;
         }
         else if(_loc2_)
         {
            _loc3_ = this.timer;
         }
         if(_loc3_ != null)
         {
            if(isInvalid(DISTANCE_INV))
            {
               _loc3_.setDistance(this._distance + this._unitsLocale);
            }
            if(isInvalid(HOVER_INV))
            {
               _loc3_.setHovered(this._isHovered);
            }
            if(isInvalid(REPLIED_ME_INV))
            {
               _loc3_.setRepliedMeVisible(this._repliedMeVisible);
            }
         }
      }
      
      public function activateHover(param1:Boolean) : void
      {
         if(this._isHovered == param1)
         {
            return;
         }
         this._isHovered = param1;
         invalidate(HOVER_INV);
      }
      
      public function setActiveState(param1:int) : void
      {
         var _loc2_:Boolean = param1 == REPLIED_ME_STATE;
         if(this._repliedMeVisible == _loc2_)
         {
            return;
         }
         this._repliedMeVisible = _loc2_;
         invalidate(REPLIED_ME_INV);
      }
      
      public function setDistance(param1:Number) : void
      {
         var _loc2_:Number = !isNaN(param1) ? Number(Math.round(param1)) : Number(-1);
         if(this._distance == _loc2_)
         {
            return;
         }
         this._distance = _loc2_;
         invalidate(DISTANCE_INV);
      }
      
      public function setHidden(param1:Boolean) : void
      {
         this._isHidden = param1;
         invalidate(InvalidationType.STATE);
      }
      
      public function setIconActive(param1:Boolean) : void
      {
         this._isProgressActive = param1;
         this.setState(STATE_PROGRESS);
         invalidate(PROGRESS_STATE_INV);
      }
      
      public function setLocales(param1:String) : void
      {
         this._unitsLocale = SEPARATOR + param1;
         invalidate(DISTANCE_INV);
      }
      
      public function setProgress(param1:int, param2:int) : void
      {
         this._currentProgress = param1;
         this._maximumProgress = param2;
         this.setState(STATE_PROGRESS);
         invalidate(PROGRESS_INV);
      }
      
      public function setTimer() : void
      {
         this.setState(STATE_TIMER);
      }
      
      protected function resolveReplayPosition() : Point
      {
         return this._state == STATE_PROGRESS ? PROGRESS_REPLAY_POSITION : TIMER_REPLAY_POSITION;
      }
      
      private function setState(param1:int) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         invalidate(InvalidationType.STATE);
      }
      
      override protected function get getReplyPosition() : Point
      {
         return this.resolveReplayPosition();
      }
   }
}
