package net.wg.gui.components.questProgress.components.metrics
{
   import flash.events.Event;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.components.SpriteComponent;
   import net.wg.gui.components.questProgress.interfaces.components.IMetricsComponent;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   
   public class QPMetricsCmptBase extends SpriteComponent implements IMetricsComponent
   {
      
      private static const DEFAULT_CMPNT_HEIGHT:int = 22;
       
      
      private var _state:int = -1;
      
      private var _componentWidth:int = 0;
      
      private var _lastComponentWidth:int = 0;
      
      private var _mType:String = "";
      
      public function QPMetricsCmptBase()
      {
         super();
         this.doPrepare();
         this.updateState(QUEST_PROGRESS_BASE.NOT_STARTED_STATE);
      }
      
      public function init(param1:IQPMetrics, param2:int) : void
      {
         this.onInit(param1);
         this.updateState(param2);
         this.doLayout();
      }
      
      public function update(param1:IQPMetrics, param2:int) : void
      {
         this.onUpdate(param1);
         this.updateState(param2);
         this.doLayout();
      }
      
      protected function doPrepare() : void
      {
      }
      
      protected function onInit(param1:IQPMetrics) : void
      {
         this._mType = param1.metricType;
      }
      
      protected function onUpdate(param1:IQPMetrics) : void
      {
      }
      
      protected function doUpdateState(param1:int) : void
      {
      }
      
      protected function doLayout() : void
      {
         if(this._lastComponentWidth != this._componentWidth)
         {
            this._lastComponentWidth = this._componentWidth;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      private function updateState(param1:int) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            this.doUpdateState(this._state);
         }
      }
      
      public function get componentWidth() : int
      {
         return this._componentWidth;
      }
      
      public function set componentWidth(param1:int) : void
      {
         this._componentWidth = param1;
      }
      
      public function get componentHeight() : int
      {
         return DEFAULT_CMPNT_HEIGHT;
      }
      
      public function get mType() : String
      {
         return this._mType;
      }
      
      protected final function get isCompleted() : Boolean
      {
         return this._state == QUEST_PROGRESS_BASE.COMPLETED_STATE;
      }
      
      protected final function get isFailed() : Boolean
      {
         return this._state == QUEST_PROGRESS_BASE.FAILED_STATE;
      }
   }
}
