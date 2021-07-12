package net.wg.gui.components.questProgress.components
{
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.questProgress.QuestProgressConstsBase;
   import net.wg.gui.components.questProgress.interfaces.components.IChartComponent;
   import net.wg.gui.components.questProgress.interfaces.components.IChartProgress;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   
   public class ChartComponent extends SpriteComponent implements IChartComponent
   {
       
      
      public var taskIcon:UILoaderAlt = null;
      
      private var _progressBar:IChartProgress = null;
      
      private var _orderType:String = "";
      
      private var _progressType:String = "";
      
      public function ChartComponent()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.taskIcon.dispose();
         this.taskIcon = null;
         this.clearProgressBar();
         super.onDispose();
      }
      
      public function getMetrics() : Rectangle
      {
         return this._progressBar.getMetrics();
      }
      
      public function init(param1:IQPInitData) : void
      {
         this.createProgressBar(param1);
         this._progressBar.init(param1);
         this.taskIcon.source = QuestProgressConstsBase.getChartIcon(viewType,param1.iconID);
         this._progressBar.blendMode = BlendMode.SCREEN;
      }
      
      public function unlock() : void
      {
         this._progressBar.unlock();
      }
      
      public function update(param1:IQPProgressData) : void
      {
         this._progressBar.update(param1);
      }
      
      private function clearProgressBar() : void
      {
         this.removeChild(DisplayObject(this._progressBar));
         this._progressBar.dispose();
         this._progressBar = null;
      }
      
      private function createProgressBar(param1:IQPInitData) : void
      {
         if(this._progressBar && (this._orderType != param1.orderType || this._progressType != param1.progressType))
         {
            this.clearProgressBar();
         }
         this._orderType = param1.orderType;
         this._progressType = param1.progressType;
         var _loc2_:String = QuestProgressConstsBase.getChartProgress(viewType,this._progressType);
         this._progressBar = App.utils.classFactory.getComponent(_loc2_,IChartProgress);
         this._progressBar.x = this.taskIcon.x + (this.taskIcon.originalWidth >> 1);
         this._progressBar.y = this.taskIcon.y + (this.taskIcon.originalHeight >> 1);
         this.addChild(DisplayObject(this._progressBar));
      }
   }
}
