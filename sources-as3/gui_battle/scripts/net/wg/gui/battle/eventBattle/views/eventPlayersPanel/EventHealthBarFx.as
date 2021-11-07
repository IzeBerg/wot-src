package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EventHealthBarFx extends MovieClip implements IDisposable
   {
      
      private static const FX_FRAME:int = 2;
       
      
      public var barFX:FrameStateCmpnt = null;
      
      public function EventHealthBarFx()
      {
         super();
      }
      
      public function setBarFrame(param1:String) : void
      {
         this.barFX.frameLabel = param1;
      }
      
      public function playAnim() : void
      {
         gotoAndPlay(FX_FRAME);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      private function onDispose() : void
      {
         this.barFX.dispose();
         this.barFX = null;
      }
   }
}
