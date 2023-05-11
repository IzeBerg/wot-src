package net.wg.gui.components.popovers
{
   import flash.text.TextField;
   import net.wg.data.VO.ButtonPropertiesVO;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.gui.components.interfaces.IVehicleSelector;
   import net.wg.gui.components.popovers.data.VehicleSelectPopoverVO;
   import net.wg.gui.components.popovers.events.VehicleSelectRendererEvent;
   import net.wg.gui.components.popovers.interfaces.IVehicleSelectPopoverVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
   import net.wg.infrastructure.base.meta.IVehicleSelectPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleSelectPopoverMeta;
   import net.wg.infrastructure.interfaces.IWrapper;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleSelectPopoverBase extends VehicleSelectPopoverMeta implements IVehicleSelectPopoverMeta
   {
       
      
      public var selector:IVehicleSelector;
      
      public var addButton:IconTextButton;
      
      public var cancelButton:ISoundButtonEx;
      
      public var infoTF:TextField;
      
      protected var initData:IVehicleSelectPopoverVO;
      
      public function VehicleSelectPopoverBase()
      {
         super();
      }
      
      override protected function setInitData(param1:IVehicleSelectPopoverVO) : void
      {
         this.initData = param1;
         invalidateData();
      }
      
      override protected function getIVehicleSelectPopoverVOForData(param1:Object) : IVehicleSelectPopoverVO
      {
         return new VehicleSelectPopoverVO(param1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.initData && isInvalid(InvalidationType.DATA))
         {
            this.selector.setHeaderDP(this.initData.tableHeaders);
            this.selector.setFiltersData(this.initData.filters);
            this.selector.addEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersViewChangeHandler);
            this.cancelButton.label = this.initData.btnCancel;
            this.infoTF.htmlText = this.initData.header;
         }
      }
      
      override protected function onDispose() : void
      {
         this.selector.removeEventListener(VehicleSelectRendererEvent.RENDERER_CLICK,this.onSelectorRendererClickHandler);
         this.selector.removeEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersViewChangeHandler);
         this.selector.dispose();
         this.selector = null;
         this.disposeAddButton();
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.cancelButton.dispose();
         this.cancelButton = null;
         this.infoTF = null;
         this.initData = null;
         super.onDispose();
      }
      
      protected function disposeAddButton() : void
      {
         this.addButton.removeEventListener(ButtonEvent.CLICK,this.onAddButtonClickHandler);
         this.addButton.dispose();
         this.addButton = null;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.selector.addEventListener(VehicleSelectRendererEvent.RENDERER_CLICK,this.onSelectorRendererClickHandler);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.configAddButton();
      }
      
      protected function configAddButton() : void
      {
         this.addButton.addEventListener(ButtonEvent.CLICK,this.onAddButtonClickHandler);
         this.addButton.mouseEnabledOnDisabled = true;
      }
      
      override protected function setAddButtonState(param1:ButtonPropertiesVO) : void
      {
         this.addButton.tooltip = param1.btnTooltip;
         this.addButton.label = param1.btnLabel;
         this.addButton.enabled = param1.btnEnabled;
         this.addButton.iconSource = param1.btnIcon;
      }
      
      public function as_getTableDP() : Object
      {
         return this.selector.getListDP();
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         PopOver(param1).isCloseBtnVisible = true;
      }
      
      private function onAddButtonClickHandler(param1:ButtonEvent) : void
      {
         addButtonClickedS();
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onFiltersViewChangeHandler(param1:VehicleSelectorFilterEvent) : void
      {
         applyFiltersS(param1.nation,param1.vehicleType,param1.level,param1.isMain,param1.compatibleOnly);
      }
      
      private function onSelectorRendererClickHandler(param1:VehicleSelectRendererEvent) : void
      {
         setVehicleSelectedS(param1.dbID,param1.autoClose);
      }
      
      public function as_updateTableSortField(param1:String, param2:String) : void
      {
         this.selector.updateTableSortField(param1,param2);
      }
   }
}
