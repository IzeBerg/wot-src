package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class PersonalMissionsPlanRegionVO extends DAAPIDataClass
   {
      
      private static const TOOLTIP_DATA:String = "tooltipData";
       
      
      public var state:int = -1;
      
      public var id:Number = -1;
      
      public var vehType:String = "";
      
      public var isTokenPawned:Boolean = false;
      
      public var isLocked:Boolean = false;
      
      public var isOnPause:Boolean = false;
      
      public var isFinal:Boolean = false;
      
      public var sheet:String = "";
      
      private var _tooltipData:ToolTipVO = null;
      
      public function PersonalMissionsPlanRegionVO(param1:Object)
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
