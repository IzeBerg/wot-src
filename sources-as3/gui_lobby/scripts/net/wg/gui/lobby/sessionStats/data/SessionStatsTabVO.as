package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SessionStatsTabVO extends DAAPIDataClass
   {
       
      
      public var alias:String = "";
      
      public var linkage:String = "";
      
      public var tooltip:String = "";
      
      public var label:String = "";
      
      public var selected:Boolean = false;
      
      public function SessionStatsTabVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
