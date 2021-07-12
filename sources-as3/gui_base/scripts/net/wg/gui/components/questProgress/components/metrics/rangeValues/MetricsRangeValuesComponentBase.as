package net.wg.gui.components.questProgress.components.metrics.rangeValues
{
   import flash.text.TextField;
   import net.wg.gui.components.questProgress.components.metrics.QPMetricsCmptBase;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsRangeVO;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   import net.wg.utils.ICommons;
   import scaleform.gfx.TextFieldEx;
   
   public class MetricsRangeValuesComponentBase extends QPMetricsCmptBase
   {
      
      protected static const VALUES_SEPARATOR:String = "/";
       
      
      public var valueTf:TextField = null;
      
      public var separatorTf:TextField = null;
      
      public var goalTf:TextField = null;
      
      private var _commons:ICommons;
      
      public function MetricsRangeValuesComponentBase()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function doPrepare() : void
      {
         TextFieldEx.setNoTranslate(this.valueTf,true);
         TextFieldEx.setNoTranslate(this.separatorTf,true);
         TextFieldEx.setNoTranslate(this.goalTf,true);
         this.separatorTf.text = VALUES_SEPARATOR;
         this._commons.updateTextFieldSize(this.separatorTf,true,false);
         super.doPrepare();
      }
      
      override protected final function onInit(param1:IQPMetrics) : void
      {
         this.doInit(QPMetricsRangeVO(param1));
         super.onInit(param1);
      }
      
      override protected final function onUpdate(param1:IQPMetrics) : void
      {
         this.doUpdate(QPMetricsRangeVO(param1));
         super.onUpdate(param1);
      }
      
      override protected function onDispose() : void
      {
         this._commons = null;
         this.valueTf = null;
         this.separatorTf = null;
         this.goalTf = null;
         super.onDispose();
      }
      
      protected function doInit(param1:QPMetricsRangeVO) : void
      {
         this.updateValueGoal(param1.value,param1.goal);
      }
      
      protected function doUpdate(param1:QPMetricsRangeVO) : void
      {
         this.updateValueGoal(param1.value,param1.goal);
      }
      
      protected function updateValueGoal(param1:String, param2:String) : void
      {
         this.valueTf.text = param1;
         this.goalTf.text = param2;
      }
   }
}
