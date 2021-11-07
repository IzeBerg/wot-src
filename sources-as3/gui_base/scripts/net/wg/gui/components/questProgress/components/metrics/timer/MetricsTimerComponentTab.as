package net.wg.gui.components.questProgress.components.metrics.timer
{
   import flash.text.TextField;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsTimerVO;
   
   public class MetricsTimerComponentTab extends MetricsTimerComponentBase
   {
      
      private static const TIMER_GAP:int = 0;
       
      
      public var titleTf:TextField = null;
      
      public function MetricsTimerComponentTab()
      {
         super();
      }
      
      override protected function doUpdateState(param1:int) : void
      {
         this.titleTf.visible = !isFailed;
         super.doUpdateState(param1);
      }
      
      override protected function doInit(param1:QPMetricsTimerVO) : void
      {
         this.titleTf.text = param1.title;
         App.utils.commons.updateTextFieldSize(this.titleTf,true,false);
         this.initLayout();
         super.doInit(param1);
      }
      
      override protected function onDispose() : void
      {
         this.titleTf = null;
         super.onDispose();
      }
      
      private function initLayout() : void
      {
         timerTf.x = this.titleTf.x + this.titleTf.width + TIMER_GAP;
         super.doLayout();
      }
   }
}
