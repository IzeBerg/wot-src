package net.wg.gui.battle.views.superPlatoonPanel.renderers
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class PlayerInfoContainer extends UIComponentEx
   {
       
      
      public var inviteReceived:BattleAtlasSprite = null;
      
      public var inviteReceivedFromSquad:BattleAtlasSprite = null;
      
      public var squadInviteIcon:BattleAtlasSprite = null;
      
      public var vehicleLevel:BattleAtlasSprite = null;
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      private var _squadIdx:int = -1;
      
      private var _vehicleLevel:int = -1;
      
      private var _vehicleIconName:String = "";
      
      public function PlayerInfoContainer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.inviteReceivedFromSquad = null;
         this.inviteReceived = null;
         this.squadInviteIcon = null;
         this.vehicleLevel = null;
         this.vehicleIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleLevel.mouseChildren = this.vehicleIcon.mouseChildren = false;
         this.vehicleLevel.mouseEnabled = this.vehicleIcon.mouseEnabled = false;
         this.inviteReceivedFromSquad.imageName = BATTLEATLAS.SQUAD_INVITE_RECEIVED_FROM_SQUAD;
         this.inviteReceived.imageName = BATTLEATLAS.SQUAD_INVITE_RECEIVED;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.vehicleLevel.isCentralize = true;
            this.vehicleLevel.imageName = BATTLEATLAS.level(this._vehicleLevel.toString());
            this.vehicleIcon.setImageNames(this._vehicleIconName,BATTLEATLAS.UNKNOWN);
            this.updateInviteIcon(this._squadIdx);
         }
      }
      
      public function setVehicleData(param1:int, param2:String, param3:int) : void
      {
         this._vehicleLevel = param1;
         this._vehicleIconName = param2;
         this._squadIdx = param3;
         invalidateData();
      }
      
      private function updateInviteIcon(param1:int) : void
      {
         if(param1 != DAAPIVehicleInfoVO.DEFAULT_SQUAD_IDX)
         {
            this.inviteReceived.visible = false;
            this.inviteReceivedFromSquad.visible = true;
            this.squadInviteIcon.visible = true;
            this.squadInviteIcon.imageName = BATTLEATLAS.squad_gold(param1.toString());
         }
         else
         {
            this.inviteReceived.visible = true;
            this.inviteReceivedFromSquad.visible = false;
            this.squadInviteIcon.visible = false;
         }
      }
   }
}
