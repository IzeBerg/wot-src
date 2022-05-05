package net.wg.gui.battle.views.destroyTimers.data
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_TYPES;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StatusNotificationVO extends DAAPIDataClass
   {
       
      
      public var typeID:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var viewSubType:String = "criticalView";
      
      public var totalTime:Number = -1;
      
      public var currentTime:Number = 0;
      
      public var additionalState:int = -1;
      
      public var additionalInfo:String = "";
      
      public function StatusNotificationVO(param1:Object = null)
      {
         super(param1);
         if(this.totalTime == Values.ZERO)
         {
            this.viewSubType = BATTLE_NOTIFICATIONS_TIMER_TYPES.WARNING_VIEW;
            this.totalTime = Values.DEFAULT_INT;
         }
      }
   }
}
