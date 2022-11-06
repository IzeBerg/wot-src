package net.wg.gui.components.crosshairPanel.components.autoloader
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.external.ExternalInterface;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AutoloaderTimer extends MovieClip implements IDisposable
   {
      
      private static const FRACTIONAL_FORMAT_CMD:String = "WG.getFractionalFormat";
       
      
      public var timerReloading:AutoloaderTimerText = null;
      
      public var timerAutoload:AutoloaderTimerText = null;
      
      public var timerStun:AutoloaderTimerText = null;
      
      public var timerIdle:AutoloaderTimerText = null;
      
      public var reloadingBg:Sprite = null;
      
      private var _currentTimer:AutoloaderTimerText = null;
      
      private var _currentLabel:String = "";
      
      private var _mathAbs:Function = null;
      
      private var _disposed:Boolean = false;
      
      public function AutoloaderTimer()
      {
         super();
         this._currentTimer = this.timerIdle;
         this._mathAbs = Math.abs;
         this.timerReloading.noTranslateTextfield = true;
         this.timerAutoload.noTranslateTextfield = true;
         this.timerStun.noTranslateTextfield = true;
         this.timerIdle.noTranslateTextfield = true;
         this.reloadingBg.visible = false;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.timerReloading.dispose();
         this.timerReloading = null;
         this.timerAutoload.dispose();
         this.timerAutoload = null;
         this.timerStun.dispose();
         this.timerStun = null;
         this.timerIdle.dispose();
         this.timerIdle = null;
         this._currentTimer = null;
         this._mathAbs = null;
         this.reloadingBg = null;
      }
      
      public function updateTimer(param1:Number, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param2)
         {
            _loc4_ = ExternalInterface.call.apply(this,[FRACTIONAL_FORMAT_CMD,this._mathAbs.call(null,param1)]);
            _loc3_ = _loc4_.slice(0,_loc4_.length - 1);
         }
         else
         {
            _loc3_ = Values.EMPTY_STR;
         }
         this._currentLabel = _loc3_;
         this._currentTimer.label = this._currentLabel;
      }
      
      public function updateTimerColor(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         this.reloadingBg.visible = param1;
         if(param1)
         {
            this.switchCurrentTimers(this.timerReloading);
         }
         else if(param2)
         {
            this.switchCurrentTimers(this.timerStun);
         }
         else if(param3)
         {
            this.switchCurrentTimers(this.timerAutoload);
         }
         else
         {
            this.switchCurrentTimers(this.timerIdle);
         }
      }
      
      private function switchCurrentTimers(param1:AutoloaderTimerText) : void
      {
         this._currentTimer.visible = false;
         param1.label = this._currentLabel;
         this._currentTimer = param1;
         this._currentTimer.visible = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
