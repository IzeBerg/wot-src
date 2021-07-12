package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFragCorrelationBarMeta extends IEventDispatcher
   {
       
      
      function as_updateTeamHealthValues(param1:String, param2:String, param3:int, param4:String, param5:int) : void;
      
      function as_updateViewSetting(param1:int) : void;
   }
}
