package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMinimapGridMeta extends IEventDispatcher
   {
       
      
      function setClickS(param1:Number, param2:Number) : void;
      
      function as_clickEnabled(param1:Boolean) : void;
      
      function as_addPoint(param1:Number, param2:Number) : void;
   }
}
