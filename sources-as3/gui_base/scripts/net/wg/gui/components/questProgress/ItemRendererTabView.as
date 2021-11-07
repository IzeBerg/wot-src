package net.wg.gui.components.questProgress
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUESTSPROGRESS;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.components.metrics.result.MetricsResultComponentTab;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsLimiterVO;
   import net.wg.gui.components.questProgress.interfaces.components.IMetricsComponent;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ItemRendererTabView extends ItemRenderer
   {
      
      private static const START_TEXT_X_POS:int = 68;
      
      private static const TEXT_FIELDS_Y_GAP:int = 4;
      
      private static const METRICS_X_GAP_POINT:int = 12;
      
      private static const MULTIPLIER_TF_Y_GAP:int = 14;
      
      private static const MULTIPLIER_ICON_Y_GAP:int = -8;
      
      private static const COMPONENT_HEIGHT_SHIFT:int = -11;
      
      private static const MAX_TEXT_FIELD_WIDTH_FOR_ORDER_MAIN:int = 380;
      
      private static const MAX_TEXT_FIELD_WIDTH_FOR_ORDER_ADD:int = 240;
      
      private static const VERTICAL_ITEMS_TOP_GAP:int = 4;
      
      private static const TITLE_MAX_LINE_NUMBER:uint = 2;
      
      private static const DOTS:String = "...";
       
      
      public var title:TextField = null;
      
      public var descrTf:TextField = null;
      
      public var multiplierTf:TextField = null;
      
      public var multiplierIcon:Sprite = null;
      
      public var alertLabel:TabAlert = null;
      
      public var warningIco:QuestProgressAtlasSprite = null;
      
      public var resultMetric:MetricsResultComponentTab = null;
      
      private var _metricsCmpnts:Vector.<IMetricsComponent> = null;
      
      private var _metricsCmpntsMap:Dictionary = null;
      
      private var _startCmpntsPoint:Point;
      
      private var _title:String = null;
      
      private var _isTitleTruncated:Boolean = false;
      
      public function ItemRendererTabView()
      {
         this._startCmpntsPoint = new Point(0,0);
         super();
      }
      
      private static function isMetricAllow(param1:String) : Boolean
      {
         return QUEST_PROGRESS_BASE.QUEST_PROGRESS_METRICS_SKIP_TAB.indexOf(param1) == -1;
      }
      
      override public function init(param1:IQPInitData) : void
      {
         var _loc2_:Boolean = false;
         super.init(param1);
         this.descrTf.visible = StringUtils.isNotEmpty(param1.description);
         _loc2_ = StringUtils.isNotEmpty(param1.multiplier);
         this.multiplierTf.visible = _loc2_;
         this.multiplierIcon.visible = _loc2_;
         this.descrTf.htmlText = param1.description;
         this.multiplierTf.htmlText = param1.multiplier;
         this._startCmpntsPoint.x = START_TEXT_X_POS;
         var _loc3_:int = orderType == QUEST_PROGRESS_BASE.ADD_ORDER_TYPE ? int(MAX_TEXT_FIELD_WIDTH_FOR_ORDER_ADD) : int(MAX_TEXT_FIELD_WIDTH_FOR_ORDER_MAIN);
         this.alertLabel.setDescription(param1.alertLabel,_loc3_);
         this.title.width = this.descrTf.width = this.multiplierTf.width = _loc3_;
         this._title = param1.title;
         this._isTitleTruncated = App.utils.commons.truncateTextFieldMultiline(this.title,this._title,TITLE_MAX_LINE_NUMBER,DOTS);
         if(this._isTitleTruncated)
         {
            this.title.addEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
            this.title.addEventListener(MouseEvent.ROLL_OUT,this.onTitleRollOutHandler);
         }
         App.utils.commons.updateTextFieldSize(this.title,false,true);
         App.utils.commons.updateTextFieldSize(this.descrTf,false,true);
         App.utils.commons.updateTextFieldSize(this.multiplierTf,false,true);
         this._startCmpntsPoint.y = this.title.y + this.title.height + VERTICAL_ITEMS_TOP_GAP;
      }
      
      override protected function updateMetrics(param1:Vector.<IQPMetrics>, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         if(this._metricsCmpnts && param1)
         {
            _loc3_ = param1.length;
            _loc4_ = this._metricsCmpnts.length;
            if(_loc3_ < _loc4_)
            {
               App.utils.asserter.assert(false,"Wrong data length");
            }
            _loc5_ = Values.EMPTY_STR;
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc5_ = param1[_loc6_].metricType;
               if(_loc5_ == QUEST_PROGRESS_BASE.QP_METRIC_TYPE_LIMITER)
               {
                  this.warningIco.visible = QPMetricsLimiterVO(param1[_loc6_]).isActive;
               }
               if(isMetricAllow(_loc5_))
               {
                  this._metricsCmpntsMap[_loc5_].update(param1[_loc6_],param2);
               }
               _loc6_++;
            }
         }
         super.updateMetrics(param1,param2);
      }
      
      override protected function updateState(param1:IQPProgressData) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._metricsCmpnts)
         {
            _loc2_ = param1.isCompleted;
            _loc3_ = param1.isFailed;
            _loc4_ = this._metricsCmpnts.length;
            if(_loc2_ || _loc3_)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this._metricsCmpnts[_loc5_].visible = this._metricsCmpnts[_loc5_].mType == QUEST_PROGRESS_BASE.QP_METRIC_TYPE_RANGE;
                  _loc5_++;
               }
            }
            this.alertLabel.visible = param1.isConflict && !_loc2_;
            this.resultMetric.visible = _loc2_ && progressType == QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_CUMULATIVE;
         }
         super.updateState(param1);
      }
      
      override protected function onDataUpdate(param1:IQPProgressData) : void
      {
         if(!param1.isLocked)
         {
            chartView.unlock();
         }
         super.onDataUpdate(param1);
      }
      
      override protected function doLayout() : void
      {
         var _loc4_:IMetricsComponent = null;
         var _loc1_:Boolean = orderType == QUEST_PROGRESS_BASE.ADD_ORDER_TYPE;
         var _loc2_:Point = new Point(this._startCmpntsPoint.x,this._startCmpntsPoint.y);
         var _loc3_:Boolean = false;
         for each(_loc4_ in this._metricsCmpnts)
         {
            _loc2_ = this.setMetricPosition(_loc4_,_loc2_,_loc1_);
            _loc3_ = _loc3_ || _loc4_.visible;
         }
         if(this.resultMetric.visible)
         {
            _loc4_ = this.resultMetric;
            _loc2_ = this.setMetricPosition(this.resultMetric,_loc2_,_loc1_);
         }
         if(!_loc1_ && _loc4_ && _loc3_)
         {
            _loc2_.y += _loc4_.componentHeight + TEXT_FIELDS_Y_GAP;
         }
         if(this.alertLabel.visible)
         {
            this.alertLabel.y = _loc2_.y;
            _loc2_.y += this.alertLabel.height + TEXT_FIELDS_Y_GAP;
         }
         if(this.descrTf.visible)
         {
            this.descrTf.y = _loc2_.y;
            _loc2_.y += this.descrTf.height + TEXT_FIELDS_Y_GAP;
         }
         if(this.multiplierTf.visible)
         {
            _loc2_.y += MULTIPLIER_TF_Y_GAP;
            this.multiplierTf.y = _loc2_.y;
            this.multiplierIcon.y = _loc2_.y + MULTIPLIER_ICON_Y_GAP;
            _loc2_.y += this.multiplierTf.height + TEXT_FIELDS_Y_GAP;
         }
         _height = Math.max(chartMetrics.height,_loc2_.y + COMPONENT_HEIGHT_SHIFT);
         super.doLayout();
      }
      
      override protected function doInitMetrics(param1:Vector.<IQPMetrics>, param2:int) : void
      {
         var _loc5_:IQPMetrics = null;
         var _loc6_:String = null;
         this._metricsCmpnts = new Vector.<IMetricsComponent>();
         this._metricsCmpntsMap = new Dictionary();
         var _loc3_:IMetricsComponent = null;
         var _loc4_:String = Values.EMPTY_STR;
         for each(_loc5_ in param1)
         {
            _loc4_ = _loc5_.metricType;
            if(_loc4_ == QUEST_PROGRESS_BASE.QP_METRIC_TYPE_LIMITER)
            {
               this.warningIco.isCentralize = true;
               this.warningIco.imageName = QUESTSPROGRESS.WARNING;
               this.warningIco.visible = QPMetricsLimiterVO(_loc5_).isActive;
            }
            if(isMetricAllow(_loc4_))
            {
               _loc6_ = QuestProgressConstsBase.getMetricsLinkage(viewType,_loc4_);
               _loc3_ = App.utils.classFactory.getComponent(_loc6_,IMetricsComponent);
               _loc3_.addEventListener(Event.RESIZE,this.onMetricCmpntResizeHandler);
               _loc3_.init(_loc5_,param2);
               this.addChild(DisplayObject(_loc3_));
               this._metricsCmpnts.push(_loc3_);
               this._metricsCmpntsMap[_loc4_] = _loc3_;
            }
         }
         super.doInitMetrics(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IMetricsComponent = null;
         App.utils.data.cleanupDynamicObject(this._metricsCmpntsMap);
         this._metricsCmpntsMap = null;
         this._startCmpntsPoint = null;
         this.warningIco = null;
         if(this.alertLabel)
         {
            this.alertLabel.dispose();
            this.alertLabel = null;
         }
         if(this.resultMetric)
         {
            this.resultMetric.dispose();
            this.resultMetric = null;
         }
         if(this._metricsCmpnts)
         {
            for each(_loc1_ in this._metricsCmpnts)
            {
               _loc1_.removeEventListener(Event.RESIZE,this.onMetricCmpntResizeHandler);
               _loc1_.dispose();
               this.removeChild(DisplayObject(_loc1_));
            }
            this._metricsCmpnts.splice(0,this._metricsCmpnts.length);
            this._metricsCmpnts = null;
         }
         if(this._isTitleTruncated)
         {
            this.title.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
            this.title.removeEventListener(MouseEvent.ROLL_OUT,this.onTitleRollOutHandler);
         }
         this.title = null;
         this.descrTf = null;
         this.multiplierTf = null;
         this.multiplierIcon = null;
         super.onDispose();
      }
      
      private function setMetricPosition(param1:IMetricsComponent, param2:Point, param3:Boolean) : Point
      {
         if(param1.visible)
         {
            param1.x = param2.x;
            param1.y = param2.y;
            if(param3)
            {
               param2.y += param1.componentHeight + TEXT_FIELDS_Y_GAP;
            }
            else
            {
               param2.x += param1.componentWidth + METRICS_X_GAP_POINT;
            }
         }
         return param2;
      }
      
      override public function get height() : Number
      {
         return _height;
      }
      
      private function onMetricCmpntResizeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
      
      private function onTitleRollOverHandler(param1:Event) : void
      {
         App.toolTipMgr.show(this._title);
      }
      
      private function onTitleRollOutHandler(param1:Event) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
