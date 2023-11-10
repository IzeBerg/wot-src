package net.wg.data.generated.views
{
   import flash.events.Event;
   import net.wg.data.generated.models.DemoViewModel;
   import net.wg.gui.data.ViewModel;
   import net.wg.infrastructure.base.ComponentWithModel;
   
   public class DemoViewBase extends ComponentWithModel
   {
       
      
      protected var demoViewModel:DemoViewModel = null;
      
      public function DemoViewBase()
      {
         super();
      }
      
      override public function dispose() : void
      {
         this.demoViewModel = null;
         this.demoViewModel.removeEventListener(Event.CHANGE,this.onChangeHandler);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         this.demoViewModel = new DemoViewModel();
         viewModel = this.demoViewModel;
         this.demoViewModel.registerUpdateXCallback(this.updateX);
         this.demoViewModel.registerUpdateYCallback(this.updateY);
         this.demoViewModel.addEventListener(Event.CHANGE,this.onChangeHandler);
      }
      
      private function updateX() : void
      {
         x = this.demoViewModel.getValue(0,ViewModel.INT_TYPE);
      }
      
      private function updateY() : void
      {
         y = this.demoViewModel.getValue(1,ViewModel.INT_TYPE);
      }
      
      protected function onChangeHandler(param1:Event) : void
      {
         layout();
      }
   }
}
