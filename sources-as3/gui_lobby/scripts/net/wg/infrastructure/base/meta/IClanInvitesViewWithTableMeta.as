package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanInvitesViewWithTableMeta extends IEventDispatcher
   {
       
      
      function showMoreS() : void;
      
      function refreshTableS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_getTableDP() : Object;
      
      function as_updateDefaultSortField(param1:String, param2:String) : void;
      
      function as_showDummy(param1:Object) : void;
      
      function as_hideDummy() : void;
      
      function as_updateButtonRefreshState(param1:Boolean, param2:String) : void;
   }
}
