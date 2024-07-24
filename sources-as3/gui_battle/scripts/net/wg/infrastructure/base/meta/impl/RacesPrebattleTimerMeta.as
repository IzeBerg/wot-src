package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimer;
   
   public class RacesPrebattleTimerMeta extends PrebattleTimer
   {
       
      
      public var onFirstLight:Function;
      
      public var onLastLights:Function;
      
      public function RacesPrebattleTimerMeta()
      {
         super();
      }
      
      public function onFirstLightS() : void
      {
         App.utils.asserter.assertNotNull(this.onFirstLight,"onFirstLight" + Errors.CANT_NULL);
         this.onFirstLight();
      }
      
      public function onLastLightsS() : void
      {
         App.utils.asserter.assertNotNull(this.onLastLights,"onLastLights" + Errors.CANT_NULL);
         this.onLastLights();
      }
   }
}
