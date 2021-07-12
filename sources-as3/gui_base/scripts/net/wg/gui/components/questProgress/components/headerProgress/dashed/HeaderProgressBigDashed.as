package net.wg.gui.components.questProgress.components.headerProgress.dashed
{
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgressDash;
   
   public class HeaderProgressBigDashed extends HeaderProgressDashed
   {
       
      
      public function HeaderProgressBigDashed()
      {
         super();
      }
      
      override protected function getDashComponent() : IHeaderProgressDash
      {
         return App.utils.classFactory.getComponent(QUEST_PROGRESS_BASE.PROGRESS_DASHED_BIG_DASH,HeaderProgressBigDash);
      }
   }
}
