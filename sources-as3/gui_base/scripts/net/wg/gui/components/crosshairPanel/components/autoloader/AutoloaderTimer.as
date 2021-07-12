package net.wg.gui.components.crosshairPanel.components.autoloader
{
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class AutoloaderTimer extends MovieClip implements IDisposable
   {
      
      private static const FRACTIONAL_FORMAT_CMD:String = "WG.getFractionalFormat";
       
      
      public var timerReloading:TextField = null;
      
      public var timerAutoload:TextField = null;
      
      public var timerStun:TextField = null;
      
      public var timerIdle:TextField = null;
      
      private var _currentTimer:TextField = null;
      
      private var _mathAbs:Function = null;
      
      public function AutoloaderTimer()
      {
         super();
         this._currentTimer = this.timerIdle;
         this._mathAbs = Math.abs;
         TextFieldEx.setNoTranslate(this.timerReloading,true);
         TextFieldEx.setNoTranslate(this.timerAutoload,true);
         TextFieldEx.setNoTranslate(this.timerStun,true);
         TextFieldEx.setNoTranslate(this.timerIdle,true);
      }
      
      public function dispose() : void
      {
         this.timerReloading = null;
         this.timerAutoload = null;
         this.timerStun = null;
         this.timerIdle = null;
         this._currentTimer = null;
         this._mathAbs = null;
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
         this._currentTimer.text = _loc3_;
      }
      
      public function updateTimerColor(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
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
      
      private function switchCurrentTimers(param1:TextField) : void
      {
         this._currentTimer.visible = false;
         param1.text = this._currentTimer.text;
         this._currentTimer = param1;
         this._currentTimer.visible = true;
      }
   }
}
