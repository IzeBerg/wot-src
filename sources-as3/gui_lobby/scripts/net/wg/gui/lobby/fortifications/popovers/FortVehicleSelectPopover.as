package net.wg.gui.lobby.fortifications.popovers
{
   import net.wg.data.VO.ButtonPropertiesVO;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.gui.components.popovers.interfaces.IVehicleSelectPopoverVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.fortifications.cmp.selector.FortVehicleSelector;
   import net.wg.gui.lobby.fortifications.data.popover.FortVehicleSelectPopoverVO;
   import net.wg.infrastructure.base.meta.IFortVehicleSelectPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.FortVehicleSelectPopoverMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class FortVehicleSelectPopover extends FortVehicleSelectPopoverMeta implements IFortVehicleSelectPopoverMeta
   {
      
      private static const SMALL_BTN_WIDTH:int = 120;
      
      private static const CANCEL_X_OFFSET:int = 20;
       
      
      public var confirmButton:ISoundButtonEx = null;
      
      public function FortVehicleSelectPopover()
      {
         super();
      }
      
      override protected function getIVehicleSelectPopoverVOForData(param1:Object) : IVehicleSelectPopoverVO
      {
         return new FortVehicleSelectPopoverVO(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         selector.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleTypeItemClickHandler);
      }
      
      override protected function configAddButton() : void
      {
         this.confirmButton.addEventListener(ButtonEvent.CLICK,this.onConfirmButtonClickHandler);
         this.confirmButton.mouseEnabledOnDisabled = true;
      }
      
      override protected function disposeAddButton() : void
      {
         this.confirmButton.removeEventListener(ButtonEvent.CLICK,this.onConfirmButtonClickHandler);
         this.confirmButton.dispose();
         this.confirmButton = null;
      }
      
      override protected function setAddButtonState(param1:ButtonPropertiesVO) : void
      {
         this.confirmButton.tooltip = param1.btnTooltip;
         this.confirmButton.label = param1.btnLabel;
         this.confirmButton.enabled = param1.btnEnabled;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(initData)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               if(!initData.isMultiSelect)
               {
                  this.confirmButton.width = SMALL_BTN_WIDTH;
                  cancelButton.x = this.confirmButton.x + this.confirmButton.width + CANCEL_X_OFFSET;
               }
               invalidateSize();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         selector.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleTypeItemClickHandler);
         super.onDispose();
      }
      
      private function onConfirmButtonClickHandler(param1:ButtonEvent) : void
      {
         addButtonClickedS();
      }
      
      private function onVehicleTypeItemClickHandler(param1:RendererEvent) : void
      {
         var _loc3_:IListItemRenderer = null;
         var _loc2_:FortVehicleSelector = selector as FortVehicleSelector;
         if(_loc2_)
         {
            _loc3_ = _loc2_.toggles.getRendererAt(param1.index);
            if(_loc3_ == param1.target)
            {
               onFilterChangeS(param1.index,_loc3_.selectable);
            }
         }
         param1.stopPropagation();
      }
   }
}
