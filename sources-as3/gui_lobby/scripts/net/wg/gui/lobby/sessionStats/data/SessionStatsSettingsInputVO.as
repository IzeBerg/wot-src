package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SessionStatsSettingsInputVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public var selected:Boolean = false;
      
      public function SessionStatsSettingsInputVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
