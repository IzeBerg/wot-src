package net.wg.gui.battle.commander.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIVehicleCommanderDataVO extends DAAPIDataClass
   {
       
      
      public var vehicleID:Number = 0;
      
      public var isAttached:Boolean = false;
      
      public var hasCommanderData:Boolean = false;
      
      public var manner:Number = 0;
      
      public var order:Number = 0;
      
      public var health:Number = 0;
      
      public var maxHealth:Number = 0;
      
      public function DAAPIVehicleCommanderDataVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
