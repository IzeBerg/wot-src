package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class PersonalMissionsItemSlotVO extends DAAPIDataClass
   {
      
      private static const TOOLTIP_DATA:String = "tooltipData";
       
      
      public var slotType:String = "";
      
      public var iconSource:String = "";
      
      public var isCollected:Boolean = false;
      
      public var canUnlock:Boolean = false;
      
      public var unlockBtnLabel:String = "";
      
      public var tokenType:String = "";
      
      public var allianceIcon:String = "";
      
      private var _tooltipData:ToolTipVO = null;
      
      public function PersonalMissionsItemSlotVO(param1:Object = null)
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
         super.onDispose();
      }
      
      public function get tooltipData() : ToolTipVO
      {
         return this._tooltipData;
      }
   }
}
