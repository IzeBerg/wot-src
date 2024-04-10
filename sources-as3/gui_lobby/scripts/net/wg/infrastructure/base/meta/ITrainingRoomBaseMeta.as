package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITrainingRoomBaseMeta extends IEventDispatcher
   {
       
      
      function showTrainingSettingsS() : void;
      
      function selectCommonVoiceChatS(param1:Number) : void;
      
      function selectObserverS(param1:Boolean) : void;
      
      function startTrainingS() : void;
      
      function swapTeamsS() : void;
      
      function changeTeamS(param1:Number, param2:Number) : void;
      
      function closeTrainingRoomS() : void;
      
      function showPrebattleInvitationsFormS() : void;
      
      function onEscapeS() : void;
      
      function canSendInviteS() : Boolean;
      
      function canChangeSettingS() : Boolean;
      
      function canChangePlayerTeamS() : Boolean;
      
      function canStartBattleS() : Boolean;
      
      function canAssignToTeamS(param1:int) : Boolean;
      
      function canDestroyRoomS() : Boolean;
      
      function getPlayerTeamS(param1:int) : int;
      
      function as_setObserver(param1:Boolean) : void;
      
      function as_updateComment(param1:String) : void;
      
      function as_updateMap(param1:Number, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:Boolean) : void;
      
      function as_updateTimeout(param1:String) : void;
      
      function as_setTeam1(param1:Object) : void;
      
      function as_setTeam2(param1:Object) : void;
      
      function as_setOther(param1:Object) : void;
      
      function as_setInfo(param1:Object) : void;
      
      function as_setArenaVoipChannels(param1:Number) : void;
      
      function as_disableControls(param1:Boolean) : void;
      
      function as_startCoolDownVoiceChat(param1:Number) : void;
      
      function as_startCoolDownObserver(param1:Number) : void;
      
      function as_startCoolDownSetting(param1:Number) : void;
      
      function as_startCoolDownSwapButton(param1:Number) : void;
      
      function as_setPlayerStateInTeam1(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:Object) : void;
      
      function as_setPlayerStateInTeam2(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:Object) : void;
      
      function as_setPlayerStateInOther(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:Object) : void;
      
      function as_setPlayerTagsInTeam1(param1:Number, param2:Array) : void;
      
      function as_setPlayerTagsInTeam2(param1:Number, param2:Array) : void;
      
      function as_setPlayerTagsInOther(param1:Number, param2:Array) : void;
      
      function as_enabledCloseButton(param1:Boolean) : void;
      
      function as_setStartButtonState(param1:Boolean, param2:String) : void;
   }
}
