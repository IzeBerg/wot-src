package net.wg.gui.battle.eventBattle.views.minimap.entries
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.EventGeneratorProgressCircle;
   import net.wg.gui.battle.views.staticMarkers.eventBattle.ScaleAnimation;
   
   public class EventGeneratorMinimapEntry extends EventIndexedMinimapEntry
   {
      
      private static const HIGHLIGHT_SCALE:Number = 0.65;
       
      
      public var progressCircle:EventGeneratorProgressCircle = null;
      
      public var highlightAnimation:MovieClip = null;
      
      public function EventGeneratorMinimapEntry()
      {
         super();
         if(this.highlightAnimation is ScaleAnimation)
         {
            (this.highlightAnimation as ScaleAnimation).setScale(HIGHLIGHT_SCALE);
         }
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
      
      public function resetGeneratorMarker() : void
      {
         this.progressCircle.resetGenerator();
      }
      
      public function playAnimation() : void
      {
         if(this.highlightAnimation is ScaleAnimation)
         {
            (this.highlightAnimation as ScaleAnimation).playAnimation();
         }
      }
   }
}
