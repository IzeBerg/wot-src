package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SessionVehicleStatsRendererVO extends DAAPIDataClass
   {
      
      private static const DELTA:String = "delta";
       
      
      public var intCD:uint = 1.0;
      
      public var icon:String = "";
      
      public var label:String = "";
      
      public var level:int = -1;
      
      public var nationIcon:String = "";
      
      public var type:String = "";
      
      public var total:String = "";
      
      public var damage:String = "";
      
      public var wtr:String = "";
      
      public var delta:SessionStatsRateVO = null;
      
      public function SessionVehicleStatsRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param2 && param1 == DELTA)
         {
            this.delta = new SessionStatsRateVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.delta)
         {
            this.delta.dispose();
            this.delta = null;
         }
         super.onDispose();
      }
   }
}
