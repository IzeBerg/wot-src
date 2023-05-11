package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBaseRallyRoomViewMeta extends IEventDispatcher
   {
       
      
      function assignSlotRequestS(param1:int, param2:Number) : void;
      
      function leaveSlotRequestS(param1:Number) : void;
      
      function onSlotsHighlihgtingNeedS(param1:Number) : Array;
      
      function chooseVehicleRequestS() : void;
      
      function inviteFriendRequestS() : void;
      
      function toggleReadyStateRequestS() : void;
      
      function ignoreUserRequestS(param1:int) : void;
      
      function editDescriptionRequestS(param1:String) : void;
      
      function showFAQWindowS() : void;
      
      function as_updateRally(param1:Object) : void;
      
      function as_setMembers(param1:Boolean, param2:Array) : void;
      
      function as_setMemberStatus(param1:uint, param2:uint) : void;
      
      function as_setMemberOffline(param1:uint, param2:Boolean) : void;
      
      function as_setMemberVehicle(param1:uint, param2:uint, param3:Object) : void;
      
      function as_setActionButtonState(param1:Object) : void;
      
      function as_setComment(param1:String) : void;
      
      function as_getCandidatesDP() : Object;
      
      function as_highlightSlots(param1:Array) : void;
      
      function as_setVehiclesTitle(param1:String, param2:Object) : void;
   }
}
