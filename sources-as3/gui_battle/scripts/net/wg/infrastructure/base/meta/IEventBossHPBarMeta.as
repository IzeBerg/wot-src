package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBossHPBarMeta extends IEventDispatcher
   {
       
      
      function as_setPhase(param1:int) : void;
      
      function as_setBossHP(param1:String, param2:int) : void;
      
      function as_setVisible(param1:Boolean) : void;
   }
}
