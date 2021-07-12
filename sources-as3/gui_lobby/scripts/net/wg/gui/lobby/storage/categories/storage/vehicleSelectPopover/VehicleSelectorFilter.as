package net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropDownImageText;
   import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ListEvent;
   
   public class VehicleSelectorFilter extends UIComponentEx
   {
      
      private static const VEHICLE_TYPE_POS:int = 57;
      
      private static const MAIN_CB_POS:int = 117;
      
      private static const MIN_LEVELS_TO_HIDE_DD:int = 2;
       
      
      public var levelDD:DropDownImageText;
      
      public var nationDD:DropDownImageText;
      
      public var vehicleTypeDD:DropDownImageText;
      
      public var mainCheckBox:CheckBox;
      
      private var _model:IVehicleSelectorFilterVO;
      
      private var _changeHandlersInited:Boolean = false;
      
      public function VehicleSelectorFilter()
      {
         super();
      }
      
      private static function onFiltersRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model && isInvalid(InvalidationType.DATA))
         {
            this.vehicleTypeDD.dataProvider = this._model.vehicleTypesDP;
            this.vehicleTypeDD.selectedIndex = 0;
            this.levelDD.dataProvider = this._model.levelsDP;
            this.levelDD.selectedIndex = 0;
            this.nationDD.dataProvider = this._model.nationDP;
            this.nationDD.selectedIndex = 0;
            this.selectNation(this._model.nation);
            this.selectVehicleType(this._model.vehicleType);
            this.selectLevel(this._model.level);
            if(!this._changeHandlersInited)
            {
               this.initChangeHandlers();
               this._changeHandlersInited = true;
               this.onFiltersIndexChangeHandler();
            }
            if(this._model.levelsDP.length <= MIN_LEVELS_TO_HIDE_DD)
            {
               this.levelDD.visible = false;
               this.nationDD.x = 0;
               this.vehicleTypeDD.x = VEHICLE_TYPE_POS;
               this.mainCheckBox.x = MAIN_CB_POS;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.nationDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.vehicleTypeDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.levelDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.mainCheckBox.removeEventListener(Event.SELECT,this.onFiltersIndexChangeHandler);
         this.nationDD.removeEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.vehicleTypeDD.removeEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.levelDD.removeEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.mainCheckBox.removeEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.nationDD.removeEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.vehicleTypeDD.removeEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.levelDD.removeEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.mainCheckBox.removeEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.nationDD.removeEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.vehicleTypeDD.removeEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.levelDD.removeEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.mainCheckBox.removeEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.nationDD.dispose();
         this.vehicleTypeDD.dispose();
         this.levelDD.dispose();
         this.mainCheckBox.dispose();
         this.levelDD = null;
         this.nationDD = null;
         this.vehicleTypeDD = null;
         this.mainCheckBox = null;
         this._model = null;
         super.onDispose();
      }
      
      public function setData(param1:IVehicleSelectorFilterVO) : void
      {
         this._model = param1;
         invalidate(InvalidationType.DATA);
      }
      
      private function initChangeHandlers() : void
      {
         this.nationDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.vehicleTypeDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.levelDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.mainCheckBox.addEventListener(Event.SELECT,this.onFiltersIndexChangeHandler);
         this.nationDD.addEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.vehicleTypeDD.addEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.levelDD.addEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.mainCheckBox.addEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.nationDD.addEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.vehicleTypeDD.addEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.levelDD.addEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.mainCheckBox.addEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.nationDD.addEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.vehicleTypeDD.addEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.levelDD.addEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.mainCheckBox.addEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
      }
      
      private function onFiltersIndexChangeHandler(param1:Event = null) : void
      {
         App.toolTipMgr.hide();
         var _loc2_:Object = this.nationDD.dataProvider.requestItemAt(this.nationDD.selectedIndex);
         var _loc3_:Object = this.vehicleTypeDD.dataProvider.requestItemAt(this.vehicleTypeDD.selectedIndex);
         var _loc4_:Object = this.levelDD.dataProvider.requestItemAt(this.levelDD.selectedIndex);
         var _loc5_:VehicleSelectorFilterEvent = new VehicleSelectorFilterEvent(VehicleSelectorFilterEvent.CHANGE,true);
         _loc5_.nation = Boolean(_loc2_) ? int(_loc2_.data) : int(-1);
         _loc5_.vehicleType = Boolean(_loc3_) ? _loc3_.data : null;
         _loc5_.level = Boolean(_loc4_) ? int(_loc4_.data) : int(-1);
         _loc5_.isMain = this.mainCheckBox.selected;
         dispatchEvent(_loc5_);
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
      
      private function selectVehicleType(param1:String) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.vehicleTypeDD.dataProvider)
         {
            if(_loc2_.data == param1)
            {
               this.vehicleTypeDD.selectedIndex = this.vehicleTypeDD.dataProvider.indexOf(_loc2_);
               return;
            }
         }
      }
      
      private function selectLevel(param1:int) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.levelDD.dataProvider)
         {
            if(_loc2_.data == param1)
            {
               this.levelDD.selectedIndex = this.levelDD.dataProvider.indexOf(_loc2_);
               return;
            }
         }
      }
      
      private function onFiltersRollOverHandler(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.nationDD:
               App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_NATION);
               break;
            case this.vehicleTypeDD:
               App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_VEHTYPE);
               break;
            case this.levelDD:
               App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_VEHLVL);
               break;
            case this.mainCheckBox:
               App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_MAINVEHICLE);
         }
      }
   }
}
