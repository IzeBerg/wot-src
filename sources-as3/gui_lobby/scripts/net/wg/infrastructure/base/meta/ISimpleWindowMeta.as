package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISimpleWindowMeta extends IEventDispatcher
   {
       
      
      function onBtnClickS(param1:String) : void;
      
      function as_setWindowTitle(param1:String) : void;
      
      function as_setText(param1:String, param2:String) : void;
      
      function as_setImage(param1:String, param2:int) : void;
      
      function as_setButtons(param1:Array, param2:String, param3:int) : void;
   }
}
