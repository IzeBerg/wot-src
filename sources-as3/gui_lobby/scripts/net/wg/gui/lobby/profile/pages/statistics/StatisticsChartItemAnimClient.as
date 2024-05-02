package net.wg.gui.lobby.profile.pages.statistics
{
   public class StatisticsChartItemAnimClient
   {
      
      public static const topTextColor:uint = 16777215;
      
      public static const textColor:uint = 12696220;
      
      public static const FRAME_NUMBER_PROPERTY:String = "frameNumber";
      
      public static const VALUE_PROPERTY:String = "value";
       
      
      private var item:StatisticBarChartItem;
      
      private var _frameNumber:Number = 0;
      
      private var _value:Number = 0;
      
      public function StatisticsChartItemAnimClient(param1:StatisticBarChartItem)
      {
         super();
         this.item = param1;
      }
      
      public function set frameNumber(param1:Number) : void
      {
         this._frameNumber = param1;
         this.item.gotoAndStop(Math.round(this._frameNumber));
         this.item.textField.textColor = Math.round(this._frameNumber) == 101 ? uint(topTextColor) : uint(textColor);
         this.item.textField.y = this.item.mcMask.y - this.item.mcMask.height - this.item.textField.height;
         this.item.textField.x = Math.round(this.item.background.x + this.item.background.width / 2 - this.item.textField.width / 2);
      }
      
      public function set value(param1:Number) : void
      {
         this._value = param1;
         this.item.textField.text = Math.round(param1).toString();
      }
      
      public function get frameNumber() : Number
      {
         return this._frameNumber;
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function dispose() : void
      {
         this.item = null;
      }
   }
}
