package net.wg.gui.lobby.manualChapter.controls
{
   import flash.display.MovieClip;
   
   public class DescriptionContainer extends TextContainer
   {
       
      
      public var dividerMask:MovieClip;
      
      public var divider:MovieClip;
      
      public function DescriptionContainer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.divider = null;
         this.dividerMask = null;
         super.onDispose();
      }
   }
}
