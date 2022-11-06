package net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ISecondaryTimerFX extends IDisposable
   {
       
      
      function setFxContainer(param1:SecondaryTimerFXContainer) : void;
      
      function show(param1:Boolean) : void;
      
      function hide() : void;
   }
}
