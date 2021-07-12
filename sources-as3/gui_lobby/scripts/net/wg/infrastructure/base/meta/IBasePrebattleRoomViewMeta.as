package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBasePrebattleRoomViewMeta extends IEventDispatcher
   {
       
      
      function requestToReadyS(param1:Boolean) : void;
      
      function requestToLeaveS() : void;
      
      function showPrebattleSendInvitesWindowS() : void;
      
      function canSendInviteS() : Boolean;
      
      function canKickPlayerS() : Boolean;
      
      function isPlayerReadyS() : Boolean;
      
      function isPlayerCreatorS() : Boolean;
      
      function isReadyBtnEnabledS() : Boolean;
      
      function isLeaveBtnEnabledS() : Boolean;
      
      function getClientIDS() : Number;
      
      function as_setRosterList(param1:int, param2:Boolean, param3:Array) : void;
      
      function as_setPlayerState(param1:int, param2:Boolean, param3:Object) : void;
      
      function as_enableLeaveBtn(param1:Boolean) : void;
      
      function as_enableReadyBtn(param1:Boolean) : void;
      
      function as_setCoolDownForReadyButton(param1:uint) : void;
      
      function as_resetReadyButtonCoolDown() : void;
      
      function as_toggleReadyBtn(param1:Boolean) : void;
      
      function as_refreshPermissions() : void;
   }
}
