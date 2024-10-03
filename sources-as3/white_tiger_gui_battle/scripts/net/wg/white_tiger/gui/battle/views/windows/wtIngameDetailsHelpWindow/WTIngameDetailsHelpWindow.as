package net.wg.white_tiger.gui.battle.views.windows.wtIngameDetailsHelpWindow
{
   import net.wg.gui.battle.windows.IngameDetailsHelpWindow;
   
   public class WTIngameDetailsHelpWindow extends IngameDetailsHelpWindow
   {
      
      private static const TITLE_Y:uint = 547;
      
      private static const DESCRIPTION_Y:uint = 589;
       
      
      public function WTIngameDetailsHelpWindow()
      {
         super();
         title.y = TITLE_Y;
         description.y = DESCRIPTION_Y;
      }
      
      override protected function updatePageLayout() : void
      {
         App.utils.commons.updateTextFieldSize(description,false,true);
      }
   }
}
