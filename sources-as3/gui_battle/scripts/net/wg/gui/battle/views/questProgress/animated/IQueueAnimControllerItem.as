package net.wg.gui.battle.views.questProgress.animated
{
   public interface IQueueAnimControllerItem extends IQueueItem
   {
       
      
      function onPreCompletedCallBack() : void;
      
      function onAnmCompleteCallback() : void;
      
      function onAnimStartCallback() : void;
   }
}
