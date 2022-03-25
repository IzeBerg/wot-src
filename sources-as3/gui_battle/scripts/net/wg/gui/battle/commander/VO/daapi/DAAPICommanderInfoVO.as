package net.wg.gui.battle.commander.VO.daapi
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPICommanderInfoVO extends DAAPIDataClass
   {
      
      private static const LEFT_COMMANDER_INFO_FIELD_NAME:String = "leftCommanderInfo";
      
      private static const RIGHT_COMMANDER_INFO_FIELD_NAME:String = "rightCommanderInfo";
       
      
      public var leftCommanderInfo:DAAPIVehicleInfoVO = null;
      
      public var rightCommanderInfo:DAAPIVehicleInfoVO = null;
      
      public function DAAPICommanderInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case LEFT_COMMANDER_INFO_FIELD_NAME:
            case RIGHT_COMMANDER_INFO_FIELD_NAME:
               if(param2)
               {
                  this[param1] = new DAAPIVehicleInfoVO(param2);
               }
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.leftCommanderInfo)
         {
            this.leftCommanderInfo.dispose();
            this.leftCommanderInfo = null;
         }
         if(this.rightCommanderInfo)
         {
            this.rightCommanderInfo.dispose();
            this.rightCommanderInfo = null;
         }
         super.onDispose();
      }
   }
}
