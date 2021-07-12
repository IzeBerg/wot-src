package net.wg.gui.components.questProgress.components.headerProgress.dashed
{
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.controls.BitmapFill;
   
   public class HeaderProgressBigDash extends HeaderProgressDash
   {
      
      private static const DASH_HORIZONTAL_ADDITIONAL_WIDTH:int = 25;
       
      
      public function HeaderProgressBigDash()
      {
         super();
      }
      
      override protected function setBmFill() : void
      {
         bmFill.source = QUEST_PROGRESS_BASE.HEADER_PROGRESS_BIG_BITMAP_FILL;
         bmFill.heightFill = QUEST_PROGRESS_BASE.HEADER_PROGRESS_BIG_BITMAP_FILL_HEIGHT;
         bmFill.repeat = BitmapFill.REPEAT_HORIZONTAL;
      }
      
      override protected function getDashHorizontalAdditionalWidth() : int
      {
         return DASH_HORIZONTAL_ADDITIONAL_WIDTH;
      }
   }
}
