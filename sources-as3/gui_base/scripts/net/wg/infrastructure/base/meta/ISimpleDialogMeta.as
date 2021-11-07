package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISimpleDialogMeta extends IEventDispatcher
   {
       
      
      function onButtonClickS(param1:String) : void;
      
      function as_setText(param1:String) : void;
      
      function as_setTitle(param1:String) : void;
      
      function as_setButtons(param1:Array) : void;
      
      function as_setButtonEnabling(param1:String, param2:Boolean) : void;
      
      function as_setButtonFocus(param1:String) : void;
   }
}
