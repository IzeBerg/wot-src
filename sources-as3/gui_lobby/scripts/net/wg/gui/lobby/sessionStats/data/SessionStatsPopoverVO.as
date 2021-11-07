package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SessionStatsPopoverVO extends DAAPIDataClass
   {
       
      
      public var alias:String = "";
      
      public var linkage:String = "";
      
      public function SessionStatsPopoverVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
