package net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers
{
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionProgressBlock;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class AbstractDivisionState implements IDisposable
   {
       
      
      private var _progressBlock:DivisionProgressBlock = null;
      
      private var _position:Number = 0;
      
      private var _disposed:Boolean = false;
      
      public function AbstractDivisionState(param1:DivisionProgressBlock)
      {
         super();
         this._progressBlock = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.stop();
         this.onDispose();
         this._progressBlock = null;
      }
      
      public function start() : void
      {
      }
      
      public function stop() : void
      {
         this.stopAllTweens();
      }
      
      public function updateSize() : void
      {
         this.update();
      }
      
      protected function onDispose() : void
      {
      }
      
      protected function update() : void
      {
      }
      
      protected function stopAllTweens() : void
      {
      }
      
      protected function stopTween(param1:Tween) : void
      {
         if(param1)
         {
            param1.onComplete = null;
            param1.onChange = null;
            param1.paused = true;
            param1.dispose();
         }
      }
      
      protected function setInitialPosition(param1:Number) : void
      {
         this._position = param1;
      }
      
      public function get position() : Number
      {
         return this._position;
      }
      
      public function set position(param1:Number) : void
      {
         if(this._position != param1)
         {
            this._position = param1;
            this.update();
         }
      }
      
      protected function get progressBlock() : DivisionProgressBlock
      {
         return this._progressBlock;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
