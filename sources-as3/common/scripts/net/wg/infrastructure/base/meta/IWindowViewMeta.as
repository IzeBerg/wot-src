package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWindowViewMeta extends IEventDispatcher
   {
       
      
      function onWindowMinimizeS() : void;
      
      function onSourceLoadedS() : void;
      
      function onTryClosingS() : Boolean;
      
      function as_getGeometry() : Array;
      
      function as_setGeometry(param1:Number, param2:Number, param3:Number, param4:Number) : void;
   }
}
