package net.wg.gui.battle.historicalBattles.battleHints.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HintInfoVO extends DAAPIDataClass
   {
       
      
      public var message:String = "";
      
      public var iconSource:String = "";
      
      public var iconSourceBlind:String = "";
      
      public function HintInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
