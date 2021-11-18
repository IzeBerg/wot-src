package net.wg.gui.lobby.retrainCrewWindow
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RetrainTankmanVO extends DAAPIDataClass
   {
       
      
      public var iconPath:String = "";
      
      public var tankmanID:int;
      
      public var nativeVehicleType:String = "";
      
      public var nativeVehicleIntCD:int;
      
      public var nationID:int;
      
      public var roleLevel:Number;
      
      public var realRoleLevel:Number;
      
      public function RetrainTankmanVO(param1:Object)
      {
         super(param1);
      }
   }
}
