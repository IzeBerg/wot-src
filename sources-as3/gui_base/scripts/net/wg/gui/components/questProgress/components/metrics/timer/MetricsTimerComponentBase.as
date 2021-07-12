package net.wg.gui.components.questProgress.components.metrics.timer
{
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.components.metrics.QPMetricsCmptBase;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsTimerVO;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   
   public class MetricsTimerComponentBase extends QPMetricsCmptBase
   {
      
      private static const CRITICAL_TIMER_HIDE_TIME:int = 500;
       
      
      public var timerTf:TextField = null;
      
      private var _status:String = "";
      
      private var _intervalId:Number = -1;
      
      public function MetricsTimerComponentBase()
      {
         super();
      }
      
      override protected final function onInit(param1:IQPMetrics) : void
      {
         this.doInit(QPMetricsTimerVO(param1));
         super.onInit(param1);
      }
      
      override protected final function onUpdate(param1:IQPMetrics) : void
      {
         this.doUpdate(QPMetricsTimerVO(param1));
         super.onUpdate(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this._intervalId != Values.DEFAULT_INT)
         {
            clearTimeout(this._intervalId);
            this._intervalId = Values.DEFAULT_INT;
         }
         this.timerTf = null;
         super.onDispose();
      }
      
      override protected function doUpdateState(param1:int) : void
      {
         this.timerTf.visible = !isFailed;
         super.doUpdateState(param1);
      }
      
      protected function doInit(param1:QPMetricsTimerVO) : void
      {
         this.updateValues(param1);
      }
      
      protected function doUpdate(param1:QPMetricsTimerVO) : void
      {
         this.updateValues(param1);
      }
      
      protected function updateValues(param1:QPMetricsTimerVO) : void
      {
         this.timerTf.text = param1.time;
         this.doUpdateTimerStatus(param1.status);
      }
      
      protected function doUpdateTimerStatus(param1:String) : void
      {
         var _loc2_:uint = 0;
         if(this._status != param1)
         {
            this._status = param1;
            _loc2_ = this.getColor(this._status);
            this.timerTf.textColor = _loc2_;
         }
         if(this._status == QUEST_PROGRESS_BASE.QP_TIMER_STATE_CRITICAL)
         {
            this.timerTf.visible = false;
            this._intervalId = setTimeout(this.changeTimerVisibility,CRITICAL_TIMER_HIDE_TIME);
         }
         else if(param1 == QUEST_PROGRESS_BASE.QP_TIMER_STATE_WAS_COMPLETED)
         {
            this.timerTf.visible = true;
         }
      }
      
      private function getColor(param1:String) : uint
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.QP_TIMER_STATE_NORMAL:
               return QUEST_PROGRESS_BASE.QP_TEXT_COLOR_STATE_IN_PROGRESS_VALUE;
            case QUEST_PROGRESS_BASE.QP_TIMER_STATE_WARNING:
            case QUEST_PROGRESS_BASE.QP_TIMER_STATE_CRITICAL:
            case QUEST_PROGRESS_BASE.QP_TIMER_STATE_WAS_COMPLETED:
               return QUEST_PROGRESS_BASE.QP_TEXT_COLOR_STATE_FAILD_VALUE;
            default:
               return QUEST_PROGRESS_BASE.QP_TEXT_COLOR_STATE_IN_PROGRESS_VALUE;
         }
      }
      
      private function changeTimerVisibility() : void
      {
         this.timerTf.visible = true;
         clearTimeout(this._intervalId);
         this._intervalId = Values.DEFAULT_INT;
      }
   }
}
