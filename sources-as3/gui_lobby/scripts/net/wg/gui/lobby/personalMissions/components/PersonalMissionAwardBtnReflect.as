package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionAwardBtnReflect extends MovieClip implements IDisposable
   {
       
      
      public var content:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function PersonalMissionAwardBtnReflect()
      {
         super();
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.content.stop();
         this.content = null;
      }
      
      public function playAnim() : void
      {
         this.content.play();
      }
      
      public function replayAnim() : void
      {
         this.content.gotoAndPlay(1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
