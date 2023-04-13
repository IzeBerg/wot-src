package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IIngameHelpWindowMeta extends IEventDispatcher
   {
       
      
      function clickSettingWindowS() : void;
      
      function as_setKeys(param1:Object) : void;
      
      function as_setColorBlind(param1:Boolean) : void;
   }
}
