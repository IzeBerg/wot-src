package net.wg.white_tiger.gui.battle.views.wtBossWidget.components
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class ProgressBar extends BattleUIComponent
   {
       
      
      protected var progressValue:int = 0;
      
      public function ProgressBar()
      {
         super();
      }
      
      public static function getProgress(param1:int, param2:int) : int
      {
         return 100 * (param1 > 0 ? param2 / param1 : 1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.gotoAndStop(this.totalFrames);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.gotoAndStop(this.progressValue);
         }
      }
      
      public function set value(param1:int) : void
      {
         if(this.progressValue == param1)
         {
            return;
         }
         this.progressValue = param1;
         invalidateData();
      }
   }
}
