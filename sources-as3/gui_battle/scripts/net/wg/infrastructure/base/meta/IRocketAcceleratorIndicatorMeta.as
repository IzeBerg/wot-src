package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRocketAcceleratorIndicatorMeta extends IEventDispatcher
   {
       
      
      function as_setState(param1:String) : void;
      
      function as_setVisible(param1:Boolean) : void;
      
      function as_setCount(param1:int) : void;
      
      function as_setProgress(param1:Number) : void;
      
      function as_setActiveTime(param1:Number) : void;
      
      function as_updateLayout(param1:Number, param2:Number) : void;
   }
}
