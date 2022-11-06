package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleMessageListMeta extends IEventDispatcher
   {
       
      
      function onRefreshCompleteS() : void;
      
      function as_setupList(param1:Object) : void;
      
      function as_clear() : void;
      
      function as_refresh() : void;
      
      function as_showYellowMessage(param1:String, param2:String) : void;
      
      function as_showRedMessage(param1:String, param2:String) : void;
      
      function as_showPurpleMessage(param1:String, param2:String) : void;
      
      function as_showGreenMessage(param1:String, param2:String) : void;
      
      function as_showGoldMessage(param1:String, param2:String) : void;
      
      function as_showSelfMessage(param1:String, param2:String) : void;
   }
}
