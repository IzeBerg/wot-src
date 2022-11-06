package net.wg.gui.components.questProgress.components.headerProgress.iconDashed
{
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.controls.BitmapFill;
   
   public class HeaderProgressBigIconDash extends HeaderProgressIconDash
   {
      
      private static const DASH_HORIZONTAL_ADDITIONAL_WIDTH:int = 25;
      
      private static const ICO_X_SHIFT:int = 9;
       
      
      public function HeaderProgressBigIconDash()
      {
         super();
      }
      
      override protected function setBmFill() : void
      {
         bmFill.source = QUEST_PROGRESS_BASE.HEADER_PROGRESS_BIG_BITMAP_FILL;
         bmFill.heightFill = QUEST_PROGRESS_BASE.HEADER_PROGRESS_BIG_BITMAP_FILL_HEIGHT;
         bmFill.repeat = BitmapFill.REPEAT_HORIZONTAL;
      }
      
      override protected function getIcoXShift() : int
      {
         return ICO_X_SHIFT;
      }
      
      override protected function getDashHorizontalAdditionalWidth() : int
      {
         return DASH_HORIZONTAL_ADDITIONAL_WIDTH;
      }
   }
}
