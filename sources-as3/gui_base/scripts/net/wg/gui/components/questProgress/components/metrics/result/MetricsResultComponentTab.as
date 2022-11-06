package net.wg.gui.components.questProgress.components.metrics.result
{
   import flash.text.TextField;
   import net.wg.gui.components.questProgress.components.metrics.QPMetricsCmptBase;
   
   public class MetricsResultComponentTab extends QPMetricsCmptBase
   {
       
      
      public var completeTf:TextField = null;
      
      public function MetricsResultComponentTab()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.completeTf = null;
      }
      
      override protected function doPrepare() : void
      {
         super.doPrepare();
         this.completeTf.text = QUESTS.METRICS_STATE_DONE;
         App.utils.commons.updateTextFieldSize(this.completeTf,true,false);
         componentWidth = this.completeTf.x + this.completeTf.width;
      }
   }
}
