package net.wg.gui.lobby.testView
{
   import flash.text.TextField;
   import net.wg.data.generated.views.TestViewBase;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.NumericStepper;
   
   public class TestView extends TestViewBase
   {
       
      
      public var textField:TextField = null;
      
      public var stepper:NumericStepper = null;
      
      public var checkBox:CheckBox = null;
      
      public function TestView()
      {
         super();
      }
      
      override public function as_destroy() : void
      {
         DebugUtils.LOG_DEBUG("TestView.as_destroy");
         this.stepper.dispose();
         this.stepper = null;
         this.checkBox.dispose();
         this.checkBox = null;
         this.textField = null;
         super.as_destroy();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         testViewModel.registerUpdateCounterCallback(this.updateStepper);
         testViewModel.registerIsActiveCallback(this.updateCheckBox);
         testViewModel.registerUpdateRateCallback(this.updateAlpha);
         testViewModel.titleTextModel.registerUpdateStringIDCallback(this.updateTitle);
         testViewModel.titleTextModel.registerUpdaTextStyleCallback(this.updateStyle);
      }
      
      private function updateStepper() : void
      {
         this.stepper.value = testViewModel.getCounter();
      }
      
      private function updateCheckBox() : void
      {
         this.checkBox.selected = testViewModel.getIsActive();
      }
      
      private function updateAlpha() : void
      {
         alpha = testViewModel.getRate();
      }
      
      private function updateTitle() : void
      {
         this.textField.htmlText = "text id = " + String(testViewModel.titleTextModel.getStringID());
      }
      
      private function updateStyle() : void
      {
         this.textField.htmlText = "style id = " + String(testViewModel.titleTextModel.getTextStyleID());
      }
   }
}
