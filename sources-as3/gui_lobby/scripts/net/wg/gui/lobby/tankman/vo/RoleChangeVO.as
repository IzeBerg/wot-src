package net.wg.gui.lobby.tankman.vo
{
   import net.wg.data.VO.TankmanCardVO;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RoleChangeVO extends DAAPIDataClass
   {
      
      private static var TANKMAN_MODEL:String = "tankmanModel";
      
      private static var VEHICLES:String = "vehicles";
       
      
      public var tankmanModel:TankmanCardVO = null;
      
      public var vehicles:VehicleSelectionVO;
      
      public var role:String = "";
      
      public var roleIcon:String = "";
      
      public function RoleChangeVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case TANKMAN_MODEL:
               this.tankmanModel = new TankmanCardVO(param2);
               return false;
            case VEHICLES:
               this.vehicles = new VehicleSelectionVO(param2);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         this.tankmanModel.dispose();
         this.tankmanModel = null;
         this.vehicles.dispose();
         this.vehicles = null;
         super.onDispose();
      }
   }
}
