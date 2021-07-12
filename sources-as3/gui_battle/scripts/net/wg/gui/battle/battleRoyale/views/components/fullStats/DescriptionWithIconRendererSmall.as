package net.wg.gui.battle.battleRoyale.views.components.fullStats
{
   public class DescriptionWithIconRendererSmall extends DescriptionWithIconRenderer
   {
      
      private static const SMALL_POSTFIX:String = "_small";
       
      
      public function DescriptionWithIconRendererSmall()
      {
         super();
         iconPostfix = SMALL_POSTFIX;
      }
   }
}
