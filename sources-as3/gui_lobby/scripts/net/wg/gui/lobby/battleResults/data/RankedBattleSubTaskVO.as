package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankedBattleSubTaskVO extends DAAPIDataClass
   {
       
      
      public var state:String = "";
      
      public var linkage:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var descriptionIcon:String = "";
      
      public var icon:String = "";
      
      public var plateIcon:String = "";
      
      public var shieldIcon:String = "";
      
      public var shieldCount:String = "";
      
      public function RankedBattleSubTaskVO(param1:Object)
      {
         super(param1);
      }
   }
}
