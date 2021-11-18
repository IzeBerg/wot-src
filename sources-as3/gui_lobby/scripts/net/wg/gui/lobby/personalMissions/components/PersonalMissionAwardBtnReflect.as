package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionAwardBtnReflect extends MovieClip implements IDisposable
   {
       
      
      public var content:MovieClip = null;
      
      public function PersonalMissionAwardBtnReflect()
      {
         super();
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      public final function dispose() : void
      {
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
   }
}
