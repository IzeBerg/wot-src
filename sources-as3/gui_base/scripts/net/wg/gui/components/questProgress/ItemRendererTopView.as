package net.wg.gui.components.questProgress
{
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUESTSPROGRESS;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.interfaces.components.IMetricsComponent;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemRenderer;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ItemRendererTopView extends ItemRenderer implements IQPItemRenderer
   {
      
      private static const METRICS_POINT_Y:int = 15;
      
      private static const ADDITIONAL_METRIC_POINT_Y:int = 40;
      
      private static const ITEM_UNLOCK_STATE:String = "unlock";
       
      
      public var resultStateIco:QuestProgressAtlasSprite = null;
      
      private var _mainMetricIndex:int = -1;
      
      private var _metricsCmpnt:IMetricsComponent = null;
      
      private var _metricsAdditionalCmpnt:IMetricsComponent = null;
      
      private var _additionalMetricIndex:int = -1;
      
      private var _isLocked:Boolean = false;
      
      private var _isCompleted:Boolean = false;
      
      private var _isFailed:Boolean = false;
      
      public function ItemRendererTopView()
      {
         super();
         this.resultStateIco.isCentralize = true;
      }
      
      private static function setBlendModeToMetric(param1:IMetricsComponent) : void
      {
         param1.blendMode = BlendMode.SCREEN;
      }
      
      override public function init(param1:IQPInitData) : void
      {
         this._mainMetricIndex = param1.topMetricIndex;
         super.init(param1);
      }
      
      override public function unlock() : void
      {
         gotoAndPlay(ITEM_UNLOCK_STATE);
         chartView.unlock();
         this._isLocked = false;
         this.updateCmps();
      }
      
      override protected function updateState(param1:IQPProgressData) : void
      {
         this._isCompleted = param1.isCompleted;
         this._isFailed = param1.isFailed;
         this._isLocked = this._isLocked || param1.isLocked;
         this.updateCmps();
         super.updateState(param1);
      }
      
      override protected function doInitMetrics(param1:Vector.<IQPMetrics>, param2:int) : void
      {
         var _loc7_:String = null;
         var _loc3_:IQPMetrics = null;
         var _loc4_:String = null;
         if(this._mainMetricIndex >= 0 && param1.length > this._mainMetricIndex)
         {
            _loc3_ = param1[this._mainMetricIndex];
            _loc4_ = QuestProgressConstsBase.getMetricsLinkage(viewType,_loc3_.metricType);
            this._metricsCmpnt = App.utils.classFactory.getComponent(_loc4_,IMetricsComponent);
            this._metricsCmpnt.init(_loc3_,param2);
            this._metricsCmpnt.y = METRICS_POINT_Y;
            setBlendModeToMetric(this._metricsCmpnt);
            this.addChild(DisplayObject(this._metricsCmpnt));
         }
         var _loc5_:int = param1.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = param1[_loc6_];
            _loc7_ = _loc3_.metricType;
            if(!this._metricsAdditionalCmpnt && (_loc7_ == QUEST_PROGRESS_BASE.QP_METRIC_TYPE_TIMER || _loc7_ == QUEST_PROGRESS_BASE.QP_METRIC_TYPE_LIMITER))
            {
               this._additionalMetricIndex = _loc6_;
               _loc4_ = QuestProgressConstsBase.getMetricsLinkage(viewType,_loc7_);
               this._metricsAdditionalCmpnt = App.utils.classFactory.getComponent(_loc4_,IMetricsComponent);
               setBlendModeToMetric(this._metricsAdditionalCmpnt);
               this._metricsAdditionalCmpnt.init(_loc3_,param2);
               this._metricsAdditionalCmpnt.y = ADDITIONAL_METRIC_POINT_Y;
               this.addChild(DisplayObject(this._metricsAdditionalCmpnt));
            }
            _loc6_++;
         }
         super.doInitMetrics(param1,param2);
      }
      
      override protected function updateMetrics(param1:Vector.<IQPMetrics>, param2:int) : void
      {
         if(this._metricsCmpnt && param1 && this._mainMetricIndex >= 0 && param1.length > this._mainMetricIndex)
         {
            this._metricsCmpnt.update(param1[this._mainMetricIndex],param2);
         }
         if(this._additionalMetricIndex != Values.DEFAULT_INT && this._metricsAdditionalCmpnt)
         {
            this._metricsAdditionalCmpnt.update(param1[this._additionalMetricIndex],param2);
         }
         super.updateMetrics(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._metricsCmpnt)
         {
            this._metricsCmpnt.dispose();
            this.removeChild(DisplayObject(this._metricsCmpnt));
            this._metricsCmpnt = null;
         }
         if(this._metricsAdditionalCmpnt)
         {
            this._metricsAdditionalCmpnt.dispose();
            this.removeChild(DisplayObject(this._metricsAdditionalCmpnt));
            this._metricsAdditionalCmpnt = null;
         }
         this.resultStateIco = null;
         super.onDispose();
      }
      
      private function updateCmps() : void
      {
         var _loc1_:String = Values.EMPTY_STR;
         if(this._isCompleted && !this._isLocked)
         {
            _loc1_ = QUESTSPROGRESS.DONE;
         }
         else if(this._isFailed)
         {
            _loc1_ = QUESTSPROGRESS.FAILED;
         }
         if(StringUtils.isNotEmpty(_loc1_))
         {
            this.resultStateIco.imageName = _loc1_;
            this.resultStateIco.visible = true;
         }
         else
         {
            this.resultStateIco.visible = false;
         }
         if(this._metricsCmpnt)
         {
            this._metricsCmpnt.visible = !this.resultStateIco.visible;
         }
         if(this._metricsAdditionalCmpnt)
         {
            this._metricsAdditionalCmpnt.visible = !this.resultStateIco.visible;
         }
      }
   }
}
