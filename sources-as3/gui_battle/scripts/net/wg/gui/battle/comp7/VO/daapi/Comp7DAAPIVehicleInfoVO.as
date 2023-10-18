package net.wg.gui.battle.comp7.VO.daapi
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   
   public class Comp7DAAPIVehicleInfoVO extends DAAPIVehicleInfoVO
   {
       
      
      public var role:String = "";
      
      public var skillLevel:uint = 0;
      
      public var rank:int = -1;
      
      public var rankDivision:int = -1;
      
      public var voiceChatConnected:Boolean = true;
      
      public function Comp7DAAPIVehicleInfoVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
