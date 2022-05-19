package net.wg.gui.battle.battleRoyale.views.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleRoyaleCounterTimerAnimation extends MovieClip implements IDisposable
   {
      
      private static const ANIM_UPDATE_FRAME_LABEL:String = "update";
       
      
      public var counterContainer:BattleRoyaleTimerCounterContainer;
      
      private var _baseDisposed:Boolean = false;
      
      private var _counterValue:String = null;
      
      public function BattleRoyaleCounterTimerAnimation()
      {
         super();
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
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      public function setData(param1:String, param2:int) : void
      {
         this.counterContainer.setData(param1,param2);
         if(this._counterValue && param1 && param1 != this._counterValue)
         {
            this.gotoAndPlay(ANIM_UPDATE_FRAME_LABEL);
         }
         this._counterValue = param1;
      }
      
      protected function onDispose() : void
      {
         this.counterContainer.dispose();
         this.counterContainer = null;
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         this.counterContainer.isSmall = param1;
      }
   }
}
