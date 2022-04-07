package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class PersonalMissionAwardRendererVO extends DAAPIDataClass
   {
      
      private static const TOOLTIP:String = "tooltip";
       
      
      public var icon:String = "";
      
      public var title:String = "";
      
      private var _tooltip:ToolTipVO = null;
      
      public function PersonalMissionAwardRendererVO(param1:Object)
      {
         super(param1);
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
