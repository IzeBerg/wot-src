package net.wg.gui.components.questProgress.components.headerProgress.solid
{
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   
   public class HeaderProgressBigSolid extends HeaderProgressSolid
   {
      
      private static const GREEN_ADDITIONAL_WIDTH:int = 20;
       
      
      public function HeaderProgressBigSolid()
      {
         super();
      }
      
      override protected function setBmFill() : void
      {
         bmFill.source = QUEST_PROGRESS_BASE.HEADER_PROGRESS_BIG_BITMAP_FILL;
         bmFill.heightFill = QUEST_PROGRESS_BASE.HEADER_PROGRESS_BIG_BITMAP_FILL_HEIGHT;
         bmFill.repeat = BitmapFill.REPEAT_HORIZONTAL;
      }
      
      override protected function onDataUpdate(param1:int, param2:IHeaderProgressData) : void
      {
         createPoints(param2.goal,param2.goal,param1 / param2.goal);
         green.width = param1 + GREEN_ADDITIONAL_WIDTH;
         bmFill.widthFill = param1;
      }
      
      override protected function getSeparator() : FrameStateCmpnt
      {
         return App.utils.classFactory.getComponent(QUEST_PROGRESS_BASE.PROGRESS_SOLID_BIG_SEPARATOR_CMPNT,FrameStateCmpnt);
      }
   }
}
