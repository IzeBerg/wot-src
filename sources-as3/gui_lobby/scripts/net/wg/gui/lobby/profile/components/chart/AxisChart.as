package net.wg.gui.lobby.profile.components.chart
{
   import flash.display.DisplayObject;
   import net.wg.gui.lobby.profile.components.chart.axis.IChartAxis;
   import scaleform.clik.constants.InvalidationType;
   
   public class AxisChart extends ChartBase
   {
       
      
      private var _horizontalAxis:IChartAxis;
      
      private var _horizontalAxisName:String;
      
      public function AxisChart()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA,LAYOUT_INV))
         {
            this.applyAxisUpdate();
         }
      }
      
      private function applyAxisUpdate() : void
      {
         if(this._horizontalAxis)
         {
            this._horizontalAxis.setData(dataProvider,_renderers,currentLayout);
         }
      }
      
      public function get horizontalAxis() : IChartAxis
      {
         return this._horizontalAxis;
      }
      
      public function set horizontalAxis(param1:IChartAxis) : void
      {
         var _loc2_:DisplayObject = null;
         if(this._horizontalAxis != param1)
         {
            if(this._horizontalAxis)
            {
               _loc2_ = DisplayObject(this._horizontalAxis);
               this._horizontalAxis.dispose();
               _loc2_.parent.removeChild(_loc2_);
            }
            this._horizontalAxis = param1;
            if(param1)
            {
               addChild(DisplayObject(this._horizontalAxis));
               this.applyAxisUpdate();
            }
         }
      }
      
      [Inspectable(name="horizontalAxisName",type="String")]
      public function get horizontalAxisName() : String
      {
         return this._horizontalAxisName;
      }
      
      public function set horizontalAxisName(param1:String) : void
      {
         var _loc2_:IChartAxis = null;
         if(this._horizontalAxisName != param1)
         {
            this._horizontalAxisName = param1;
            if(this._horizontalAxisName != null || this._horizontalAxisName != "")
            {
               _loc2_ = IChartAxis(App.utils.classFactory.getComponent(this._horizontalAxisName,IChartAxis));
               this.horizontalAxis = _loc2_;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._horizontalAxis)
         {
            this._horizontalAxis.dispose();
            this._horizontalAxis = null;
         }
         super.onDispose();
      }
   }
}
