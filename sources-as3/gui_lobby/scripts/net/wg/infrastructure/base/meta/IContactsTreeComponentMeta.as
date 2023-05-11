package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IContactsTreeComponentMeta extends IEventDispatcher
   {
       
      
      function onGroupSelectedS(param1:int, param2:Object) : void;
      
      function searchLocalContactS(param1:String) : void;
      
      function hasDisplayingContactsS() : Boolean;
      
      function as_updateInfoMessage(param1:Boolean, param2:String, param3:String, param4:Boolean) : void;
      
      function as_getMainDP() : Object;
      
      function as_setInitData(param1:Object) : void;
   }
}
