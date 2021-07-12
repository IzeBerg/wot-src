package net.wg.gui.battle.views.superPlatoonPanel.renderers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.battle.random.views.stats.events.DynamicSquadEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InvalidationType;
   
   public class PlatoonInviteRenderer extends UIComponentEx
   {
      
      private static const INTRO_STATE:String = "intro";
      
      private static const REMOVE_INVITE_TIME:int = 30000;
       
      
      public var hit:Sprite = null;
      
      public var acceptPlatoonBt:BattleButton = null;
      
      public var playerInfoContainer:PlayerInfoContainer = null;
      
      public var playerName:MovieClip = null;
      
      public var inviteDropdownBG:MovieClip = null;
      
      public var inviteIntroBG:MovieClip = null;
      
      private var _data:DAAPIVehicleInfoVO = null;
      
      private var _scheduler:IScheduler;
      
      public function PlatoonInviteRenderer()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.inviteRendererDisplayTimeEndedTask);
         this._scheduler = null;
         stop();
         this.hit.removeEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
         this.acceptPlatoonBt.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.acceptPlatoonBt.removeEventListener(MouseEvent.CLICK,this.onAcceptInvitationClickHandler);
         this.playerInfoContainer.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.hit = null;
         this.acceptPlatoonBt.dispose();
         this.acceptPlatoonBt = null;
         this.playerName = null;
         this.inviteDropdownBG = null;
         this.inviteIntroBG = null;
         this.playerInfoContainer.dispose();
         this.playerInfoContainer = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.playerName.playerNameTF.text = this._data.playerName;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hit.addEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
         this.acceptPlatoonBt.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.acceptPlatoonBt.addEventListener(MouseEvent.CLICK,this.onAcceptInvitationClickHandler);
         this.playerInfoContainer.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
      }
      
      public function setInviteData(param1:DAAPIVehicleInfoVO, param2:Boolean) : void
      {
         this._data = param1;
         this.playerInfoContainer.setVehicleData(param1.vehicleLevel,param1.vehicleIconName,param1.squadIndex);
         if(param2)
         {
            this._scheduler.scheduleTask(this.inviteRendererDisplayTimeEndedTask,REMOVE_INVITE_TIME);
            gotoAndPlay(INTRO_STATE);
         }
      }
      
      private function inviteRendererDisplayTimeEndedTask() : void
      {
         dispatchEvent(new Event(Event.REMOVED_FROM_STAGE));
      }
      
      public function get vehicleID() : Number
      {
         return Boolean(this._data) ? Number(this._data.vehicleID) : Number(0);
      }
      
      public function get inviteAccountId() : Number
      {
         return Boolean(this._data) ? Number(this._data.accountDBID) : Number(0);
      }
      
      private function onAcceptInvitationClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new DynamicSquadEvent(DynamicSquadEvent.ACCEPT,this._data.sessionID,true));
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(!this.acceptPlatoonBt.visible)
         {
            this.acceptPlatoonBt.visible = true;
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         if(this.acceptPlatoonBt.visible)
         {
            this.acceptPlatoonBt.visible = false;
         }
      }
      
      private function onHitMouseOverHandler(param1:MouseEvent) : void
      {
         if(this.acceptPlatoonBt.visible)
         {
            this.acceptPlatoonBt.visible = false;
         }
      }
   }
}
