package net.wg.gui.lobby.profile.pages.statistics
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.gui.lobby.profile.components.LineTextComponent;
   import net.wg.gui.lobby.profile.components.chart.IChartItem;
   import net.wg.gui.lobby.profile.components.chart.axis.AxisBase;
   import net.wg.gui.lobby.profile.components.chart.layout.IChartLayout;
   import net.wg.infrastructure.events.IconLoaderEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class StatisticsBarChartAxis extends AxisBase
   {
      
      private static const PADDING_TOP:int = 112;
      
      private static const LAYOUT_INV:String = "layoutInv";
      
      public static const INITIALIZED:String = "inited";
       
      
      public var background:MovieClip;
      
      public var lineText:LineTextComponent;
      
      private var _statisticsChartPoints:Vector.<StatisticBarChartAxisPoint>;
      
      public function StatisticsBarChartAxis()
      {
         this._statisticsChartPoints = new Vector.<StatisticBarChartAxisPoint>();
         super();
      }
      
      override protected function createPoint(param1:Object) : IListItemRenderer
      {
         var _loc2_:StatisticBarChartAxisPoint = new StatisticBarChartAxisPoint();
         this._statisticsChartPoints.push(_loc2_);
         _loc2_.addEventListener(IconLoaderEvent.ICON_LOADED,this.onIconLoadedHandler,false,0,true);
         addChild(_loc2_);
         return _loc2_;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(LAYOUT_INV))
         {
            this.layoutAll(currentLayout);
         }
      }
      
      override protected function layoutPoint(param1:IListItemRenderer, param2:IChartItem) : void
      {
         var _loc3_:StatisticBarChartItem = StatisticBarChartItem(param2);
         var _loc4_:Point = _loc3_.getThumbDimensions();
         param1.y = PADDING_TOP;
         param1.x = Math.round(_loc3_.x + (_loc4_.x - param1.width >> 1));
      }
      
      override protected function layoutAll(param1:IChartLayout) : void
      {
         var _loc2_:StatisticBarChartItem = null;
         super.layoutAll(param1);
         if(!renderers)
         {
            return;
         }
         var _loc3_:Number = renderers.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = StatisticBarChartItem(renderers[_loc4_]);
            this.layoutPoint(_points[_loc4_],_loc2_);
            _loc4_++;
         }
         if(_loc2_)
         {
            this.lineText.width = this.background.width = _loc2_.x + _loc2_.getThumbDimensions().x + param1.paddingRight;
            dispatchEvent(new Event(Event.RESIZE,true));
         }
      }
      
      override protected function onDispose() : void
      {
         this.background = null;
         this.lineText.dispose();
         this.lineText = null;
         var _loc1_:int = this._statisticsChartPoints.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._statisticsChartPoints[_loc2_].removeEventListener(IconLoaderEvent.ICON_LOADED,this.onIconLoadedHandler);
            _loc2_++;
         }
         this._statisticsChartPoints.splice(0,_loc1_);
         this._statisticsChartPoints = null;
         super.onDispose();
      }
      
      public function setLineText(param1:String) : void
      {
         this.lineText.text = param1;
      }
      
      private function onIconLoadedHandler(param1:IconLoaderEvent) : void
      {
         var _loc5_:StatisticBarChartAxisPoint = null;
         var _loc2_:Boolean = true;
         var _loc3_:int = this._statisticsChartPoints.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this._statisticsChartPoints[_loc4_];
            if(!_loc5_.initialized)
            {
               _loc2_ = false;
               break;
            }
            _loc4_++;
         }
         if(_loc2_ && getData().length == _loc3_)
         {
            dispatchEvent(new Event(INITIALIZED));
         }
         invalidate(LAYOUT_INV);
      }
   }
}
