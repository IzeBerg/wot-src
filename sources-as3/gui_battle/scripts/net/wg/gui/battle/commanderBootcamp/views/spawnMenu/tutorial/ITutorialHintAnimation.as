package net.wg.gui.battle.commanderBootcamp.views.spawnMenu.tutorial
{
   import net.wg.infrastructure.interfaces.ISprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ITutorialHintAnimation extends ISprite, IDisposable
   {
       
      
      function show() : void;
      
      function hide(param1:Boolean = false) : void;
      
      function setSize(param1:Number, param2:Number = NaN) : void;
   }
}
