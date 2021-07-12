package net.wg.gui.components.questProgress.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsLimiterVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsRangeVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsSimpleVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsSimpleValueVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsTimerVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsVehicleVO;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   
   public class QPProgressVO extends DAAPIDataClass implements IQPProgressData
   {
      
      private static const METRICS_FIELD:String = "metrics";
      
      private static const METRICS_TYPE_FIELD:String = "mType";
       
      
      private var _metrics:Vector.<IQPMetrics> = null;
      
      private var _current:Number = -1;
      
      private var _goal:Number = -1;
      
      private var _state:int = -1;
      
      private var _isHidden:Boolean = false;
      
      private var _isLocked:Boolean = false;
      
      private var _rawData:Object = null;
      
      public function QPProgressVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function fromHash(param1:Object) : void
      {
         this._rawData = param1;
         super.fromHash(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         if(param1 == METRICS_FIELD)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            this._metrics = new Vector.<IQPMetrics>();
            _loc4_ = Values.EMPTY_STR;
            for each(_loc5_ in _loc3_)
            {
               if(_loc5_.hasOwnProperty(METRICS_TYPE_FIELD))
               {
                  _loc4_ = _loc5_[METRICS_TYPE_FIELD];
                  this._metrics.push(this.createMetric(_loc4_,_loc5_));
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IQPMetrics = null;
         if(this._metrics)
         {
            for each(_loc1_ in this._metrics)
            {
               _loc1_.dispose();
            }
            this._metrics.splice(0,this._metrics.length);
            this._metrics = null;
         }
         App.utils.data.cleanupDynamicObject(this._rawData);
         this._rawData = null;
         super.onDispose();
      }
      
      public function cloneObj() : IQPProgressData
      {
         return new QPProgressVO(this._rawData);
      }
      
      private function createMetric(param1:String, param2:Object) : IQPMetrics
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_SIMPLE:
               return new QPMetricsSimpleVO(param2);
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_SIMPLE_VALUE:
               return new QPMetricsSimpleValueVO(param2);
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_RANGE:
               return new QPMetricsRangeVO(param2);
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_VEHICLES:
               return new QPMetricsVehicleVO(param2);
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_TIMER:
               return new QPMetricsTimerVO(param2);
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_LIMITER:
               return new QPMetricsLimiterVO(param2);
            default:
               App.utils.asserter.assert(false,"Metrics component type:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      public function get current() : Number
      {
         return this._current;
      }
      
      public function set current(param1:Number) : void
      {
         this._current = param1;
      }
      
      public function get goal() : Number
      {
         return this._goal;
      }
      
      public function set goal(param1:Number) : void
      {
         this._goal = param1;
      }
      
      public function get isNotStarted() : Boolean
      {
         return this._state == QUEST_PROGRESS_BASE.NOT_STARTED_STATE;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(param1:int) : void
      {
         this._state = param1;
      }
      
      public function get isHidden() : Boolean
      {
         return this._isHidden;
      }
      
      public function set isHidden(param1:Boolean) : void
      {
         this._isHidden = param1;
      }
      
      public function get isCompleted() : Boolean
      {
         return this._state == QUEST_PROGRESS_BASE.COMPLETED_STATE;
      }
      
      public function get isConflict() : Boolean
      {
         return this._state == QUEST_PROGRESS_BASE.PRELIMINARY_FAILED_STATE;
      }
      
      public function get isFailed() : Boolean
      {
         return this._state == QUEST_PROGRESS_BASE.FAILED_STATE;
      }
      
      public function get isInProgress() : Boolean
      {
         return this._state == QUEST_PROGRESS_BASE.IN_PROGRESS_STATE;
      }
      
      public function get isLocked() : Boolean
      {
         return this._isLocked;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         this._isLocked = param1;
      }
      
      public function get metricsValue() : Vector.<IQPMetrics>
      {
         return this._metrics;
      }
      
      public function set metricsValue(param1:Vector.<IQPMetrics>) : void
      {
         this._metrics = param1;
      }
   }
}
