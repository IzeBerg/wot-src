package net.wg.gui.lobby.profile.pages.statistics
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.managers.impl.ToolTipParams;
   import net.wg.gui.lobby.profile.components.chart.FrameChartItem;
   import net.wg.gui.utils.ExcludeTweenManager;
   import scaleform.clik.motion.Tween;
   
   public class StatisticBarChartItem extends FrameChartItem
   {
      
      protected static const tweeSpeed:uint = 500;
       
      
      public var textField:TextField;
      
      public var mcMask:MovieClip;
      
      public var background:Sprite;
      
      protected var tweenManager:ExcludeTweenManager;
      
      private var _tooltip:String = null;
      
      private var animationClient:StatisticsChartItemAnimClient;
      
      public function StatisticBarChartItem()
      {
         this.tweenManager = new ExcludeTweenManager();
         super();
         this.animationClient = new StatisticsChartItemAnimClient(this);
         stop();
      }
      
      private static function hideToolTip() : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.textField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function applyValueChange() : void
      {
         var _loc1_:Object = {};
         _loc1_[StatisticsChartItemAnimClient.FRAME_NUMBER_PROPERTY] = value + 1;
         _loc1_[StatisticsChartItemAnimClient.VALUE_PROPERTY] = _data.yField >= 0 ? _data.yField : 0;
         this.tweenManager.registerAndLaunch(tweeSpeed,this.animationClient,_loc1_,this.getQuickSet());
         super.applyValueChange();
      }
      
      override protected function onDispose() : void
      {
         this.mcMask = null;
         this.textField = null;
         this.background = null;
         this.tweenManager.dispose();
         this.animationClient.dispose();
         this.disposeHandlers();
         super.onDispose();
      }
      
      public function getThumbDimensions() : Point
      {
         return new Point(this.background.width,this.background.height);
      }
      
      protected function showToolTip() : void
      {
         var _loc1_:Object = null;
         if(this.tooltip)
         {
            _loc1_ = {};
            if(_data != null)
            {
               _loc1_.value = _data.xField;
            }
            App.toolTipMgr.showComplexWithParams(this.tooltip,new ToolTipParams(_loc1_,{}));
         }
      }
      
      protected function getQuickSet() : Object
      {
         var _loc1_:Object = {};
         _loc1_.ease = Strong.easeOut;
         _loc1_.onComplete = this.onTweenComplete;
         return _loc1_;
      }
      
      private function onTweenComplete(param1:Tween) : void
      {
         this.tweenManager.unregister(param1);
      }
      
      private function disposeHandlers() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
         this.disposeHandlers();
         if(this._tooltip)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
         }
      }
      
      protected function mouseRollOutHandler(param1:MouseEvent) : void
      {
         hideToolTip();
      }
      
      protected function mouseRollOverHandler(param1:MouseEvent) : void
      {
         this.showToolTip();
      }
   }
}
