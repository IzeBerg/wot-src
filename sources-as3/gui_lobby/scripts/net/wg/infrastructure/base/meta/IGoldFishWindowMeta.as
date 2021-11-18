package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IGoldFishWindowMeta extends IEventDispatcher
   {
       
      
      function eventHyperLinkClickedS() : void;
      
      function as_setWindowTexts(param1:String, param2:String, param3:String, param4:String) : void;
   }
}
