package net.wg.gui.battle.views.destroyTimers
{
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_TYPES;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   
   public class PoiMainTimer extends DestroyTimer
   {
      
      private static const ICON_CRITICAL_Y_POS:int = -21;
      
      private static const MOVE_ICON_STEPS:int = 21;
      
      private static const COOLDOWN_ICON_ALPHA:Number = 0.66;
       
      
      private var _typeID:String = "";
      
      public function PoiMainTimer()
      {
         super();
      }
      
      override public function setStaticText(param1:String, param2:String = "") : void
      {
         desc.label = param1;
      }
      
      override public function updateData(param1:StatusNotificationVO) : void
      {
         this._typeID = param1.typeID;
         super.updateData(param1);
      }
      
      override public function updateViewID(param1:String, param2:Boolean, param3:int = -1) : void
      {
         super.updateViewID(param1,param2,param3);
         setIsMaxProgress(param1 == BATTLE_NOTIFICATIONS_TIMER_TYPES.WARNING_VIEW);
      }
      
      override protected function updateIcon() : void
      {
         super.updateIcon();
         if(iconBitmap)
         {
            if(this._typeID == BATTLE_NOTIFICATIONS_TIMER_TYPES.POI_COOLDOWN)
            {
               iconBitmap.alpha = COOLDOWN_ICON_ALPHA;
            }
            else
            {
               iconBitmap.alpha = 1;
            }
         }
      }
      
      override protected function get iconCriticalYPos() : int
      {
         return ICON_CRITICAL_Y_POS;
      }
      
      override protected function get moveIconSteps() : int
      {
         return MOVE_ICON_STEPS;
      }
   }
}
