package net.wg.gui.lobby.hangar
{
   import fl.transitions.easing.Regular;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class HangarRosterSwitchAnimator extends EventDispatcher implements IDisposable
   {
      
      private static const ANIM_DURATION:int = 300;
      
      private static const STAGE_MOUSE_ENABLED_TIMEOUT:int = 1000;
       
      
      private var _hangar:Hangar = null;
      
      private var _alphaAnimatedParts:Vector.<DisplayObject> = null;
      
      private var _tween:Tween;
      
      private var _percents:Number = 0;
      
      private var _isShown:Boolean = false;
      
      private var _appStage:Stage;
      
      private var _isDisposed:Boolean = false;
      
      public function HangarRosterSwitchAnimator(param1:Hangar, param2:Vector.<DisplayObject>)
      {
         this._appStage = App.stage;
         super();
         this._hangar = param1;
         this._tween = new Tween(ANIM_DURATION,this,{"percents":1},{"ease":Regular.easeOut});
         this._tween.onComplete = this.onAnimationComplete;
         this._tween.paused = true;
         this._alphaAnimatedParts = this.validateItems(param2);
      }
      
      public final function dispose() : void
      {
         App.utils.scheduler.cancelTask(this.stageMouseChildrenSetEnabled);
         this.stageMouseChildrenSetEnabled();
         this._tween.dispose();
         this._tween = null;
         this._hangar = null;
         this._alphaAnimatedParts = null;
         this._appStage = null;
         this._isDisposed = true;
      }
      
      public function playHideAnimation() : void
      {
         this.percents = 0;
         this._tween.reset();
         this._tween.paused = false;
         this._isShown = false;
         this._hangar.mouseEnabled = false;
         App.utils.scheduler.scheduleTask(this.stageMouseChildrenSetEnabled,STAGE_MOUSE_ENABLED_TIMEOUT);
         this._appStage.mouseChildren = false;
      }
      
      private function stageMouseChildrenSetEnabled() : void
      {
         this._appStage.mouseChildren = true;
      }
      
      public function playShowAnimation() : void
      {
         this.percents = 0;
         this._isShown = true;
         this._tween.reset();
         this._tween.paused = false;
         this.updateAlpha();
      }
      
      private function onAnimationComplete() : void
      {
         if(this._isShown)
         {
            this._hangar.mouseChildren = true;
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function validateItems(param1:Vector.<DisplayObject>) : Vector.<DisplayObject>
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         for each(_loc3_ in param1)
         {
            if(_loc3_)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function updateAlpha() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:Number = 0;
         if(this._isShown)
         {
            _loc1_ = this.percents;
         }
         else
         {
            _loc1_ = 1 - this.percents;
         }
         for each(_loc2_ in this._alphaAnimatedParts)
         {
            _loc2_.alpha = _loc1_;
         }
      }
      
      public function get percents() : Number
      {
         return this._percents;
      }
      
      public function set percents(param1:Number) : void
      {
         this._percents = param1;
         this.updateAlpha();
      }
      
      private function onMakeHangarVisible(param1:Event) : void
      {
         this._hangar.setAnimatorVisibility(true);
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
