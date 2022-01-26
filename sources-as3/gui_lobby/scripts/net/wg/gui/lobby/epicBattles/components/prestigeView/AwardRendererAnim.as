package net.wg.gui.lobby.epicBattles.components.prestigeView
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.components.AwardItemRendererEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IScheduler;
   
   public class AwardRendererAnim extends MovieClip implements IDisposable
   {
       
      
      public var award:AwardItemRendererEx = null;
      
      private var _baseDisposed:Boolean = false;
      
      private var _startDelay:uint = 0;
      
      private var _sheduler:IScheduler;
      
      public function AwardRendererAnim()
      {
         this._sheduler = App.utils.scheduler;
         super();
         this.award.allowRescaleUpward = true;
      }
      
      protected function onDispose() : void
      {
         stop();
         this.award.dispose();
         this.award = null;
         this._sheduler.cancelTask(play);
         this._sheduler = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function setData(param1:Object) : void
      {
         this.award.setData(param1);
      }
      
      public function show() : void
      {
         if(this._startDelay > 0)
         {
            this._sheduler.scheduleTask(play,this._startDelay);
         }
         else
         {
            play();
         }
      }
      
      public function set startDelay(param1:uint) : void
      {
         this._startDelay = param1;
      }
      
      public function set iconSize(param1:uint) : void
      {
         this.award.setSize(param1,param1);
      }
   }
}
