package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import net.wg.gui.events.CooldownEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CooldownAnimationController extends UIComponentEx
   {
      
      private static const DELTA_OF_PIXELS_FOR_ANIMATION:int = 47;
      
      private static const VERTICAL_PADDING:int = 5;
       
      
      public var maskMc:MovieClip;
      
      private var _cooldownPeriod:Number;
      
      private var _deltaPixels:int = 0;
      
      private var _isDischarging:Boolean = false;
      
      public function CooldownAnimationController()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.updateAnimation);
         super.onDispose();
      }
      
      public function startCooldown(param1:Number) : void
      {
         App.utils.scheduler.cancelTask(this.updateAnimation);
         this._cooldownPeriod = param1 / DELTA_OF_PIXELS_FOR_ANIMATION;
         this._deltaPixels = !!this._isDischarging ? int(DELTA_OF_PIXELS_FOR_ANIMATION) : int(0);
         this.maskMc.height = Math.round(VERTICAL_PADDING + this._deltaPixels);
         App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
      }
      
      public function clearCooldown() : void
      {
         App.utils.scheduler.cancelTask(this.updateAnimation);
      }
      
      public function restartCooldownFromCurrentProgress(param1:Number) : void
      {
         App.utils.scheduler.cancelTask(this.updateAnimation);
         var _loc2_:int = !!this._isDischarging ? int(this._deltaPixels) : int(DELTA_OF_PIXELS_FOR_ANIMATION - this._deltaPixels);
         this._cooldownPeriod = param1 / _loc2_;
         this.maskMc.height = Math.round(VERTICAL_PADDING + this._deltaPixels);
         App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
      }
      
      public function setPositionAsPercent(param1:Number) : void
      {
         App.utils.scheduler.cancelTask(this.updateAnimation);
         var _loc2_:Number = !!this._isDischarging ? Number((100 - param1) / 100) : Number(param1 / 100);
         this._deltaPixels = Math.round(DELTA_OF_PIXELS_FOR_ANIMATION * _loc2_);
         this.maskMc.height = Math.round(VERTICAL_PADDING + this._deltaPixels);
      }
      
      private function updateAnimation() : void
      {
         if(this._isDischarging && this._deltaPixels > 0)
         {
            --this._deltaPixels;
            this.maskMc.height = Math.round(VERTICAL_PADDING + this._deltaPixels);
            App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
         }
         else if(!this._isDischarging && this._deltaPixels < DELTA_OF_PIXELS_FOR_ANIMATION)
         {
            ++this._deltaPixels;
            this.maskMc.height = Math.round(VERTICAL_PADDING + this._deltaPixels);
            App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
         }
         else
         {
            dispatchEvent(new CooldownEvent(CooldownEvent.FINISHED));
         }
      }
      
      public function get isDischarging() : Boolean
      {
         return this._isDischarging;
      }
      
      public function set isDischarging(param1:Boolean) : void
      {
         this._isDischarging = param1;
      }
   }
}
