package net.wg.gui.lobby.testView.generated.views
{
   import net.wg.gui.lobby.testView.generated.models.TestViewModel;
   import net.wg.infrastructure.base.ComponentWithModel;
   
   public class TestViewBase extends ComponentWithModel
   {
       
      
      protected var testViewModel:TestViewModel;
      
      public function TestViewBase()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         this.testViewModel = new TestViewModel();
         viewModel = this.testViewModel;
      }
      
      private function updateAlpha() : void
      {
         alpha = this.testViewModel.getRate();
      }
   }
}
