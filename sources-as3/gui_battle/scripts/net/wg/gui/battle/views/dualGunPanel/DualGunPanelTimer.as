package net.wg.gui.battle.views.dualGunPanel
{
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import net.wg.data.constants.Time;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DualGunPanelTimer extends MovieClip implements IDisposable
   {
      
      private static const FRACTIONAL_FORMAT_CMD:String = "WG.getFractionalFormat";
      
      public static const STYLE_DEBUFF:String = "debuff";
      
      public static const STYLE_CRITICAL:String = "critical";
      
      public static const STYLE_CHARGE:String = "charge";
      
      public static const STYLE_PRIMARY_LOADING:String = "primaryLoading";
      
      public static const STYLE_SECONDARY_LOADING:String = "secondaryLoading";
      
      public static const STYLE_IDLE:String = "idle";
       
      
      public var timerReloading:TextField = null;
      
      public var timerAutoload:TextField = null;
      
      public var timerStun:TextField = null;
      
      public var timerIdle:TextField = null;
      
      public var totalTimer:TextField = null;
      
      private var _mathAbs:Function = null;
      
      private var _timersMap:Object;
      
      private var _currentTimer:TextField;
      
      public function DualGunPanelTimer()
      {
         super();
         this._mathAbs = Math.abs;
         this._currentTimer = this.timerIdle;
         this._timersMap = {};
         this._timersMap[STYLE_DEBUFF] = this.timerReloading;
         this._timersMap[STYLE_CHARGE] = this.timerAutoload;
         this._timersMap[STYLE_PRIMARY_LOADING] = this.timerReloading;
         this._timersMap[STYLE_SECONDARY_LOADING] = this.timerAutoload;
         this._timersMap[STYLE_IDLE] = this.timerIdle;
         this._timersMap[STYLE_CRITICAL] = this.timerStun;
      }
      
      public final function dispose() : void
      {
         App.utils.data.cleanupDynamicObject(this._timersMap);
         this.timerReloading = null;
         this.timerAutoload = null;
         this.timerIdle = null;
         this.timerStun = null;
         this._mathAbs = null;
         this._currentTimer = null;
         this.totalTimer = null;
      }
      
      public function setTextStyle(param1:String) : void
      {
         var _loc2_:TextField = this._timersMap[param1];
         if(_loc2_)
         {
            this.switchCurrentTimers(_loc2_);
         }
      }
      
      public function updateTimerValue(param1:Number) : void
      {
         this._currentTimer.text = this.convertTimerValue(param1);
      }
      
      public function updateTotalTime(param1:Number) : void
      {
         this.totalTimer.text = this.convertTimerValue(param1);
      }
      
      private function switchCurrentTimers(param1:TextField) : void
      {
         this._currentTimer.visible = false;
         param1.text = this._currentTimer.text;
         this._currentTimer = param1;
         this._currentTimer.visible = true;
      }
      
      private function convertTimerValue(param1:Number) : String
      {
         var _loc2_:Number = param1 / Time.MILLISECOND_IN_SECOND;
         var _loc3_:String = ExternalInterface.call.apply(this,[FRACTIONAL_FORMAT_CMD,this._mathAbs.call(null,_loc2_)]);
         return _loc3_.slice(0,_loc3_.length - 1);
      }
   }
}
