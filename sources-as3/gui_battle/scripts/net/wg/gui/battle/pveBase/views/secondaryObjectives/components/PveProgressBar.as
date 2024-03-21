package net.wg.gui.battle.pveBase.views.secondaryObjectives.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PveProgressBar extends MovieClip implements IDisposable
   {
      
      private static const START_ANIM_FRAME_LABEL:String = "startAnim";
       
      
      public var barMask:MovieClip = null;
      
      public var barBrigthline:MovieClip = null;
      
      public var barOrangeline:MovieClip = null;
      
      private var _prevProgressBarValue:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function PveProgressBar()
      {
         super();
      }
      
      public function setProgressBarValue(param1:int) : void
      {
         if(param1 > this._prevProgressBarValue)
         {
            this.barMask.gotoAndStop(this._prevProgressBarValue);
            this.barBrigthline.gotoAndStop(param1);
         }
         else
         {
            this.barMask.gotoAndStop(param1);
            this.barBrigthline.gotoAndStop(this._prevProgressBarValue);
         }
         this.barOrangeline.gotoAndStop(param1);
         this.barBrigthline.anim.gotoAndPlay(START_ANIM_FRAME_LABEL);
         this._prevProgressBarValue = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.barMask = null;
         this.barBrigthline = null;
         this.barOrangeline = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
