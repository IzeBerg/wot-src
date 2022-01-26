package net.wg.gui.lobby.storage.categories.blueprints
{
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.Aliases;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.storage.categories.StorageVehicleFilterBlock;
   import scaleform.clik.constants.InvalidationType;
   
   public class BlueprintsFilterBlock extends StorageVehicleFilterBlock
   {
      
      private static const CONVERT_FILTER_CHECKBOX_X_OFFSET:int = 30;
      
      private static const INV_CAN_CONVERT:String = "invCanConvert";
       
      
      public var convertFilterCB:CheckBox;
      
      private var _canConvert:Boolean;
      
      public function BlueprintsFilterBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onResetAllFiltersHandler);
         this.convertFilterCB.removeEventListener(Event.SELECT,this.onConvertFilterCBSelectHandler);
         this.convertFilterCB.dispose();
         this.convertFilterCB = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onResetAllFiltersHandler);
         this.convertFilterCB.addEventListener(Event.SELECT,this.onConvertFilterCBSelectHandler);
         this.convertFilterCB.autoSize = TextFieldAutoSize.LEFT;
         this.convertFilterCB.label = STORAGE.BLUEPRINTS_CHECKBOX_LABEL;
         this.convertFilterCB.validateNow();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_CAN_CONVERT))
         {
            this.convertFilterCB.selected = this._canConvert;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.convertFilterCB.x = searchInput.x - this.convertFilterCB.width - CONVERT_FILTER_CHECKBOX_X_OFFSET | 0;
         }
      }
      
      public function updateCanConvert(param1:Boolean) : void
      {
         if(this.convertFilterCB.selected != param1)
         {
            this._canConvert = param1;
            invalidate(INV_CAN_CONVERT);
         }
      }
      
      override protected function get filterPopoverAlias() : String
      {
         return Aliases.STORAGE_BLUEPRINTS_FILTER_POPOVER;
      }
      
      private function onConvertFilterCBSelectHandler(param1:Event) : void
      {
         this._canConvert = this.convertFilterCB.selected;
         dispatchEvent(new FiltersEvent(FiltersEvent.FILTERS_CHANGED,int(this.convertFilterCB.selected)));
      }
      
      private function onResetAllFiltersHandler(param1:Event) : void
      {
         this._canConvert = false;
         invalidate(INV_CAN_CONVERT);
      }
   }
}
