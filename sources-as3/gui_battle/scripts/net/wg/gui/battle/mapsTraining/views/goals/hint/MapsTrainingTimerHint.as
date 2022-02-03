package net.wg.gui.battle.mapsTraining.views.goals.hint
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MapsTrainingTimerHint extends Sprite implements IDisposable
   {
       
      
      public var description:TextField = null;
      
      public var timer:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function MapsTrainingTimerHint()
      {
         super();
      }
      
      public function show(param1:String, param2:String) : void
      {
         this.description.text = param2;
         this.timer.gotoAndStop(param1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.description = null;
         this.timer = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
