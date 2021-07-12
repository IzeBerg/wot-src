package net.wg.gui.battle.views.questProgress.animated
{
   import net.wg.infrastructure.interfaces.questProgress.IQueueAnimItemAbstract;
   
   public interface IQueueAnimProgressState extends IQueueAnimItemAbstract
   {
       
      
      function setIcon(param1:String) : void;
      
      function setValue(param1:String) : void;
      
      function setProgressPrc(param1:int) : void;
   }
}
