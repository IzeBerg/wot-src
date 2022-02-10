package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.ITween;
   
   public interface ITweenManagerMeta extends IEventDispatcher
   {
       
      
      function createTweenS(param1:ITween) : void;
      
      function disposeTweenS(param1:ITween) : void;
      
      function disposeAllS() : void;
      
      function as_setDataFromXml(param1:Object) : void;
   }
}
