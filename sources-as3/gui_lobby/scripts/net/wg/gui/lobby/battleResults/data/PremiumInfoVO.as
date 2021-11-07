package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PremiumInfoVO extends DAAPIDataClass
   {
       
      
      public var creditsPremiumBonusStr:String = "";
      
      public var xpPremiumBonusStr:String = "";
      
      public var premiumBonusStr:String = "";
      
      public var backgroundIcon:String = "";
      
      public var isGetPremium:Boolean = false;
      
      public var isUpgradeToPremiumPlus:Boolean = false;
      
      public var visibleDetailsBtn:Boolean = false;
      
      public var inBattleQueue:Boolean = false;
      
      public function PremiumInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
