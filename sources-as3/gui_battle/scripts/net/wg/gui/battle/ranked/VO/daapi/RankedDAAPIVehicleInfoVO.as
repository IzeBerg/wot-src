package net.wg.gui.battle.ranked.VO.daapi
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   
   public class RankedDAAPIVehicleInfoVO extends DAAPIVehicleInfoVO
   {
       
      
      public var level:int;
      
      public var division:int;
      
      public var isGroup:Boolean;
      
      public function RankedDAAPIVehicleInfoVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
