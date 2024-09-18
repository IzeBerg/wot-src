package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBattleQueueMeta extends IEventDispatcher
   {
       
      
      function onQuickStartPanelActionS(param1:int) : void;
      
      function as_setAverageTime(param1:String, param2:String) : void;
      
      function as_setInfoText(param1:String) : void;
      
      function as_showQuickStartPanel(param1:Object) : void;
      
      function as_hideQuickStartPanel() : void;
   }
}
