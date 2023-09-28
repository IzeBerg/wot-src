package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class GunMarkerMixingWithoutProgress extends SimpleContainer implements IGunMarkerMixing
   {
      
      private static const STATE_VALIDATION:String = "state";
       
      
      private var _isInProgress:Boolean = false;
      
      public function GunMarkerMixingWithoutProgress()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(STATE_VALIDATION))
         {
            if(this._isInProgress)
            {
               gotoAndStop(1);
            }
            else
            {
               gotoAndStop(totalFrames);
            }
         }
      }
      
      public function setReloadingState(param1:String) : void
      {
         this._isInProgress = !(param1 == CrosshairConsts.RELOADING_ENDED || param1 == CrosshairConsts.RELOADING_END);
         invalidate(STATE_VALIDATION);
      }
      
      public function setReloadingAsPercent(param1:Number) : void
      {
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
   }
}
