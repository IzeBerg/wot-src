package net.wg.gui.components.questProgress.components.headerProgress.iconDashed
{
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgressDash;
   
   public class HeaderProgressBigIconDashed extends HeaderProgressIconDashed
   {
      
      private static const DASH_GAP:int = 37;
       
      
      public function HeaderProgressBigIconDashed()
      {
         super();
      }
      
      override protected function getDashComponent() : IHeaderProgressDash
      {
         return App.utils.classFactory.getComponent(QUEST_PROGRESS_BASE.PROGRESS_DASHED_BIG_DASH_ICON,HeaderProgressBigIconDash);
      }
      
      override protected function getDashGap() : int
      {
         return DASH_GAP;
      }
   }
}
