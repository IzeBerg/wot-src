package net.wg.gui.battle.views.destroyTimers
{
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_TYPES;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   
   public class PoiSecondaryTimer extends SecondaryTimer
   {
      
      private static const COOLDOWN_ICON_ALPHA:Number = 0.66;
       
      
      private var _typeID:String = "";
      
      public function PoiSecondaryTimer()
      {
         super();
      }
      
      override public function setStaticText(param1:String, param2:String = "") : void
      {
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
      
      override protected function configUI() : void
      {
         super.configUI();
         cropSize();
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
   }
}
