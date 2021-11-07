package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IGameInputManagerMeta extends IEventDispatcher
   {
       
      
      function handleGlobalKeyEventS(param1:Number, param2:String) : void;
      
      function as_addKeyHandler(param1:Number, param2:String, param3:Boolean, param4:String, param5:Number) : void;
      
      function as_clearKeyHandler(param1:Number, param2:String) : void;
   }
}
