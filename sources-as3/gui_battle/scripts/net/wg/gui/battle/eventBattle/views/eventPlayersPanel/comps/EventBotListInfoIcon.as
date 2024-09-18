package net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.EventGeneratorProgressCircle;
   
   public class EventBotListInfoIcon extends BattleUIComponent
   {
       
      
      public var generatorTimer:EventGeneratorProgressCircle = null;
      
      public function EventBotListInfoIcon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this.generatorTimer)
         {
            this.generatorTimer.dispose();
            this.generatorTimer = null;
         }
         super.onDispose();
      }
      
      public function updateCaptureTimer(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.generatorTimer.updateProgress(param2);
      }
      
      public function setIsDestroyed() : void
      {
         if(this.generatorTimer != null)
         {
            this.generatorTimer.setGeneratorOffline();
         }
      }
      
      public function resetIconTimer() : void
      {
         if(this.generatorTimer != null)
         {
            this.generatorTimer.resetGenerator();
         }
      }
      
      public function lockGenerator(param1:Boolean) : void
      {
         if(this.generatorTimer != null)
         {
            this.generatorTimer.setGeneratorLocked(param1);
         }
      }
   }
}
