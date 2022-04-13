package net.wg.gui.battle.commander.views.spawnMenu.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   
   public class SpawnMenuVO extends DAAPIDataClass
   {
      
      private static const PLAYER_BADGE_INFO:String = "playerBadgeInfo";
      
      private static const ENEMY_STRATEGIST_BADGE_INFO:String = "enemyStrategistBadgeInfo";
      
      private static const PLAYER_VEHICLE_ROSTER_DATA_FIELD_NAME:String = "playerRosterVehicles";
      
      private static const PLAYER_SUPPLIES_ROSTER_DATA_FIELD_NAME:String = "playerRosterSupplies";
      
      private static const ENEMIES_DATA_FIELD_NAME:String = "enemiesData";
      
      private static const ENEMY_VEHICLE_ROSTER_DATA_FIELD_NAME:String = "enemyRosterVehicles";
      
      private static const ENEMY_SUPPLIES_ROSTER_DATA_FIELD_NAME:String = "enemyRosterSupplies";
       
      
      public var playerName:String = "";
      
      public var playerBadgeInfo:BadgeVisualVO = null;
      
      public var playerSuffixBadgeType:String = "";
      
      public var playerSuffixBadgeStripType:String = "";
      
      public var autoSetBtnText:String = "";
      
      public var resetBtnText:String = "";
      
      public var battleBtnText:String = "";
      
      public var playerRosterVehicles:Vector.<RosterVehicleVO> = null;
      
      public var playerRosterSupplies:Vector.<RosterSupplyVO> = null;
      
      public var clanAbbrev:String = "";
      
      public var region:String = "";
      
      public var playerFakeName:String = "";
      
      public var userTags:Array = null;
      
      public var enemyStrategistName:String = "";
      
      public var enemyStrategistBadgeInfo:BadgeVisualVO = null;
      
      public var enemySuffixBadgeType:String = "";
      
      public var enemySuffixBadgeStripType:String = "";
      
      public var enemiesData:Vector.<EnemyVehicleItemVO> = null;
      
      public var enemyRosterVehicles:Vector.<RosterVehicleVO> = null;
      
      public var enemyRosterSupplies:Vector.<RosterSupplyVO> = null;
      
      public var winConditionText:String = "";
      
      public function SpawnMenuVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case PLAYER_BADGE_INFO:
               this.playerBadgeInfo = new BadgeVisualVO(param2);
               return false;
            case ENEMY_STRATEGIST_BADGE_INFO:
               this.enemyStrategistBadgeInfo = new BadgeVisualVO(param2);
               return false;
            case PLAYER_VEHICLE_ROSTER_DATA_FIELD_NAME:
               this.playerRosterVehicles = Vector.<RosterVehicleVO>(App.utils.data.convertVOArrayToVector(param1,param2,RosterVehicleVO));
               return false;
            case ENEMIES_DATA_FIELD_NAME:
               this.enemiesData = Vector.<EnemyVehicleItemVO>(App.utils.data.convertVOArrayToVector(param1,param2,EnemyVehicleItemVO));
               return false;
            case PLAYER_SUPPLIES_ROSTER_DATA_FIELD_NAME:
               this.playerRosterSupplies = Vector.<RosterSupplyVO>(App.utils.data.convertVOArrayToVector(param1,param2,RosterSupplyVO));
               return false;
            case ENEMY_VEHICLE_ROSTER_DATA_FIELD_NAME:
               this.enemyRosterVehicles = Vector.<RosterVehicleVO>(App.utils.data.convertVOArrayToVector(param1,param2,RosterVehicleVO));
               return false;
            case ENEMY_SUPPLIES_ROSTER_DATA_FIELD_NAME:
               this.enemyRosterSupplies = Vector.<RosterSupplyVO>(App.utils.data.convertVOArrayToVector(param1,param2,RosterSupplyVO));
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.playerBadgeInfo)
         {
            this.playerBadgeInfo.dispose();
            this.playerBadgeInfo = null;
         }
         if(this.enemyStrategistBadgeInfo)
         {
            this.enemyStrategistBadgeInfo.dispose();
            this.enemyStrategistBadgeInfo = null;
         }
         if(this.userTags)
         {
            this.userTags.splice(0,this.userTags.length);
            this.userTags = null;
         }
         this.resetAllyItemsData();
         this.resetEnemyItemsData();
         super.onDispose();
      }
      
      public function resetAllyItemsData() : void
      {
         var _loc1_:DAAPIDataClass = null;
         if(this.playerRosterVehicles)
         {
            for each(_loc1_ in this.playerRosterVehicles)
            {
               _loc1_.dispose();
            }
            this.playerRosterVehicles.splice(0,this.playerRosterVehicles.length);
            this.playerRosterVehicles = null;
         }
         if(this.playerRosterSupplies)
         {
            for each(_loc1_ in this.playerRosterSupplies)
            {
               _loc1_.dispose();
            }
            this.playerRosterSupplies.splice(0,this.playerRosterSupplies.length);
            this.playerRosterSupplies = null;
         }
      }
      
      public function resetEnemyItemsData() : void
      {
         var _loc1_:DAAPIDataClass = null;
         if(this.enemiesData)
         {
            for each(_loc1_ in this.enemiesData)
            {
               _loc1_.dispose();
            }
            this.enemiesData.splice(0,this.enemiesData.length);
            this.enemiesData = null;
         }
         if(this.enemyRosterVehicles)
         {
            for each(_loc1_ in this.enemyRosterVehicles)
            {
               _loc1_.dispose();
            }
            this.enemyRosterVehicles.splice(0,this.enemyRosterVehicles.length);
            this.enemyRosterVehicles = null;
         }
         if(this.enemyRosterSupplies)
         {
            for each(_loc1_ in this.enemyRosterSupplies)
            {
               _loc1_.dispose();
            }
            this.enemyRosterSupplies.splice(0,this.enemyRosterSupplies.length);
            this.enemyRosterSupplies = null;
         }
      }
   }
}
