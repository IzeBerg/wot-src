package net.wg.gui.lobby.battlequeue
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RTSBattleQueueFooter extends MovieClip implements IDisposable
   {
       
      
      public var timerLabel:TextField;
      
      public var timerText:TextField;
      
      public var tankLabel:TextField;
      
      public var tankName:TextField;
      
      public var gameplayTip:TextField;
      
      public var additional:TextField;
      
      public var teamName:TextField;
      
      public var tankIcon:UILoaderAlt;
      
      public var exitButton:ISoundButtonEx;
      
      public var startButton:ISoundButtonEx;
      
      private var _isDisposed:Boolean = false;
      
      public function RTSBattleQueueFooter()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this._isDisposed = true;
      }
      
      protected function onDispose() : void
      {
         this.timerLabel = null;
         this.timerText = null;
         this.tankLabel = null;
         this.tankName = null;
         this.gameplayTip = null;
         this.additional = null;
         this.teamName = null;
         this.tankIcon = null;
         this.exitButton = null;
         this.startButton = null;
      }
      
      public final function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
