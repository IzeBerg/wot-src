package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class BasicFooterBlockVO extends DAAPIDataClass
   {
      
      private static const TOOLTIP_DATA:String = "tooltipData";
       
      
      public var popover:String = "";
      
      public var popoverData:Object = null;
      
      private var _tooltipData:ToolTipVO = null;
      
      public function BasicFooterBlockVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TOOLTIP_DATA)
         {
            this._tooltipData = new ToolTipVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._tooltipData.dispose();
         this._tooltipData = null;
         this.popoverData = null;
         super.onDispose();
      }
      
      public function get tooltipData() : ToolTipVO
      {
         return this._tooltipData;
      }
   }
}
