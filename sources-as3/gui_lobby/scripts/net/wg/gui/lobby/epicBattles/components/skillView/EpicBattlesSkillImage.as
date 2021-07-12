package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.filters.ColorMatrixFilter;
   import net.wg.gui.components.controls.Image;
   
   public class EpicBattlesSkillImage extends Image
   {
      
      private static const DESATURATION_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.3086,0.6094,0.082,0,-20,0.3086,0.6094,0.082,0,-20,0.3086,0.6094,0.082,0,-20,0,0,0,1,0]);
       
      
      public function EpicBattlesSkillImage()
      {
         super();
      }
      
      public function switchColorization(param1:Boolean) : void
      {
         if(param1)
         {
            filters = [];
         }
         else
         {
            filters = [DESATURATION_FILTER];
         }
      }
   }
}
