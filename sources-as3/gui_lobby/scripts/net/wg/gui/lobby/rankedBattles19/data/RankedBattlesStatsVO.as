package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankedBattlesStatsVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var value:String = "";
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public function RankedBattlesStatsVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[RankedBattlesStatsVO > icon: " + this.icon + ", value: " + this.value + ", label:" + this.label + "]";
      }
   }
}
