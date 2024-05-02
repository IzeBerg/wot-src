package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class SessionVehicleStatsViewVO extends DAAPIDataClass
   {
      
      private static const VEHICLES:String = "vehicles";
       
      
      public var vehicles:DataProvider = null;
      
      public var headerName:String = "";
      
      public var headerTotalIcon:String = "";
      
      public var headerTotalTooltip:String = "";
      
      public var headerDamageIcon:String = "";
      
      public var headerDamageTooltip:String = "";
      
      public var headerWtrIcon:String = "";
      
      public var headerWtrTooltip:String = "";
      
      public function SessionVehicleStatsViewVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == VEHICLES)
         {
            this.vehicles = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.vehicles.push(new SessionVehicleStatsRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.vehicles)
         {
            for each(_loc1_ in this.vehicles)
            {
               _loc1_.dispose();
            }
            this.vehicles.cleanUp();
            this.vehicles = null;
         }
         super.onDispose();
      }
   }
}
