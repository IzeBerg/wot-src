package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanPersonalInvitesViewMeta extends IEventDispatcher
   {
       
      
      function acceptInviteS(param1:Number) : void;
      
      function declineInviteS(param1:Number) : void;
      
      function setInviteSelectedS(param1:Number, param2:Boolean) : void;
      
      function setSelectAllInvitesCheckBoxSelectedS(param1:Boolean) : void;
      
      function declineAllSelectedInvitesS() : void;
      
      function as_setDeclineAllSelectedInvitesState(param1:String, param2:Boolean) : void;
      
      function as_setSelectAllCheckboxState(param1:Boolean, param2:Boolean) : void;
   }
}
