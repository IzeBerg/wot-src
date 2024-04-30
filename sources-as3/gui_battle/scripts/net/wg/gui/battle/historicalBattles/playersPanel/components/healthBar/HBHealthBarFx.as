package net.wg.gui.battle.historicalBattles.playersPanel.components.healthBar
{
   import flash.display.MovieClip;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HBHealthBarFx extends MovieClip implements IDisposable
   {
      
      private static const CURRENT_PLAYER:String = "currentPlayer";
      
      private static const REGULAR_LABEL:String = "regular";
      
      private static const REGULAR_BLIND_LABEL:String = "regularBlind";
      
      private static const FX_FRAME:int = 2;
       
      
      public var bg:FrameStateCmpnt = null;
      
      private var _disposed:Boolean = false;
      
      public function HBHealthBarFx()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function playAnim() : void
      {
         gotoAndPlay(FX_FRAME);
      }
      
      private function onDispose() : void
      {
         this.bg.dispose();
         this.bg = null;
      }
      
      public function set isCurrentPlayer(param1:Boolean) : void
      {
         this.bg.frameLabel = !!param1 ? CURRENT_PLAYER : REGULAR_LABEL;
      }
      
      public function set isBlindEnabled(param1:Boolean) : void
      {
         this.bg.frameLabel = !!param1 ? REGULAR_BLIND_LABEL : REGULAR_LABEL;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
