package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class PersonalMissionVehicleAwardVO extends DAAPIDataClass
   {
      
      private static const TOOLTIP:String = "tooltip";
       
      
      public var vehicleSrc:String = "";
      
      public var vehicleTypeIcon:String = "";
      
      public var vehicleName:String = "";
      
      public var vehicleLevel:String = "";
      
      public var hasData:Boolean = false;
      
      private var _tooltip:ToolTipVO = null;
      
      public function PersonalMissionVehicleAwardVO(param1:Object = null)
      {
         super(param1);
         this.hasData = param1 != null;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TOOLTIP)
         {
            this._tooltip = new ToolTipVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._tooltip != null)
         {
            this._tooltip.dispose();
            this._tooltip = null;
         }
         super.onDispose();
      }
      
      public function get tooltip() : ToolTipVO
      {
         return this._tooltip;
      }
   }
}
