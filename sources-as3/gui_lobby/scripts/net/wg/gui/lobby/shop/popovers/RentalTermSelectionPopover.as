package net.wg.gui.lobby.shop.popovers
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.lobby.shop.controls.RentalTermSlotButton;
   import net.wg.gui.lobby.shop.data.RentalTermSelectionPopoverVO;
   import net.wg.infrastructure.base.meta.IRentalTermSelectionPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.RentalTermSelectionPopoverMeta;
   import scaleform.clik.controls.ButtonGroup;
   
   public class RentalTermSelectionPopover extends RentalTermSelectionPopoverMeta implements IRentalTermSelectionPopoverMeta
   {
      
      private static const SLOT_HEIGHT:int = 38;
      
      private static const SLOT_GAP:int = 10;
      
      private static const SLOT_WIDTH:int = 280;
      
      private static const BOTTOM_PADDING:int = 20;
       
      
      public var lblTitle:TextField;
      
      public var group:GroupEx;
      
      private var _btnGroup:ButtonGroup;
      
      public function RentalTermSelectionPopover()
      {
         super();
         this._btnGroup = ButtonGroup.getGroup(RentalTermSlotButton.RENTAL_TERM_GROUP,this.group);
      }
      
      override protected function setInitData(param1:RentalTermSelectionPopoverVO) : void
      {
         if(param1.rentalTermSlots != null)
         {
            this.lblTitle.htmlText = param1.titleLabel;
            this.group.dataProvider = param1.rentalTermSlots;
            this.group.height = SLOT_HEIGHT * param1.rentalTermSlots.length + SLOT_GAP * (param1.rentalTermSlots.length - 1);
            height = this.group.height + this.group.y + BOTTOM_PADDING;
         }
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      override protected function onDispose() : void
      {
         this.lblTitle = null;
         this._btnGroup.removeEventListener(Event.CHANGE,this.onGroupChangeHandler);
         this._btnGroup.dispose();
         this._btnGroup = null;
         this.group.dispose();
         this.group = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.group.itemRendererLinkage = Linkages.RENTAL_TERM_SLOT_BUTTON_UI;
         var _loc1_:VerticalGroupLayout = new VerticalGroupLayout();
         _loc1_.gap = SLOT_GAP;
         this.group.layout = _loc1_;
         this.group.width = SLOT_WIDTH;
         this._btnGroup.addEventListener(Event.CHANGE,this.onGroupChangeHandler);
      }
      
      private function onGroupChangeHandler(param1:Event) : void
      {
         selectTermS(RentalTermSlotButton(this._btnGroup.selectedButton).itemId);
      }
   }
}
