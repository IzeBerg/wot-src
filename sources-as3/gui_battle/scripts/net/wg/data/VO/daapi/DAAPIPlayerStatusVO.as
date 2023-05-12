package net.wg.data.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIPlayerStatusVO extends DAAPIDataClass
   {
       
      
      public var vehicleID:Number = 0;
      
      public var status:uint = 0;
      
      public var isEnemy:Boolean = false;
      
      public function DAAPIPlayerStatusVO(param1:Object)
      {
         super(param1);
      }
   }
}
