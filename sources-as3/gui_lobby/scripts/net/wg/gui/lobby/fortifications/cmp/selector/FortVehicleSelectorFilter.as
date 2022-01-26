package net.wg.gui.lobby.fortifications.cmp.selector
{
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.DropDownImageText;
   import net.wg.gui.components.controls.ToggleRenderer;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.gui.lobby.components.VehicleSelectorMultiFilter;
   import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.gui.lobby.fortifications.data.popover.FortVehicleSelectorFilterVO;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ListEvent;
   
   public class FortVehicleSelectorFilter extends VehicleSelectorMultiFilter
   {
      
      private static const LINKAGE_TOGGLE_RENDERER:String = "FortVehicleFilterRendererUI";
      
      private static const FILTERS_TILE_WIDTH:int = 32;
      
      private static const FILTERS_TILE_HEIGHT:int = 22;
      
      private static const FILTERS_HOR_GAP:int = 9;
       
      
      public var nationDD:DropDownImageText = null;
      
      public var mainBtn:ToggleRenderer = null;
      
      public function FortVehicleSelectorFilter()
      {
         super();
      }
      
      private static function onFiltersRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override public function setData(param1:IVehicleSelectorFilterVO) : void
      {
         super.setData(param1);
         this.mainBtn.setData(FortVehicleSelectorFilterVO(param1).mainBtn);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(initData != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.nationDD.dataProvider = initData.nationDP;
               this.nationDD.selectedIndex = 0;
               this.selectNation(initData.nation);
               invalidateSize();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.nationDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.nationDD.removeEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.nationDD.removeEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.nationDD.removeEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.nationDD.dispose();
         this.nationDD = null;
         this.mainBtn.removeEventListener(RendererEvent.ITEM_CLICK,this.onMainItemClickHandler);
         this.mainBtn.dispose();
         this.mainBtn = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.nationDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.nationDD.addEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.nationDD.addEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.nationDD.addEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         toggles.itemRenderer = App.utils.classFactory.getClass(LINKAGE_TOGGLE_RENDERER);
         toggles.tileWidth = FILTERS_TILE_WIDTH;
         toggles.tileHeight = FILTERS_TILE_HEIGHT;
         toggles.horizontalGap = FILTERS_HOR_GAP;
         toggles.directionMode = DirectionMode.HORIZONTAL;
         this.mainBtn.addEventListener(RendererEvent.ITEM_CLICK,this.onMainItemClickHandler);
      }
      
      private function onFiltersIndexChangeHandler(param1:ListEvent) : void
      {
         this.dispatchFilterEvent();
      }
      
      private function dispatchFilterEvent() : void
      {
         App.toolTipMgr.hide();
         var _loc1_:Object = this.nationDD.dataProvider.requestItemAt(this.nationDD.selectedIndex);
         var _loc2_:VehicleSelectorFilterEvent = new VehicleSelectorFilterEvent(VehicleSelectorFilterEvent.CHANGE,true);
         _loc2_.nation = Boolean(_loc1_) ? int(_loc1_.data) : int(-1);
         _loc2_.vehicleType = null;
         _loc2_.level = -1;
         _loc2_.isMain = this.mainBtn.selected;
         _loc2_.compatibleOnly = initData.compatibleOnly;
         dispatchEvent(_loc2_);
      }
      
      private function selectNation(param1:int) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.nationDD.dataProvider)
         {
            if(_loc2_.data == param1)
            {
               this.nationDD.selectedIndex = this.nationDD.dataProvider.indexOf(_loc2_);
               return;
            }
         }
      }
      
      private function onMainItemClickHandler(param1:RendererEvent) : void
      {
         this.mainBtn.selected = !this.mainBtn.selected;
         this.dispatchFilterEvent();
      }
      
      private function onFiltersRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(FortVehicleSelectorFilterVO(initData).nationTooltip);
      }
   }
}
