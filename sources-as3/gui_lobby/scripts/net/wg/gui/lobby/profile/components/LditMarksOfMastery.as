package net.wg.gui.lobby.profile.components
{
   import net.wg.gui.components.advanced.LineDescrIconText;
   
   public class LditMarksOfMastery extends LineDescrIconText
   {
       
      
      public function LditMarksOfMastery()
      {
         super();
      }
      
      override protected function applyText(param1:String) : void
      {
         super.applyText(param1);
         invalidate(DESCRIPTION_TEXT_INVALID);
      }
   }
}
