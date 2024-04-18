package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StatItemVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var value:String = "";
      
      public var infoTooltip:String = "";
      
      public function StatItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
