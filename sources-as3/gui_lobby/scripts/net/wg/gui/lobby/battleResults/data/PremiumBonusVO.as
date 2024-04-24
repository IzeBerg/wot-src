package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PremiumBonusVO extends DAAPIDataClass
   {
       
      
      public var description:String = "";
      
      public var bonusLeft:String = "";
      
      public var wotPlusBonusLeft:String = "";
      
      public var detailsLink:String = "";
      
      public var additionalBonusLeft:String = "";
      
      public var xpValue:String = "";
      
      public var statusBonusLabel:String = "";
      
      public var statusBonusTooltip:String = "";
      
      public var bonusIcon:String = "";
      
      public var premiumAndPlusExhausted:String = "";
      
      public var hasWotPremium:Boolean = false;
      
      public var hasWotPlus:Boolean = false;
      
      public function PremiumBonusVO(param1:Object)
      {
         super(param1);
      }
   }
}
