package net.wg.gui.battle.views.questProgress.animated
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimStepProgress extends Sprite implements IDisposable
   {
       
      
      public var progressValue:MovieClip = null;
      
      public function AnimStepProgress()
      {
         super();
         this.progressValue.gotoAndStop(1);
      }
      
      public final function dispose() : void
      {
         this.progressValue = null;
      }
      
      public function setProgress(param1:int) : void
      {
         this.progressValue.gotoAndStop(param1);
      }
   }
}
