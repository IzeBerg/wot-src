package net.wg.data.VO.daapi
{
   import net.wg.data.constants.PlayerStatus;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.VehicleStatus;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   
   public class DAAPIVehicleInfoVO extends DAAPIDataClass
   {
      
      public static const DEFAULT_SQUAD_IDX:int = Values.ZERO;
      
      private static const BADGE_FIELD_NAME:String = "badge";
       
      
      public var prebattleID:Number = 0;
      
      public var isSpeaking:Boolean = false;
      
      public var frags:int;
      
      public var sessionID:String = "";
      
      public var accountDBID:Number = 0;
      
      public var playerName:String = "";
      
      public var playerFakeName:String = "";
      
      public var playerFullName:String = "";
      
      public var playerStatus:uint = 0;
      
      public var clanAbbrev:String = "";
      
      public var region:String = "";
      
      public var userTags:Array = null;
      
      public var squadIndex:uint = 0;
      
      public var invitationStatus:uint = 0;
      
      public var vehicleID:Number = 0;
      
      public var vehicleName:String = "";
      
      public var vehicleType:String = "";
      
      public var vehicleLevel:int = -1;
      
      public var vehicleIcon:String = "";
      
      public var vehicleIconName:String = "";
      
      public var vehicleStatus:uint = 0;
      
      public var isObserver:Boolean = false;
      
      public var vehicleAction:uint = 0;
      
      public var isVehiclePremiumIgr:Boolean = false;
      
      public var teamColor:String = "";
      
      public var badgeVO:BadgeVisualVO = null;
      
      public var hasSelectedBadge:Boolean = false;
      
      public var suffixBadgeType:String = "";
      
      public var suffixBadgeStripType:String = "";
      
      public var selfBgSource:String;
      
      public var isCurrentSquad:Boolean = false;
      
      public function DAAPIVehicleInfoVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[DAAPIVehicleInfoVO: vehicleID = " + this.vehicleID + ", playerFullName = " + this.playerFullName + " vehicleStatus = " + this.vehicleStatus + "] " + this.playerStatus;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BADGE_FIELD_NAME)
         {
            this.badgeVO = new BadgeVisualVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.userTags)
         {
            this.userTags.splice(0,this.userTags.length);
            this.userTags = null;
         }
         if(this.badgeVO)
         {
            this.badgeVO.dispose();
            this.badgeVO = null;
         }
         super.onDispose();
      }
      
      public function isAlive() : Boolean
      {
         return (this.vehicleStatus & VehicleStatus.IS_ALIVE) > 0;
      }
      
      public function isNotAvailable() : Boolean
      {
         return (this.vehicleStatus & VehicleStatus.NOT_AVAILABLE) > 0;
      }
      
      public function isReady() : Boolean
      {
         return (this.vehicleStatus & VehicleStatus.IS_READY) > 0;
      }
      
      public function isSquadMan() : Boolean
      {
         return (this.playerStatus & PlayerStatus.IS_SQUAD_MAN) > 0;
      }
      
      public function isSquadPersonal() : Boolean
      {
         return (this.playerStatus & PlayerStatus.IS_SQUAD_PERSONAL) > 0;
      }
      
      public function isTeamKiller() : Boolean
      {
         return (this.playerStatus & PlayerStatus.IS_TEAM_KILLER) > 0;
      }
      
      public function get isAnonymized() : Boolean
      {
         return this.playerFakeName && this.playerFakeName != this.playerName;
      }
      
      public function get isCurrentPlayer() : Boolean
      {
         return this.userTags && UserTags.isCurrentPlayer(this.userTags);
      }
      
      public function get isIGR() : Boolean
      {
         return this.isVehiclePremiumIgr && this.vehicleType && this.vehicleType != BATTLEATLAS.UNKNOWN;
      }
      
      public function update(param1:DAAPIVehicleInfoVO) : void
      {
         fromHash(param1.toHash());
      }
   }
}
