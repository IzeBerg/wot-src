package net.wg.gui.lobby.components.data
{
   import net.wg.data.managers.IToolTipParams;
   
   public class DetailedStatisticsLabelDataVO extends StatisticsLabelDataVO
   {
      
      private static const TOOLTIP_DATA:String = "tooltipData";
      
      private static const DATA:String = "data";
       
      
      public var tooltip:String = "";
      
      private var _tooltipDataVO:IToolTipParams = null;
      
      public function DetailedStatisticsLabelDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == DATA)
         {
            parseData(param2);
            return false;
         }
         if(param1 == TOOLTIP_DATA && param2)
         {
            this._tooltipDataVO = new StatisticsTooltipDataVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this._tooltipDataVO)
         {
            this._tooltipDataVO.dispose();
            this._tooltipDataVO = null;
         }
         super.onDispose();
      }
      
      public function get tooltipDataVO() : IToolTipParams
      {
         return this._tooltipDataVO;
      }
   }
}
