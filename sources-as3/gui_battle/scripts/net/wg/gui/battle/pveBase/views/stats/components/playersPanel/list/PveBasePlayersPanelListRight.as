package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.list
{
   import flash.display.Sprite;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelList;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   
   public class PveBasePlayersPanelListRight extends Sprite implements IPlayersPanelList
   {
       
      
      private var _disposed:Boolean = false;
      
      public function PveBasePlayersPanelListRight()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function resetFrags() : void
      {
      }
      
      public function setIsInteractive(param1:Boolean) : void
      {
      }
      
      public function setIsCursorVisible(param1:Boolean) : void
      {
      }
      
      public function setIsInviteShown(param1:Boolean) : void
      {
      }
      
      public function setVehicleLevelVisible(param1:Boolean) : void
      {
      }
      
      public function setVehicleData(param1:Vector.<DAAPIVehicleInfoVO>) : void
      {
      }
      
      public function removeAllItems() : void
      {
      }
      
      public function setFrags(param1:Number, param2:int) : void
      {
      }
      
      public function setChatCommand(param1:Number, param2:String, param3:uint) : void
      {
      }
      
      public function triggerChatCommand(param1:Number, param2:String) : void
      {
      }
      
      public function updateOrder(param1:Vector.<Number>) : void
      {
      }
      
      public function setInvitationStatus(param1:Number, param2:uint) : void
      {
      }
      
      public function setPlayerStatus(param1:Number, param2:uint) : void
      {
      }
      
      public function setPlayerHP(param1:int, param2:int) : void
      {
      }
      
      public function setOverrideExInfo(param1:Boolean) : void
      {
      }
      
      public function setUserTags(param1:Number, param2:Array) : void
      {
      }
      
      public function setVehicleStatus(param1:Number, param2:uint) : void
      {
      }
      
      public function setSpeaking(param1:Number, param2:Boolean) : void
      {
      }
      
      public function setChatCommandVisibility(param1:Boolean) : void
      {
      }
      
      public function setPanelHPBarVisibilityState(param1:uint) : void
      {
      }
      
      public function getRenderersVisibleWidth() : uint
      {
         return 0;
      }
      
      public function updateColorBlind() : void
      {
      }
      
      public function getItemHolderClass() : Class
      {
         return undefined;
      }
      
      public function get state() : int
      {
         return 0;
      }
      
      public function set state(param1:int) : void
      {
      }
      
      public function get isInviteReceived() : Boolean
      {
         return false;
      }
      
      public function setShowDogTag(param1:Boolean) : void
      {
      }
      
      public function showDogTag(param1:Number, param2:DogTagVO) : void
      {
      }
      
      public function setSpottedStatus(param1:Number, param2:uint) : void
      {
      }
   }
}
