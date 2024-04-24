package net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.blocks
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.ProgressBarAnim;
   
   public class QuestProgressBar extends ProgressBarAnim
   {
       
      
      public var glow:Sprite = null;
      
      public function QuestProgressBar()
      {
         super();
      }
      
      override protected function updatePosition() : void
      {
         var _loc1_:int = _value / _onePercent * _onePercentWidth ^ 0;
         var _loc2_:Boolean = _value >= _maximum;
         if(progressBarDone != null && progressBarInProgress != null)
         {
            progressBarInProgress.visible = !_loc2_ && _value > 0;
            progressBarDone.visible = _loc2_;
            progressMask.width = _loc1_ ^ 0;
         }
         this.glow.visible = progressBarInProgress.visible;
         this.glow.x = progressMask.x + progressMask.width;
      }
      
      override protected function onDispose() : void
      {
         this.glow = null;
         super.onDispose();
      }
   }
}
