package net.wg.gui.lobby.profile.components.chart
{
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo;
   import scaleform.clik.constants.InvalidationType;
   
   public class ChartItem extends ChartItemBase
   {
      
      private static const VALUE_INV:String = "valInv";
       
      
      private var _value:Number = 0;
      
      public function ChartItem()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         invalidate(InvalidationType.DATA);
         var _loc2_:StatisticChartInfo = _data as StatisticChartInfo;
         if(_loc2_ != null && _loc2_.percentValue != Values.DEFAULT_INT)
         {
            this.value = _loc2_.percentValue;
         }
         else if(!isNaN(Number(_data)))
         {
            this.value = Number(_data);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA,VALUE_INV))
         {
            this.applyValueChange();
         }
      }
      
      protected function applyValueChange() : void
      {
      }
      
      [Inspectable(defaultValue="0",name="value",type="Number")]
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(param1:Number) : void
      {
         this._value = param1;
         invalidate(VALUE_INV);
      }
   }
}
