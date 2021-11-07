package net.wg.gui.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class WaitingQueueCounterMessageVO extends DAAPIDataClass
   {
      
      private static const TIME_POINTCUTS_FIELD_NAME:String = "timePointcuts";
       
      
      public var timePointcuts:WaitingPointcutsVO;
      
      public var updatePeriod:int = -1;
      
      public function WaitingQueueCounterMessageVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TIME_POINTCUTS_FIELD_NAME)
         {
            this.timePointcuts = new WaitingPointcutsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.timePointcuts != null)
         {
            this.timePointcuts.dispose();
            this.timePointcuts = null;
         }
         super.onDispose();
      }
   }
}
