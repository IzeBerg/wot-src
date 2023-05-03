package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface INotificationsListMeta extends IEventDispatcher
   {
       
      
      function onClickActionS(param1:uint, param2:Number, param3:String) : void;
      
      function getMessageActualTimeS(param1:Number) : String;
      
      function onGroupChangeS(param1:uint) : void;
      
      function onCheckNewsClickS() : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setMessagesList(param1:Object) : void;
      
      function as_appendMessage(param1:Object) : void;
      
      function as_updateMessage(param1:Object) : void;
      
      function as_updateCounters(param1:Array) : void;
      
      function as_setProgressiveRewardEnabled(param1:Boolean) : void;
      
      function as_setIsNewsBlockEnabled(param1:Boolean) : void;
      
      function as_setCheckNewsBtnEnabled(param1:Boolean) : void;
   }
}
