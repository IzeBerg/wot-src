package net.wg.gui.battle.views.minimap.components.entries.battleRoyale
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimatedItemWithFinishCallback extends MovieClip implements IDisposable
   {
       
      
      private var _callback:Function = null;
      
      private var _totalFrames:int = 1;
      
      private var _disposed:Boolean = false;
      
      public function AnimatedItemWithFinishCallback()
      {
         super();
         this.init();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         if(this._callback != null)
         {
            this.resetCallback();
         }
         if(this._totalFrames > 1)
         {
            addFrameScript(this._totalFrames - 1,null);
         }
      }
      
      public function resetCallback() : void
      {
         this._callback = null;
      }
      
      public function setFlashTweenFinishCallback(param1:Function) : void
      {
         if(this._callback == null && this._callback != param1)
         {
            this._callback = param1;
            this._totalFrames = totalFrames;
            addFrameScript(this._totalFrames - 1,this.onFlashAnimationFinished);
         }
         else
         {
            DebugUtils.LOG_WARNING("AnimatedItemWithFinishCallback: attempt to remove callback without reset");
         }
      }
      
      protected function init() : void
      {
         stop();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      protected function onProgramAnimationFinished() : void
      {
         if(this._callback != null)
         {
            this._callback();
         }
      }
      
      private function onFlashAnimationFinished() : void
      {
         stop();
         if(this._callback != null)
         {
            this._callback();
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         if(this._callback != null)
         {
            DebugUtils.LOG_ERROR("AnimatedItemWithFinishCallback: \"dispose\" must be called");
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
