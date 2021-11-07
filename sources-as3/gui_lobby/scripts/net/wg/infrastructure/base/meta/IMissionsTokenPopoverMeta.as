package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMissionsTokenPopoverMeta extends IEventDispatcher
   {
       
      
      function onQuestClickS(param1:String) : void;
      
      function onBuyBtnClickS() : void;
      
      function as_setStaticData(param1:Object) : void;
      
      function as_setListDataProvider(param1:Array) : void;
   }
}
