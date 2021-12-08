package net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   
   public class DAAPIPlayerPanelInfoVO extends DAAPIDataClass
   {
      
      private static const BADGE_FIELD:String = "badgeVO";
       
      
      public var name:String = "";
      
      public var nameVehicle:String = "";
      
      public var typeVehicle:String = "";
      
      public var hpMax:int = 0;
      
      public var hpCurrent:int = 0;
      
      public var vehID:uint = 0;
      
      public var isSquad:Boolean = false;
      
      public var isResurrect:Boolean = false;
      
      public var countPoints:int = 0;
      
      public var badgeVO:BadgeVisualVO = null;
      
      public var suffixBadgeIcon:String = "";
      
      public var suffixBadgeStripIcon:String = "";
      
      public function DAAPIPlayerPanelInfoVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BADGE_FIELD)
         {
            this.badgeVO = new BadgeVisualVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.badgeVO)
         {
            this.badgeVO.dispose();
            this.badgeVO = null;
         }
         super.onDispose();
      }
   }
}
