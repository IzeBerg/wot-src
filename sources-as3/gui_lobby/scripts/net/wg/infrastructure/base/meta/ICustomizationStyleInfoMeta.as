package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICustomizationStyleInfoMeta extends IEventDispatcher
   {
       
      
      function onCloseS() : void;
      
      function onApplyS() : void;
      
      function onWidthUpdatedS(param1:int, param2:int, param3:int) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_buttonUpdate(param1:Object) : void;
      
      function as_setBackgroundAlpha(param1:Number) : void;
      
      function as_show() : void;
      
      function as_hide() : void;
   }
}
