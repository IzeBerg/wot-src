package net.wg.gui.lobby.vehicleCompare
{
   import net.wg.gui.lobby.vehicleCompare.events.VehicleModuleItemEvent;
   import net.wg.infrastructure.base.meta.IVehicleModulesViewMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleModulesViewMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   
   public class VehicleModulesView extends VehicleModulesViewMeta implements IVehicleModulesViewMeta, IViewStackContent
   {
      
      private static const MODULE_CELL_HEIGHT:int = 92;
      
      private static const MODULE_CELL_WIDTH:int = 40;
      
      private static const HEIGHT_SD:int = 900;
      
      private static const SEPARATOR_OFFSET_HD:int = 310;
      
      private static const SEPARATOR_OFFSET_SD:int = 280;
       
      
      public var tree:VehicleModulesTree = null;
      
      public function VehicleModulesView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tree.addEventListener(VehicleModuleItemEvent.MODULE_ITEM_HOVERED,this.onTreeModuleItemHoveredHandler);
         this.tree.addEventListener(VehicleModuleItemEvent.MODULE_ITEM_CLICKED,this.onTreeModuleItemClickedHandler);
      }
      
      override protected function onDispose() : void
      {
         this.tree.removeEventListener(VehicleModuleItemEvent.MODULE_ITEM_CLICKED,this.onTreeModuleItemClickedHandler);
         this.tree.removeEventListener(VehicleModuleItemEvent.MODULE_ITEM_HOVERED,this.onTreeModuleItemHoveredHandler);
         this.tree.dispose();
         this.tree = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.tree.yRatio = MODULE_CELL_HEIGHT;
         this.tree.xRatio = MODULE_CELL_WIDTH;
      }
      
      override protected function setNodesStates(param1:Array) : void
      {
         this.tree.setNodesStates(param1);
      }
      
      override protected function updateLayout() : void
      {
         super.updateLayout();
         this.tree.x = width - this.tree.width >> 1;
         this.tree.y = height >> 1;
         var _loc1_:int = App.appHeight >= HEIGHT_SD ? int(SEPARATOR_OFFSET_HD) : int(SEPARATOR_OFFSET_SD);
         bottomPanel.x = width - bottomPanel.width >> 1;
         bottomPanel.y = (height >> 1) + _loc1_;
         titleTf.visible = App.appHeight >= HEIGHT_SD;
      }
      
      public function as_setItem(param1:String, param2:Object) : void
      {
         this.tree.invalidateNodesData(param1,param2);
         App.utils.focusHandler.setFocus(this);
      }
      
      private function onTreeModuleItemClickedHandler(param1:VehicleModuleItemEvent) : void
      {
         onModuleClickS(param1.id);
      }
      
      private function onTreeModuleItemHoveredHandler(param1:VehicleModuleItemEvent) : void
      {
         onModuleHoverS(param1.id);
      }
   }
}
