package net.wg.gui.battle.eventBattle.views.eventStats
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EventStatsHeader extends MovieClip implements IDisposable
   {
       
      
      public var phaseTF:TextField = null;
      
      public var difficultyTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var eventTF:TextField = null;
      
      public var difficulty:MovieClip = null;
      
      public function EventStatsHeader()
      {
         super();
      }
      
      public function setData(param1:String, param2:String, param3:int) : void
      {
         this.phaseTF.text = param1;
         this.descriptionTF.text = param2;
         this.difficulty.gotoAndStop(param3);
         this.eventTF.text = EVENT.ARENA_DESCRIPTION_TITLE;
         this.difficultyTF.text = EVENT.STATS_DIFFICULTY;
      }
      
      public final function dispose() : void
      {
         this.phaseTF = null;
         this.difficultyTF = null;
         this.descriptionTF = null;
         this.eventTF = null;
         this.difficulty = null;
      }
   }
}
