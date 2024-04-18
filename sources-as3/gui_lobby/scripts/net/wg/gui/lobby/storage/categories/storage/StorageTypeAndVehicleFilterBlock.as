package net.wg.gui.lobby.storage.categories.storage
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.Aliases;
   import net.wg.gui.components.controls.ButtonIconTextTransparent;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class StorageTypeAndVehicleFilterBlock extends StorageTypeFilterBlock implements IPopOverCaller
   {
      
      private static const INVALID_VEHICLE_BUTTON:String = "invalidateVehicleButton";
      
      private static const VEHICLE_BUTTON_X_OFFSET:int = 22;
      
      private static const RESET_VEHICLE_FILTER_BUTTON_X_OFFSET:int = 5;
       
      
      public var vehiclesFilterName:TextField = null;
      
      public var vehiclesFilterButton:CSVehicleButton = null;
      
      public var resetVehicleFilterButton:ButtonIconTextTransparent = null;
      
      private var _vehicleFilterVO:VehicleVO;
      
      public function StorageTypeAndVehicleFilterBlock()
      {
         super();
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.vehiclesFilterButton as DisplayObject;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.vehiclesFilterButton as DisplayObject;
      }
      
      public function updateVehicleFilterButton(param1:VehicleVO) : void
      {
         this._vehicleFilterVO = param1;
         invalidate(INVALID_VEHICLE_BUTTON);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehiclesFilterName.autoSize = TextFieldAutoSize.LEFT;
         this.vehiclesFilterName.text = STORAGE.STORAGE_TABS_MODULES_FILTER_APPROPRIATE_LABEL;
         this.vehiclesFilterButton.addEventListener(ButtonEvent.CLICK,this.onVehiclesFilterButtonClickHandler);
         this.resetVehicleFilterButton.addEventListener(ButtonEvent.CLICK,this.onResetVehicleFilterButtonClickHandler);
         this.resetVehicleFilterButton.tooltip = TOOLTIPS.STORAGE_FILTERCOUNTER_CLOSEBUTTON;
      }
      
      override protected function onDispose() : void
      {
         this.vehiclesFilterButton.removeEventListener(ButtonEvent.CLICK,this.onVehiclesFilterButtonClickHandler);
         this.vehiclesFilterButton.dispose();
         this.vehiclesFilterButton = null;
         this.resetVehicleFilterButton.removeEventListener(ButtonEvent.CLICK,this.onResetVehicleFilterButtonClickHandler);
         this.resetVehicleFilterButton.dispose();
         this.resetVehicleFilterButton = null;
         this._vehicleFilterVO = null;
         this.vehiclesFilterName = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_VEHICLE_BUTTON))
         {
            if(this._vehicleFilterVO)
            {
               this.vehiclesFilterButton.setVehicle(this._vehicleFilterVO);
               this.resetVehicleFilterButton.visible = true;
            }
            else
            {
               this.vehiclesFilterButton.reset();
               this.vehiclesFilterButton.selectState(true);
               this.resetVehicleFilterButton.visible = false;
            }
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.vehiclesFilterButton.x = width - this.vehiclesFilterButton.width + VEHICLE_BUTTON_X_OFFSET;
            this.vehiclesFilterName.x = this.vehiclesFilterButton.x - this.vehiclesFilterName.width;
            typeFilters.x = this.vehiclesFilterName.x - typeFilters.width - TYPE_FILTERS_X_OFFSET;
            typeFilterName.x = typeFilters.x - typeFilterName.width - FILTER_NAME_GAP;
            this.resetVehicleFilterButton.x = width + RESET_VEHICLE_FILTER_BUTTON_X_OFFSET;
         }
      }
      
      override protected function updatePositions() : void
      {
         this.vehiclesFilterButton.x = width - this.vehiclesFilterButton.width + VEHICLE_BUTTON_X_OFFSET;
         this.vehiclesFilterName.x = this.vehiclesFilterButton.x - this.vehiclesFilterName.width;
         typeFilters.x = this.vehiclesFilterName.x - typeFilters.width - TYPE_FILTERS_X_OFFSET;
         typeFilterName.x = typeFilters.x - typeFilterName.width - FILTER_NAME_GAP;
         this.resetVehicleFilterButton.x = width + RESET_VEHICLE_FILTER_BUTTON_X_OFFSET;
      }
      
      private function onVehiclesFilterButtonClickHandler(param1:ButtonEvent) : void
      {
         App.toolTipMgr.hide();
         App.popoverMgr.show(this,Aliases.STORAGE_VEHICLE_SELECTOR_POPOVER);
      }
      
      private function onResetVehicleFilterButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new FiltersEvent(FiltersEvent.RESET_VEHICLE_FILTERS));
      }
   }
}
