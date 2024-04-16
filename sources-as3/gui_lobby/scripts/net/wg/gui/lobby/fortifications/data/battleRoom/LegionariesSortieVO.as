package net.wg.gui.lobby.fortifications.data.battleRoom
{
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   
   public class LegionariesSortieVO extends SortieVO
   {
      
      private static const ALERT_VIEW:String = "alertView";
       
      
      public var isShowAlertView:Boolean = false;
      
      public var alertView:SortieAlertViewVO = null;
      
      public function LegionariesSortieVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ALERT_VIEW && param2 != null)
         {
            this.alertView = new SortieAlertViewVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function initSlotsVO(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:LegionariesSlotsVO = null;
         slots = new Vector.<IRallySlotVO>();
         var _loc2_:Array = param1 as Array;
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = new LegionariesSlotsVO(_loc3_);
            slots.push(_loc4_);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.alertView)
         {
            this.alertView.dispose();
            this.alertView = null;
         }
         super.onDispose();
      }
   }
}
