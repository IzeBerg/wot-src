package net.wg.gui.battle.views.epicDeploymentMap.constants
{
   public class DeploymentMapConstants
   {
      
      public static const SCORE_PANEL_TOP_OFFSET_WITH_VEH_POST_PROGRESSION:int = 61;
      
      public static const SCORE_PANEL_TOP_OFFSET:int = 91;
      
      public static const RESPAWN_ELEMENTS_SIZE:int = 288;
      
      public static const BORDER_WIDTH_PERCENTAGE:Number = 0.125;
      
      public static const RESPAWN_SCALE_FACTOR:Number = 0.85;
       
      
      public function DeploymentMapConstants()
      {
         super();
      }
      
      public static function getScorePanelTopOffset(param1:Boolean) : int
      {
         return !!param1 ? int(SCORE_PANEL_TOP_OFFSET_WITH_VEH_POST_PROGRESSION) : int(SCORE_PANEL_TOP_OFFSET);
      }
   }
}
