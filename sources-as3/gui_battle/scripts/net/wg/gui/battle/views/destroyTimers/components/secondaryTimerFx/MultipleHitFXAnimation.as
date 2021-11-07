package net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MultipleHitFXAnimation extends SecondaryTimerFXAnimation implements IDisposable
   {
       
      
      public var timer:MovieClip;
      
      public var timerFx:MovieClip;
      
      private var _timerLabel:TextField;
      
      private var _flare:MovieClip;
      
      public function MultipleHitFXAnimation()
      {
         super();
         this._timerLabel = this.timer.label;
         this._flare = this.timerFx.flare;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.timer = null;
         this.timerFx = null;
         this._timerLabel = null;
         this._flare = null;
      }
      
      public function updateLabelPosition(param1:int) : void
      {
         this._timerLabel.y = param1;
         this._flare.y = param1;
      }
      
      public function updateText(param1:String) : void
      {
         this._timerLabel.text = param1;
      }
      
      public function setLabelVisibility(param1:Boolean) : void
      {
         this._timerLabel.visible = this._flare.visible = param1;
      }
   }
}
