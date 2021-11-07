package net.wg.gui.battle.tutorial.views.tutorial.components.progressBar
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleProgressItemLine extends MovieClip implements IDisposable
   {
      
      public static const START_FRAME_LABEL:String = "start";
       
      
      public var failLine:Sprite = null;
      
      public var doneLine:Sprite = null;
      
      private var _isDisposed:Boolean = false;
      
      private var _currentPhase:int = -1;
      
      public function BattleProgressItemLine()
      {
         super();
         this.reset();
      }
      
      public function reset() : void
      {
         this.failLine.visible = false;
         this.doneLine.visible = false;
      }
      
      public function setPhase(param1:int) : void
      {
         if(this._currentPhase != param1)
         {
            this._currentPhase = param1;
            this.failLine.visible = this._currentPhase == BattleTutorialProgressBar.PHASE_FAIL_ID;
            this.doneLine.visible = this._currentPhase == BattleTutorialProgressBar.PHASE_DONE_ID;
            gotoAndPlay(START_FRAME_LABEL);
         }
      }
      
      public final function dispose() : void
      {
         App.utils.asserter.assert(!this._isDisposed,"BattleProgressItemLine already disposed!");
         this._isDisposed = true;
         this.failLine = null;
         this.doneLine = null;
      }
   }
}
