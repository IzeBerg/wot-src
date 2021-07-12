package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleEndWarningPanelMeta extends IEventDispatcher
   {
       
      
      function as_setTotalTime(param1:String, param2:String) : void;
      
      function as_setTextInfo(param1:String) : void;
      
      function as_setState(param1:Boolean) : void;
   }
}
