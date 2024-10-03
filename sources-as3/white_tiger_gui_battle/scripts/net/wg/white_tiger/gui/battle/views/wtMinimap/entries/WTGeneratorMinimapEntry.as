package net.wg.white_tiger.gui.battle.views.wtMinimap.entries
{
   import flash.display.MovieClip;
   import net.wg.white_tiger.gui.battle.views.shared.GeneratorProgressCircle;
   import net.wg.white_tiger.gui.battle.views.staticMarkers.ScaleAnimation;
   
   public class WTGeneratorMinimapEntry extends WTIndexedMinimapEntry
   {
      
      private static const HIGHLIGHT_SCALE:Number = 0.65;
       
      
      public var progressCircle:GeneratorProgressCircle = null;
      
      public var highlightAnimation:MovieClip = null;
      
      public function WTGeneratorMinimapEntry()
      {
         super();
         if(this.highlightAnimation is ScaleAnimation)
         {
            (this.highlightAnimation as ScaleAnimation).setScale(HIGHLIGHT_SCALE);
         }
      }
      
      public function playAnimation() : void
      {
         if(this.highlightAnimation is ScaleAnimation)
         {
            (this.highlightAnimation as ScaleAnimation).playAnimation();
         }
      }
      
      public function resetGeneratorMarker() : void
      {
         this.progressCircle.resetGenerator();
      }
      
      public function setAlpha(param1:Number) : void
      {
         alpha = param1;
      }
      
      public function setEntityIndex(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               textField.text = "A";
               break;
            case 2:
               textField.text = "B";
               break;
            case 3:
               textField.text = "C";
         }
      }
      
      public function setGeneratorProgress(param1:Number) : void
      {
         this.progressCircle.updateProgress(param1);
      }
   }
}
