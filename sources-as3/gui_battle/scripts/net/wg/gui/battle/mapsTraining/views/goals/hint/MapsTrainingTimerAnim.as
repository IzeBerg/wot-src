package net.wg.gui.battle.mapsTraining.views.goals.hint
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MapsTrainingTimerAnim extends MovieClip implements IDisposable
   {
      
      private static const LABEL_SHOW:String = "show";
      
      private static const LABEL_HIDE:String = "hide";
       
      
      public var hint:MapsTrainingTimerHint = null;
      
      private var _disposed:Boolean = false;
      
      public function MapsTrainingTimerAnim()
      {
         super();
      }
      
      public function show(param1:String, param2:String) : void
      {
         this.hint.show(param1,param2);
         gotoAndPlay(LABEL_SHOW);
      }
      
      public function hide() : void
      {
         if(currentFrame > 1)
         {
            gotoAndPlay(LABEL_HIDE);
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.hint.dispose();
         this.hint = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
