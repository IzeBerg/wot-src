package net.wg.gui.battle.commanderBootcamp.views.spawnMenu.tutorial
{
   public interface ITutorialHintArrowAnimation extends ITutorialHintAnimation
   {
       
      
      function loop() : void;
      
      function needToHide(param1:Boolean) : void;
      
      function get isLooped() : Boolean;
      
      function set isLooped(param1:Boolean) : void;
   }
}
