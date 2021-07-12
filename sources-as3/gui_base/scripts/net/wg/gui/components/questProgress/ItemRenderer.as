package net.wg.gui.components.questProgress
{
   import flash.geom.Rectangle;
   import net.wg.gui.components.questProgress.events.QuestProgressComponentEvent;
   import net.wg.gui.components.questProgress.interfaces.components.IChartComponent;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemRenderer;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ItemRenderer extends UIComponentEx implements IQPItemRenderer
   {
       
      
      public var chartView:IChartComponent = null;
      
      private var _progressData:IQPProgressData = null;
      
      private var _initData:IQPInitData = null;
      
      private var _id:String = null;
      
      private var _viewType:String = null;
      
      private var _isLayoutInitCompleted:Boolean = false;
      
      public function ItemRenderer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.onDataUpdate(this._progressData);
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.doLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         this.chartView.dispose();
         this.chartView = null;
         this._progressData = null;
         this._initData = null;
         super.onDispose();
      }
      
      public function init(param1:IQPInitData) : void
      {
         this._initData = param1;
         this.chartView.viewType = this.viewType;
         this.chartView.init(param1);
      }
      
      public final function initMetrics(param1:Vector.<IQPMetrics>, param2:int) : void
      {
         this.doInitMetrics(param1,param2);
      }
      
      public function unlock() : void
      {
      }
      
      public function update(param1:IQPProgressData) : void
      {
         this._progressData = param1;
         invalidateData();
      }
      
      protected function doInitMetrics(param1:Vector.<IQPMetrics>, param2:int) : void
      {
         invalidateLayout();
      }
      
      protected function doLayout() : void
      {
         if(!this._isLayoutInitCompleted)
         {
            dispatchEvent(new QuestProgressComponentEvent(QuestProgressComponentEvent.LAYOUT_COMPLETED));
            this._isLayoutInitCompleted = true;
         }
      }
      
      protected function updateMetrics(param1:Vector.<IQPMetrics>, param2:int) : void
      {
         invalidateLayout();
      }
      
      protected function updateState(param1:IQPProgressData) : void
      {
      }
      
      protected function onDataUpdate(param1:IQPProgressData) : void
      {
         this.chartView.update(param1);
         var _loc2_:Vector.<IQPMetrics> = param1.metricsValue;
         this.updateState(param1);
         this.updateMetrics(_loc2_,param1.state);
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get viewType() : String
      {
         return this._viewType;
      }
      
      public function set viewType(param1:String) : void
      {
         this._viewType = param1;
      }
      
      public function get orderType() : String
      {
         return this._initData.orderType;
      }
      
      public function get progressType() : String
      {
         return this._initData.progressType;
      }
      
      public function get chartMetrics() : Rectangle
      {
         return this.chartView.getMetrics();
      }
      
      public function get isInOrGroup() : Boolean
      {
         return this._initData.isInOrGroup;
      }
      
      public function get isHidden() : Boolean
      {
         return this._progressData.isHidden;
      }
      
      protected function get progressData() : IQPProgressData
      {
         return this._progressData;
      }
      
      protected function get initData() : IQPInitData
      {
         return this._initData;
      }
   }
}
