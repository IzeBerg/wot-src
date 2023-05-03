package net.wg.gui.battle.views.minimap.components.entries.vehicle
{
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   
   public class MinimapEntryLabelHelper
   {
      
      private static const HP_OFFSET_X:int = 8;
      
      private static const HP_OFFSET_Y:int = -2;
      
      private static const TICK_INTERVAL:int = 330;
      
      private static const OFFSET_Y_BETWEEN_TEXT_AND_BORDER:int = 3;
       
      
      private var _timer:Timer;
      
      private var bounds:Point;
      
      private var _entryRef:VehicleMinimapEntry;
      
      private var _initialOffsetX:int;
      
      private var _initialOffsetY:int;
      
      private var _hpOffsetX:int;
      
      private var _hpOffsetY:int;
      
      private var _isSuspended:Boolean = true;
      
      private var _sizeIndex:int;
      
      private var _currentTF:TextField;
      
      private var __prevEntityX:Number = 0;
      
      private var __prevEntityY:Number = 0;
      
      private var _tfWidthOnScreen:Number = 0;
      
      private var _tfHeightOnScreen:Number = 0;
      
      public function MinimapEntryLabelHelper(param1:VehicleMinimapEntry, param2:TextField)
      {
         this.bounds = new Point(MinimapSizeConst.MAP_SIZE[0].width / 2,MinimapSizeConst.MAP_SIZE[0].height / 2);
         super();
         this._entryRef = param1;
         this._initialOffsetX = param2.x;
         this._initialOffsetY = param2.y;
         this._hpOffsetX = this._initialOffsetX + HP_OFFSET_X;
         this._hpOffsetY = this._initialOffsetY + HP_OFFSET_Y;
         this._timer = new Timer(TICK_INTERVAL);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimerHandler,false,0,true);
         this.setCurrentTF(param2);
      }
      
      public function setCurrentTF(param1:TextField) : void
      {
         this._currentTF = param1;
         this.recalcTFScreenParameters();
         this.forceUpdate();
      }
      
      public function updateSizeIndex(param1:int) : void
      {
         this._sizeIndex = param1;
         this.recalcTFScreenParameters();
         this.forceUpdate();
      }
      
      public function suspend(param1:Boolean) : void
      {
         this._isSuspended = param1;
         this.validateState();
      }
      
      public function validateLabel() : void
      {
         this.validateState();
      }
      
      private function validateState() : void
      {
         if(!this._isSuspended && this._entryRef.isVehicleLabelVisible)
         {
            this._timer.start();
         }
         else
         {
            this.stopTimer();
         }
         this.forceUpdate();
      }
      
      private function stopTimer() : void
      {
         this._timer.stop();
         this.__prevEntityX = 0;
         this.__prevEntityY = 0;
      }
      
      public function dispose() : void
      {
         this._timer.removeEventListener(TimerEvent.TIMER,this.onTimerHandler);
         this.stopTimer();
         this._timer = null;
         this._currentTF = null;
         this._entryRef = null;
      }
      
      public function forceUpdate() : void
      {
         this.update(true);
      }
      
      private function onTimerHandler(param1:TimerEvent) : void
      {
         this.update();
      }
      
      private function update(param1:Boolean = false) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(!this._entryRef.isVehicleLabelVisible)
         {
            return;
         }
         if(param1 || this.__prevEntityX != this._entryRef.x || this.__prevEntityY != this._entryRef.y)
         {
            this.__prevEntityX = this._entryRef.x;
            this.__prevEntityY = this._entryRef.y;
            _loc2_ = this._entryRef.hpCircle.visible;
            if(_loc2_)
            {
               _loc3_ = this._hpOffsetX;
               _loc4_ = this._hpOffsetY;
            }
            else
            {
               _loc3_ = this._initialOffsetX;
               _loc4_ = this._initialOffsetY;
            }
            _loc5_ = this._currentTF.width;
            if(!this._isSuspended && this._entryRef.x + this._tfWidthOnScreen + _loc3_ > this.bounds.x)
            {
               this._currentTF.x = -(_loc5_ + _loc3_);
            }
            else
            {
               this._currentTF.x = _loc3_;
            }
            _loc6_ = this._currentTF.height;
            if(!this._isSuspended && this._entryRef.y + this._tfHeightOnScreen + _loc4_ > this.bounds.y)
            {
               this._currentTF.y = -_loc6_ + OFFSET_Y_BETWEEN_TEXT_AND_BORDER;
            }
            else if(!this._isSuspended && this._entryRef.y < -this.bounds.y - HP_OFFSET_Y)
            {
               this._currentTF.y = this._initialOffsetY;
            }
            else
            {
               this._currentTF.y = _loc4_;
            }
         }
      }
      
      private function recalcTFScreenParameters() : void
      {
         var _loc1_:Number = this._currentTF.width;
         var _loc2_:Number = this._currentTF.height;
         var _loc3_:Number = MinimapSizeConst.ENTRY_SCALES[this._sizeIndex];
         var _loc4_:Number = MinimapSizeConst.ENTRY_CONTR_SCALES[this._sizeIndex];
         this._tfWidthOnScreen = _loc1_;
         this._tfWidthOnScreen *= _loc4_;
         this._tfWidthOnScreen /= _loc3_;
         this._tfHeightOnScreen = _loc2_;
         this._tfHeightOnScreen *= _loc4_;
         this._tfHeightOnScreen /= _loc3_;
      }
   }
}
