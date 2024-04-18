package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SessionStatsSettingsHeaderVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var resetBtnIcon:String = "";
      
      public var resetBtnTooltip:String = "";
      
      public var resetBtnEnabled:Boolean = false;
      
      public function SessionStatsSettingsHeaderVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
