package net.wg.gui.battle.eventBattle.views.eventStats.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   
   public class EventStatsPlayerVO extends DAAPIDataClass
   {
      
      private static const BADGE_FIELD_NAME:String = "badgeVisualVO";
       
      
      public var playerName:String = "";
      
      public var squadIndex:String = "";
      
      public var suffixBadgeIcon:String = "";
      
      public var suffixBadgeStripIcon:String = "";
      
      public var vehicleTypeIcon:String = "";
      
      public var energy:String = "";
      
      public var damage:String = "";
      
      public var blocked:String = "";
      
      public var kills:String = "";
      
      public var vehicleName:String = "";
      
      public var isAlive:Boolean = true;
      
      public var isSquad:Boolean = false;
      
      public var isPlayerHimself:Boolean = false;
      
      public var badgeVisualVO:BadgeVisualVO = null;
      
      public function EventStatsPlayerVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BADGE_FIELD_NAME && param2 != null)
         {
            this.badgeVisualVO = new BadgeVisualVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.badgeVisualVO)
         {
            this.badgeVisualVO.dispose();
            this.badgeVisualVO = null;
         }
         super.onDispose();
      }
   }
}
