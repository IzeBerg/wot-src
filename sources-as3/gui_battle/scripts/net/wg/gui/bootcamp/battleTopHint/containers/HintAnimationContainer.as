package net.wg.gui.bootcamp.battleTopHint.containers
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.battleTopHint.constants.HINT_LABELS;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintAnimationContainer extends MovieClip
   {
       
      
      public var hintAnimation:MovieClip = null;
      
      private var _currentHint:MovieClip = null;
      
      public function HintAnimationContainer()
      {
         super();
      }
      
      public function closeHint() : void
      {
         this.disposeHint();
         gotoAndStop(1);
      }
      
      public final function dispose() : void
      {
         this.disposeHint();
         this.hintAnimation = null;
         this._currentHint = null;
      }
      
      public function hideHint() : void
      {
         if(this.hintAnimation)
         {
            if(this.hintAnimation.currentLabel == HINT_LABELS.LOOP_LABEL)
            {
               this.hintAnimation.gotoAndPlay(HINT_LABELS.OUT_SHOW_LABEL);
            }
            else
            {
               this.hintAnimation.gotoAndPlay(HINT_LABELS.OUT_COMPLETE_LABEL);
            }
         }
      }
      
      public function showHint(param1:int, param2:String) : void
      {
         if(currentFrame != param1)
         {
            this.disposeHint();
            gotoAndStop(param1);
            this._currentHint = this.hintAnimation;
         }
         if(this._currentHint)
         {
            this._currentHint.gotoAndPlay(param2);
         }
      }
      
      private function disposeHint() : void
      {
         var _loc1_:IDisposable = this.hintAnimation as IDisposable;
         if(_loc1_)
         {
            _loc1_.dispose();
         }
      }
   }
}
