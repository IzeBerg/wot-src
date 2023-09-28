package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCBattleTopHintMeta extends IEventDispatcher
   {
       
      
      function animFinishS() : void;
      
      function as_showHint(param1:int, param2:String, param3:Boolean) : void;
      
      function as_hideHint() : void;
      
      function as_closeHint() : void;
      
      function as_setPenetration(param1:String, param2:Boolean) : void;
   }
}
