package net.wg.gui.lobby.profile.pages
{
   import fl.transitions.easing.Strong;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.motion.Tween;
   
   public class SectionsShowAnimationManager implements IDisposable
   {
      
      private static const ANIM_SPEED:uint = 1000;
       
      
      private var _target:UIComponent;
      
      private var tweenManager:ExcludeTweenManager;
      
      private var isTargetInitialized:Boolean = false;
      
      private var isInvokingInNextFrame:Boolean = false;
      
      public function SectionsShowAnimationManager(param1:UIComponent)
      {
         this.tweenManager = new ExcludeTweenManager();
         super();
         this._target = param1;
         this._target.alpha = 0;
      }
      
      public function play() : void
      {
         if(this.isTargetInitialized)
         {
            this.applyAnimation();
         }
         else if(!this.isInvokingInNextFrame)
         {
            this.isInvokingInNextFrame = true;
            App.utils.scheduler.scheduleOnNextFrame(this.applyAnimation);
         }
      }
      
      private function applyAnimation() : void
      {
         this.isTargetInitialized = true;
         var _loc1_:Tween = this.tweenManager.registerAndLaunch(ANIM_SPEED,this._target,{"alpha":1},{
            "ease":Strong.easeOut,
            "onComplete":this.onTweenComplete
         });
         _loc1_.fastTransform = false;
      }
      
      private function onTweenComplete(param1:Tween) : void
      {
         this.tweenManager.unregister(param1);
      }
      
      public function stop() : void
      {
         this._target.alpha = 0;
         this.tweenManager.unregisterAll();
         App.utils.scheduler.cancelTask(this.applyAnimation);
      }
      
      public function dispose() : void
      {
         this._target = null;
         App.utils.scheduler.cancelTask(this.applyAnimation);
         if(this.tweenManager)
         {
            this.tweenManager.dispose();
            this.tweenManager = null;
         }
      }
   }
}
