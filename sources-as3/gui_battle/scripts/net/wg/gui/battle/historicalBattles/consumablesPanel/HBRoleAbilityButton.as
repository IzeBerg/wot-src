package net.wg.gui.battle.historicalBattles.consumablesPanel
{
   import flash.events.Event;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.historicalBattles.consumablesPanel.events.HBProgressBarEvent;
   
   public class HBRoleAbilityButton extends HBAbilityButton
   {
      
      private static const INV_PROGRESS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const PROGRESS_MIN_DIFF:Number = 0.05;
       
      
      public var progress:HBProgressBar = null;
      
      private var _progress:Number = 0;
      
      public function HBRoleAbilityButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.progress.addEventListener(HBProgressBarEvent.PROGRESS_COMPLETED,this.onProgressCompletedHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._progress > 0 && isInvalid(INV_PROGRESS))
         {
            this.progress.setProgress(this._progress);
         }
      }
      
      override protected function onDispose() : void
      {
         this.progress.removeEventListener(HBProgressBarEvent.PROGRESS_COMPLETED,this.onProgressCompletedHandler);
         this.progress.dispose();
         this.progress = null;
         super.onDispose();
      }
      
      public function setProgress(param1:Number) : void
      {
         if(param1 <= 0 || param1 < 1 && param1 - this._progress < PROGRESS_MIN_DIFF)
         {
            return;
         }
         this._progress = param1;
         invalidate(INV_PROGRESS);
      }
      
      private function onProgressCompletedHandler(param1:Event) : void
      {
         this.progress.visible = false;
      }
   }
}
