package net.wg.gui.battle.historicalBattles.timer.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TimerMessage extends MovieClip implements IDisposable
   {
      
      private static const LABEL_INTRO:String = "intro";
      
      private static const LABEL_OUTRO:String = "outro";
       
      
      public var timerTextMc:AnimatedTextContainer = null;
      
      private var _disposed:Boolean = false;
      
      public function TimerMessage()
      {
         super();
      }
      
      public function hideMessage() : void
      {
         gotoAndPlay(LABEL_OUTRO);
      }
      
      public function showMessage(param1:String) : void
      {
         gotoAndPlay(LABEL_INTRO);
         if(this.timerTextMc)
         {
            this.timerTextMc.text = param1;
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.timerTextMc.dispose();
         this.timerTextMc = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
