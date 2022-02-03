package net.wg.gui.battle.views.questProgress.animated
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimationRing extends MovieClip implements IDisposable
   {
      
      private static const READY_TO_MOVE_FRAME_LABEL:String = "readyToMove";
      
      private static const ANIM_START_FRAME:int = 1;
       
      
      private var _onAnimStartCallback:Function = null;
      
      private var _scriptFrame:int = 1;
      
      private var _disposed:Boolean = false;
      
      public function AnimationRing()
      {
         super();
         stop();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         addFrameScript(this._scriptFrame,null);
         this._onAnimStartCallback = null;
      }
      
      public function run(param1:Function) : void
      {
         var _loc4_:FrameLabel = null;
         this._onAnimStartCallback = param1;
         var _loc2_:Array = this.currentLabels;
         var _loc3_:int = _loc2_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_[_loc5_];
            if(_loc4_.name == READY_TO_MOVE_FRAME_LABEL)
            {
               this._scriptFrame = _loc4_.frame;
               addFrameScript(this._scriptFrame,this.onAnimationFinished);
               break;
            }
            _loc5_++;
         }
         gotoAndPlay(ANIM_START_FRAME);
      }
      
      private function onAnimationFinished() : void
      {
         this._onAnimStartCallback.call();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
