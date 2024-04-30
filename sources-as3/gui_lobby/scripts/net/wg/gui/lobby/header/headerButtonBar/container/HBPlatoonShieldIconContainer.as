package net.wg.gui.lobby.header.headerButtonBar.container
{
   import net.wg.gui.lobby.header.headerButtonBar.HBC_HBSquad;
   
   public class HBPlatoonShieldIconContainer extends PlatoonShieldIconContainer
   {
      
      public static const PLAYERS:Object = {
         "current":0,
         "left":1,
         "right":2,
         "hb1":3,
         "hb2":4
      };
       
      
      public function HBPlatoonShieldIconContainer()
      {
         super();
      }
      
      override protected function getPlatoonSize() : int
      {
         return HBC_HBSquad.HB_SIZE_PLATOON;
      }
      
      override protected function getPlayers() : Object
      {
         return PLAYERS;
      }
   }
}
