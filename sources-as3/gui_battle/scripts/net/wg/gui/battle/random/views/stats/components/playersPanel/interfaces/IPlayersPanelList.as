package net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces
{
   import flash.events.IEventDispatcher;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IPlayersPanelList extends IEventDispatcher, IDisposable
   {
       
      
      function resetFrags() : void;
      
      function setIsInteractive(param1:Boolean) : void;
      
      function setIsCursorVisible(param1:Boolean) : void;
      
      function setIsInviteShown(param1:Boolean) : void;
      
      function setVehicleLevelVisible(param1:Boolean) : void;
      
      function setVehicleData(param1:Vector.<DAAPIVehicleInfoVO>) : void;
      
      function removeAllItems() : void;
      
      function setFrags(param1:Number, param2:int) : void;
      
      function setChatCommand(param1:Number, param2:String, param3:uint) : void;
      
      function triggerChatCommand(param1:Number, param2:String) : void;
      
      function updateOrder(param1:Vector.<Number>) : void;
      
      function setInvitationStatus(param1:Number, param2:uint) : void;
      
      function setPlayerStatus(param1:Number, param2:uint) : void;
      
      function setPlayerHP(param1:int, param2:int) : void;
      
      function setOverrideExInfo(param1:Boolean) : void;
      
      function setUserTags(param1:Number, param2:Array) : void;
      
      function setVehicleStatus(param1:Number, param2:uint) : void;
      
      function setSpeaking(param1:Number, param2:Boolean) : void;
      
      function setChatCommandVisibility(param1:Boolean) : void;
      
      function setPanelHPBarVisibilityState(param1:uint) : void;
      
      function getRenderersVisibleWidth() : uint;
      
      function updateColorBlind() : void;
      
      function getItemHolderClass() : Class;
      
      function get state() : int;
      
      function set state(param1:int) : void;
      
      function get x() : Number;
      
      function set x(param1:Number) : void;
      
      function get visible() : Boolean;
      
      function set visible(param1:Boolean) : void;
      
      function get y() : Number;
      
      function get height() : Number;
      
      function get isInviteReceived() : Boolean;
      
      function setShowDogTag(param1:Boolean) : void;
      
      function showDogTag(param1:Number, param2:DogTagVO) : void;
      
      function setSpottedStatus(param1:Number, param2:uint) : void;
   }
}
