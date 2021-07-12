package net.wg.infrastructure.tutorial.helpBtnControllers
{
   public class TutorialViewHelpBtnCtrllr extends TutorialHelpBtnController
   {
       
      
      public function TutorialViewHelpBtnCtrllr()
      {
         super();
      }
      
      override public function layoutHelpBtn() : void
      {
         helpBtn.x = model.padding.left != 0 ? Number(model.padding.left) : Number(view.width - model.padding.right);
         helpBtn.y = model.padding.top != 0 ? Number(model.padding.top) : Number(view.height - model.padding.bottom);
      }
   }
}
