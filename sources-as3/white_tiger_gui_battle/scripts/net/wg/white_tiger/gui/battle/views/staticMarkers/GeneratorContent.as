package net.wg.white_tiger.gui.battle.views.staticMarkers
{
   import flash.display.MovieClip;
   import net.wg.white_tiger.gui.battle.views.shared.GeneratorProgressCircle;
   
   public class GeneratorContent extends IndexedContent
   {
       
      
      public var progressCircle:GeneratorProgressCircle = null;
      
      public var hoverIndicator:MovieClip = null;
      
      public function GeneratorContent()
      {
         super();
         this.progressCircle.visible = false;
         this.hoverIndicator.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.progressCircle.dispose();
         this.progressCircle = null;
         this.hoverIndicator = null;
         super.onDispose();
      }
      
      public function resetGeneratorTimer() : void
      {
         icon.visible = true;
         this.progressCircle.visible = false;
      }
      
      public function setHoverVisibility(param1:Boolean) : void
      {
         this.hoverIndicator.visible = param1;
      }
      
      public function setIndex(param1:int) : void
      {
         var _loc2_:String = null;
         if(indexField != null)
         {
            _loc2_ = "";
            switch(param1)
            {
               case 1:
                  _loc2_ = "A";
                  break;
               case 2:
                  _loc2_ = "B";
                  break;
               case 3:
                  _loc2_ = "C";
            }
            indexField.text = _loc2_;
         }
      }
      
      public function updateGeneratorTimer(param1:Number) : void
      {
         if(icon.visible)
         {
            icon.visible = false;
            this.progressCircle.visible = true;
         }
         if(this.progressCircle.visible)
         {
            this.progressCircle.updateProgress(param1);
         }
      }
   }
}
