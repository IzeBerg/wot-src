package net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps
{
   import flash.events.IEventDispatcher;
   
   public interface IEventTimerAnimation extends IEventDispatcher
   {
       
      
      function updateProgress(param1:Number, param2:int) : void;
   }
}
