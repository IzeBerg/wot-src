package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPrebattleTimerMeta extends IEventDispatcher
   {
       
      
      function onShowInfoS() : void;
      
      function onHideInfoS() : void;
      
      function as_addInfo(param1:String, param2:Object) : void;
      
      function as_setInfoHint(param1:String) : void;
      
      function as_showInfo() : void;
   }
}
