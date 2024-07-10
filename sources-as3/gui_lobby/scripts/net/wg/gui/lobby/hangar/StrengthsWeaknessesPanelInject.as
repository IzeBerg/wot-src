package net.wg.gui.lobby.hangar
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class StrengthsWeaknessesPanelInject extends GFInjectComponent
   {
      
      public static const STRENGTHS_WEAKNESSES_PANEL_INJECT_OFFSET_Y:int = 110;
      
      private static const STRENGTHS_WEAKNESSES_PANEL_INJECT_WIDTH:int = 349;
      
      private static const STRENGTHS_WEAKNESSES_PANEL_INJECT_HEIGHT:int = 501;
      
      private static const STRENGTHS_WEAKNESSES_NAME:String = "strengthsWeaknessesPanel";
       
      
      public function StrengthsWeaknessesPanelInject()
      {
         super();
         width = STRENGTHS_WEAKNESSES_PANEL_INJECT_WIDTH;
         height = STRENGTHS_WEAKNESSES_PANEL_INJECT_HEIGHT;
         name = STRENGTHS_WEAKNESSES_NAME;
      }
   }
}
