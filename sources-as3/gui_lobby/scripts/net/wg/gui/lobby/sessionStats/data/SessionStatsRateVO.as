package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SessionStatsRateVO extends DAAPIDataClass
   {
       
      
      public var value:String = "";
      
      public var icon:String = "";
      
      public function SessionStatsRateVO(param1:Object)
      {
         super(param1);
      }
   }
}
