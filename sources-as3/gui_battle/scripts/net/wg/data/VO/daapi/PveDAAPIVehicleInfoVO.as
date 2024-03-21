package net.wg.data.VO.daapi
{
   public class PveDAAPIVehicleInfoVO extends DAAPIVehicleInfoVO
   {
      
      public static const SHOW:int = 0;
      
      public static const SHOW_WITH_HP:int = 1;
      
      public static const HIDE:int = 2;
       
      
      public var teamPanelMode:int = 0;
      
      public var highlight:Boolean = false;
      
      public var showFrags:Boolean = true;
      
      public var showVehicleTypeIcon:Boolean = false;
      
      public var countLives:int = -1;
      
      public function PveDAAPIVehicleInfoVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
