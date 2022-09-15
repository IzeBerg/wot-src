package net.wg.gui.lobby.profile.pages.statistics
{
   import fl.transitions.easing.Strong;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.gui.lobby.profile.components.chart.AxisChart;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class StatisticBarChartInitializer implements IDisposable
   {
       
      
      private var chartRef:AxisChart;
      
      private var tweenManager:ExcludeTweenManager;
      
      private var _disposed:Boolean = false;
      
      public function StatisticBarChartInitializer(param1:AxisChart)
      {
         this.tweenManager = new ExcludeTweenManager();
         super();
         this.chartRef = param1;
         if(param1.horizontalAxis)
         {
            this.chartRef.alpha = 0;
            DisplayObject(param1.horizontalAxis).addEventListener(StatisticsBarChartAxis.INITIALIZED,this.initializedHandler,false,0,true);
         }
      }
      
      private function initializedHandler(param1:Event) : void
      {
         this.tweenManager.registerAndLaunch(500,this.chartRef,{"alpha":1},{
            "ease":Strong.easeOut,
            "onComplete":this.onTweenComplete
         });
         DisplayObject(this.chartRef.horizontalAxis).removeEventListener(StatisticsBarChartAxis.INITIALIZED,this.initializedHandler);
      }
      
      private function onTweenComplete(param1:Tween) : void
      {
         this.tweenManager.unregister(param1);
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.tweenManager.dispose();
         this.tweenManager = null;
         if(this.chartRef.horizontalAxis)
         {
            DisplayObject(this.chartRef.horizontalAxis).removeEventListener(StatisticsBarChartAxis.INITIALIZED,this.initializedHandler);
         }
         this.chartRef = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
