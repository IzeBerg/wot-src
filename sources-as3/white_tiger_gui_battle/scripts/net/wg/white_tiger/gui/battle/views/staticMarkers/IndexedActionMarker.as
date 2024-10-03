package net.wg.white_tiger.gui.battle.views.staticMarkers
{
   import net.wg.gui.battle.views.staticMarkers.location.LocationActionMarker;
   
   public class IndexedActionMarker extends LocationActionMarker
   {
      
      private static const NORMAL_SCALE:Number = 1;
      
      private static const OUT_SCALE:Number = 0.5;
      
      private static const OUT_SCALE_DIFF:Number = 0.4;
      
      private static const OUT_MAX_DISTANCE:Number = 400;
       
      
      private var _outOfScreen:Boolean = false;
      
      private var _distance:Number = 0.0;
      
      public function IndexedActionMarker()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(locationTopElement is ScaleContainer)
         {
            (locationTopElement as ScaleContainer).dispose();
         }
         if(highlightAnimation is ScaleAnimation)
         {
            (highlightAnimation as ScaleAnimation).dispose();
         }
         super.onDispose();
      }
      
      public function playAnimation() : void
      {
         if(highlightAnimation is ScaleAnimation)
         {
            (highlightAnimation as ScaleAnimation).playAnimation();
         }
      }
      
      public function playRepeatingAnimation() : void
      {
         if(highlightAnimation is ScaleAnimation)
         {
            (highlightAnimation as ScaleAnimation).playRepeatingAnimation();
         }
      }
      
      public function resetGeneratorProgress() : void
      {
         var _loc1_:IndexedContent = this.getContent();
         if(_loc1_ is GeneratorContent)
         {
            (_loc1_ as GeneratorContent).resetGeneratorTimer();
         }
      }
      
      public function setAlpha(param1:Number) : void
      {
         var _loc2_:IndexedContent = this.getContent();
         if(_loc2_)
         {
            _loc2_.setAlpha(param1);
         }
      }
      
      public function setDistance(param1:Number) : void
      {
         this._distance = param1;
         this.updateScale();
      }
      
      public function setEntityIndex(param1:int) : void
      {
         var _loc2_:IndexedContent = this.getContent();
         if(_loc2_ is GeneratorContent)
         {
            (_loc2_ as GeneratorContent).setIndex(param1);
         }
      }
      
      public function setGeneratorMarkerProgress(param1:Number) : void
      {
         var _loc2_:IndexedContent = this.getContent();
         if(_loc2_ is GeneratorContent)
         {
            (_loc2_ as GeneratorContent).updateGeneratorTimer(param1);
         }
      }
      
      public function setHoverVisibility(param1:Boolean) : void
      {
         var _loc2_:IndexedContent = this.getContent();
         if(_loc2_ is GeneratorContent)
         {
            (_loc2_ as GeneratorContent).setHoverVisibility(param1);
         }
      }
      
      public function setOutOfScreen(param1:Boolean) : void
      {
         this._outOfScreen = param1;
         this.updateScale();
      }
      
      public function stopAnimation() : void
      {
         if(highlightAnimation is ScaleAnimation)
         {
            (highlightAnimation as ScaleAnimation).stopAnimation();
         }
      }
      
      protected function getContent() : IndexedContent
      {
         if(locationTopElement is ScaleContainer)
         {
            return (locationTopElement as ScaleContainer).content;
         }
         return null;
      }
      
      private function updateScale() : void
      {
         var _loc1_:Number = NaN;
         if(this._outOfScreen)
         {
            _loc1_ = OUT_SCALE;
            if(this._distance < OUT_MAX_DISTANCE)
            {
               _loc1_ += (1 - this._distance / OUT_MAX_DISTANCE) * OUT_SCALE_DIFF;
            }
         }
         else
         {
            _loc1_ = NORMAL_SCALE;
         }
         if(locationTopElement is ScaleContainer)
         {
            (locationTopElement as ScaleContainer).setScale(_loc1_);
         }
         if(highlightAnimation is ScaleAnimation)
         {
            (highlightAnimation as ScaleAnimation).setScale(_loc1_);
         }
      }
   }
}
