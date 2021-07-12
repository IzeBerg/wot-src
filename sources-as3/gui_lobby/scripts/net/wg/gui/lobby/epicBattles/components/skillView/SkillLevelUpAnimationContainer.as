package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SkillLevelUpAnimationContainer extends MovieClip implements IDisposable
   {
      
      private static const LEVEL_UP_START_STATE:String = "start";
       
      
      public var newLevel:MovieClip = null;
      
      public function SkillLevelUpAnimationContainer()
      {
         super();
      }
      
      public function setDataAndAnimate(param1:int) : void
      {
         this.newLevel.gotoAndStop(param1);
         gotoAndPlay(LEVEL_UP_START_STATE);
      }
      
      public final function dispose() : void
      {
         stop();
         this.newLevel = null;
      }
   }
}
