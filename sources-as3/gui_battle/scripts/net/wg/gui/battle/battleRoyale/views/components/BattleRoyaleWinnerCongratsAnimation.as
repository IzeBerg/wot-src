package net.wg.gui.battle.battleRoyale.views.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleRoyaleWinnerCongratsAnimation extends MovieClip implements IDisposable
   {
       
      
      public var titleMC:TextFieldContainer = null;
      
      private var _isDisposed:Boolean = false;
      
      public function BattleRoyaleWinnerCongratsAnimation()
      {
         super();
         this.titleMC.label = BATTLE_ROYALE.BATTLE_WINNERCONGRATULATIONSVIEW_TITLE;
      }
      
      public function dispose() : void
      {
         this.titleMC.dispose();
         this.titleMC = null;
         this._isDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
