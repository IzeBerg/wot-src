package net.wg.gui.battle.eventBattle.views.bossWidget
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EventProgressBar extends BattleUIComponent
   {
       
      
      protected var progressValue:int = 0;
      
      public function EventProgressBar()
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
