package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import flash.display.MovieClip;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.constants.GunMarkerConsts;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class GunMarkerMixing extends SimpleContainer implements IGunMarkerMixing
   {
       
      
      public var dotsMc:MovieClip;
      
      public function GunMarkerMixing()
      {
         super();
         this.setThickness(GunMarkerDispersionCircle.THIN);
      }
      
      override protected function onDispose() : void
      {
         this.dotsMc = null;
         super.onDispose();
      }
      
      public function setAlpha(param1:Number) : void
      {
         alpha = param1;
      }
      
      public function setReloadingAsPercent(param1:Number, param2:Boolean = false) : void
      {
         var _loc3_:int = GunMarkerConsts.MIXING_PROGRESS_TOTAL_FRAMES_COUNT * param1;
         gotoAndStop(_loc3_);
      }
      
      public function setReloadingState(param1:String) : void
      {
      }
      
      public function setThickness(param1:String) : void
      {
         this.dotsMc.gotoAndStop(param1);
      }
   }
}
