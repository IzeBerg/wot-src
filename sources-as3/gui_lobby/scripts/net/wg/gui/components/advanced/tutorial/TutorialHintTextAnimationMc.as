package net.wg.gui.components.advanced.tutorial
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialHintTextAnimationMc extends MovieClip implements IDisposable
   {
       
      
      public var hintTextMc:TutorialHintText = null;
      
      public function TutorialHintTextAnimationMc()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.hintTextMc.dispose();
         this.hintTextMc = null;
      }
   }
}
