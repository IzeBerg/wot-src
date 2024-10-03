package net.wg.white_tiger.gui.battle.views.shared.interfaces
{
   import flash.events.IEventDispatcher;
   
   public interface ITimerAnimation extends IEventDispatcher
   {
       
      
      function updateProgress(param1:Number, param2:int) : void;
   }
}
