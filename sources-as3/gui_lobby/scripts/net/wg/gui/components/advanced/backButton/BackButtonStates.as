package net.wg.gui.components.advanced.backButton
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BackButtonStates extends MovieClip implements IDisposable
   {
       
      
      public var textMc:BackButtonText = null;
      
      public function BackButtonStates()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.textMc.dispose();
         this.textMc = null;
      }
   }
}
