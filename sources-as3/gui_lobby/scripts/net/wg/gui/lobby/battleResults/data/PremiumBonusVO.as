package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PremiumBonusVO extends DAAPIDataClass
   {
       
      
      public var description:String = "";
      
      public var bonusLeft:String = "";
      
      public var xpValue:String = "";
      
      public var statusBonusLabel:String = "";
      
      public var statusBonusTooltip:String = "";
      
      public var bonusIcon:String = "";
      
      public function PremiumBonusVO(param1:Object)
      {
         super(param1);
      }
   }
}
