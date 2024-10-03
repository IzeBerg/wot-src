package net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.components.Generator;
   
   public class BotListInfoIcon extends BattleUIComponent
   {
       
      
      public var generatorTimer:Generator = null;
      
      public function BotListInfoIcon()
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
      
      public function resetIconTimer() : void
      {
         if(this.generatorTimer != null)
         {
            this.generatorTimer.resetGeneratorTimer();
         }
      }
      
      public function setIconOnline() : void
      {
         if(this.generatorTimer != null)
         {
            this.generatorTimer.setGeneratorOnline();
         }
      }
      
      public function setIsDestroyed() : void
      {
         if(this.generatorTimer != null)
         {
            this.generatorTimer.setGeneratorOffline();
         }
      }
      
      public function updateCaptureTimer(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.generatorTimer.updateCaptureTimer(param1,param2,param3,param4);
      }
   }
}
