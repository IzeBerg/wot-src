package net.wg.gui.battle.battleloading.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.battle.battleloading.constants.PlayerStatus;
   import net.wg.gui.battle.battleloading.constants.VehicleStatus;
   
   public class VehicleInfoVO extends DAAPIDataClass
   {
      
      public static const DEFAULT_SQUAD_IDX:int = 0;
       
      
      public var accountDBID:Number = 0;
      
      public var isMuted:Boolean = false;
      
      public var isSpeaking:Boolean = false;
      
      public var vehicleID:Number = 0;
      
      public var prebattleID:Number = 0;
      
      public var vehicleStatus:uint = 0;
      
      public var playerStatus:uint = 0;
      
      public var squadIndex:uint = 0;
      
      public var vehicleAction:uint = 0;
      
      public var vehicleIcon:String = "";
      
      public var vehicleName:String = "";
      
      public var vehicleGuiName:String = "";
      
      public var playerName:String = "";
      
      public var igrType:int = 0;
      
      public var clanAbbrev:String = "";
      
      public var region:String = "";
      
      public var isCurrentPlayer:Boolean = false;
      
      public var selfBgSource:String;
      
      public var isCurrentSquad:Boolean = false;
      
      public var isPlayerTeam:Boolean = false;
      
      public var points:int = 0;
      
      public var vehicleType:String = "";
      
      public var teamColor:String = "";
      
      public var vLevel:int = -1;
      
      public function VehicleInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[VehicleInfoVO: vehicleID = " + this.vehicleID + ", playerName = " + this.playerName + " vehicleStatus = " + this.vehicleStatus + "]";
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
      
      public function isTeamKiller() : Boolean
      {
         return (this.playerStatus & PlayerStatus.IS_TEAM_KILLER) > 0;
      }
   }
}
