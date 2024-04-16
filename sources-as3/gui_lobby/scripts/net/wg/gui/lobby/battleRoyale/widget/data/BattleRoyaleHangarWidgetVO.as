package net.wg.gui.lobby.battleRoyale.widget.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.hangar.data.AlertMessageBlockVO;
   
   public class BattleRoyaleHangarWidgetVO extends DAAPIDataClass
   {
      
      private static const CALENDAR_STATUS_LBL:String = "calendarStatus";
       
      
      public var calendarStatus:AlertMessageBlockVO = null;
      
      public var tooltipId:String = "";
      
      public var showAlert:Boolean = false;
      
      public function BattleRoyaleHangarWidgetVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.calendarStatus != null)
         {
            this.calendarStatus.dispose();
            this.calendarStatus = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == CALENDAR_STATUS_LBL)
         {
            this.calendarStatus = new AlertMessageBlockVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
