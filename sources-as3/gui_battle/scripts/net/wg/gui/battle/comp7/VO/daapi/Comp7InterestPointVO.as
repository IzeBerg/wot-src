package net.wg.gui.battle.comp7.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class Comp7InterestPointVO extends DAAPIDataClass
   {
       
      
      public var vehicleID:int = -1;
      
      public var type:uint = 1;
      
      public var progress:Number = 0;
      
      public function Comp7InterestPointVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
