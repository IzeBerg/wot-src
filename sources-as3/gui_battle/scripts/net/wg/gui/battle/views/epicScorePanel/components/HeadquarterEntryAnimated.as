package net.wg.gui.battle.views.epicScorePanel.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HeadquarterEntryAnimated extends MovieClip implements IDisposable
   {
      
      private static const DEFAULT_STATE:String = "default";
      
      private static const TARGET_FOCUS_STATE:String = "target_focus";
       
      
      public var base:HeadquarterScoreEntry = null;
      
      public var primaryTarget:MovieClip = null;
      
      public function HeadquarterEntryAnimated()
      {
         super();
      }
      
      public final function dispose() : void
      {
         stop();
         this.base.dispose();
         this.base = null;
         this.primaryTarget = null;
      }
      
      public function init(param1:int, param2:Boolean) : void
      {
         gotoAndPlay(DEFAULT_STATE);
         this.base.initData(param1,param2);
      }
      
      public function isActive(param1:Boolean) : void
      {
         this.base.active = param1;
      }
      
      public function setAsPrimaryTarget(param1:Boolean) : void
      {
         gotoAndPlay(!!param1 ? TARGET_FOCUS_STATE : DEFAULT_STATE);
      }
      
      public function setDestructionState(param1:Boolean) : void
      {
         this.base.destroyed = param1;
      }
      
      public function setHealth(param1:Number) : void
      {
         this.base.health = param1;
      }
   }
}
