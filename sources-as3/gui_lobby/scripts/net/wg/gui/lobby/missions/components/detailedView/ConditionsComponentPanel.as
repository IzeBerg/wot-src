package net.wg.gui.lobby.missions.components.detailedView
{
   import net.wg.gui.components.containers.GroupLayout;
   import net.wg.gui.lobby.missions.data.MissionConditionDetailsVO;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ConditionsComponentPanel extends AbstractPopoverWithScrollableGroupPanel
   {
      
      private static const GAP:int = 1;
      
      private static const SCOLLPANE_BOTTOM_MARGIN:int = 39;
       
      
      private var _data:MissionConditionDetailsVO;
      
      public function ConditionsComponentPanel()
      {
         super();
      }
      
      override public function setData(param1:IDAAPIDataClass) : void
      {
         this._data = MissionConditionDetailsVO(param1);
         super.setData(param1);
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         super.onDispose();
      }
      
      override protected function groupLayout() : GroupLayout
      {
         return new VerticalCenterAlignedLayout();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         scrollpane.height = body.height - SCOLLPANE_BOTTOM_MARGIN;
      }
      
      override protected function get header() : String
      {
         return this._data.description;
      }
      
      override protected function get groupData() : IDataProvider
      {
         return this._data.conditionList;
      }
      
      override protected function get layoutGap() : int
      {
         return GAP;
      }
      
      override protected function get groupRendererLinkage() : String
      {
         return this._data.rendererLinkage;
      }
   }
}
