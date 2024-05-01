package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AwardDivisionBaseVO extends DAAPIDataClass
   {
       
      
      public var division:int = -1;
      
      public var newDivision:int = -1;
      
      public function AwardDivisionBaseVO(param1:Object)
      {
         super(param1);
      }
   }
}
