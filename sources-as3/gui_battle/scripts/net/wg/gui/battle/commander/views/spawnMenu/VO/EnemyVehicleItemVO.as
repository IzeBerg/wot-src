package net.wg.gui.battle.commander.views.spawnMenu.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   
   public class EnemyVehicleItemVO extends DAAPIDataClass
   {
      
      private static const _BADGE_FIELD:String = "badgeData";
       
      
      public var vehicleID:int = 0;
      
      public var vehicleName:String = "";
      
      public var vehicleType:String = "";
      
      public var vehicleLevel:int = 0;
      
      public var playerName:String = "";
      
      public var vehicleContour:String = "";
      
      public var badgeData:BadgeVisualVO = null;
      
      public var suffixBadgeType:String = "";
      
      public var suffixBadgeStripType:String = "";
      
      public function EnemyVehicleItemVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == _BADGE_FIELD)
         {
            this.badgeData = new BadgeVisualVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.badgeData)
         {
            this.badgeData.dispose();
            this.badgeData = null;
         }
         super.onDispose();
      }
   }
}
