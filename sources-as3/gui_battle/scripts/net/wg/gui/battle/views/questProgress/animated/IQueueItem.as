package net.wg.gui.battle.views.questProgress.animated
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IQueueItem extends IDisposable
   {
       
      
      function run(param1:Function) : void;
   }
}
