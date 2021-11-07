package net.wg.gui.lobby.header.vo
{
   public class HBC_SettingsVo extends HBC_AbstractVO
   {
       
      
      public var serverName:String = "";
      
      public var pingStatus:int = -1;
      
      public var isColorBlind:Boolean = false;
      
      public function HBC_SettingsVo()
      {
         super();
      }
   }
}
