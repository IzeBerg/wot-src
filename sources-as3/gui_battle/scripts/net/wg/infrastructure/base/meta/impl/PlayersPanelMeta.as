package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   
   public class PlayersPanelMeta extends StatsBaseMeta
   {
       
      
      public var tryToSetPanelModeByMouse:Function;
      
      public var switchToOtherPlayer:Function;
      
      public function PlayersPanelMeta()
      {
         super();
      }
      
      public function tryToSetPanelModeByMouseS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.tryToSetPanelModeByMouse,"tryToSetPanelModeByMouse" + Errors.CANT_NULL);
         this.tryToSetPanelModeByMouse(param1);
      }
      
      public function switchToOtherPlayerS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.switchToOtherPlayer,"switchToOtherPlayer" + Errors.CANT_NULL);
         this.switchToOtherPlayer(param1);
      }
   }
}
