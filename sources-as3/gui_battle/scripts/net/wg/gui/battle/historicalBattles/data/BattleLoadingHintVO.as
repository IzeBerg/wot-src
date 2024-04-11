package net.wg.gui.battle.historicalBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleLoadingHintVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var background:String = "";
      
      public function BattleLoadingHintVO(param1:Object)
      {
         super(param1);
      }
   }
}
