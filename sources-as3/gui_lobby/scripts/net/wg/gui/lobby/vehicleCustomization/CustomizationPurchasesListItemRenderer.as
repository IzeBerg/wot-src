package net.wg.gui.lobby.vehicleCustomization
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.ButtonIconTransparent;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchasesPopoverRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   
   public class CustomizationPurchasesListItemRenderer extends ListItemRenderer
   {
       
      
      public var purchaseName:TextFieldShort = null;
      
      public var price:TextField = null;
      
      public var currencyIcon:Image = null;
      
      public var salePrice:ActionPrice = null;
      
      public var removeCurrencytBtn:ButtonIconTransparent = null;
      
      private var _id:int = -1;
      
      private var _groupId:int = -1;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      public function CustomizationPurchasesListItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         var _loc2_:PurchasesPopoverRendererVO = PurchasesPopoverRendererVO(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.isTitle)
            {
               this.hideControls();
               this.purchaseName.label = _loc2_.name;
            }
            else
            {
               this.showControls();
               this.purchaseName.label = _loc2_.name;
               this.price.htmlText = _loc2_.price;
               this.currencyIcon.source = _loc2_.currencyIcon;
               this.removeCurrencytBtn.iconSource = _loc2_.removeItemIcon;
               this._id = _loc2_.idx;
               this._groupId = _loc2_.type;
               this.salePrice.setData(_loc2_.salePrice);
               this.price.visible = !this.salePrice.visible;
            }
            this.purchaseName.validateNow();
         }
         else
         {
            this.hideControls();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._toolTipMgr = App.toolTipMgr;
         this.purchaseName.useHtml = true;
         this.purchaseName.buttonMode = false;
         mouseEnabled = false;
         mouseChildren = true;
         this.removeCurrencytBtn.addEventListener(ButtonEvent.CLICK,this.onRemoveCurrencytBtnClickHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
      }
      
      override protected function onDispose() : void
      {
         this.removeCurrencytBtn.removeEventListener(ButtonEvent.CLICK,this.onRemoveCurrencytBtnClickHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.removeCurrencytBtn.dispose();
         this.removeCurrencytBtn = null;
         this.currencyIcon.dispose();
         this.currencyIcon = null;
         this.purchaseName.dispose();
         this.purchaseName = null;
         this.price = null;
         this.salePrice.dispose();
         this.salePrice = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      private function hideControls() : void
      {
         this.purchaseName.visible = false;
         this.currencyIcon.visible = false;
         this.removeCurrencytBtn.visible = false;
         this.price.visible = false;
         this.salePrice.visible = false;
      }
      
      private function showControls() : void
      {
         this.purchaseName.visible = true;
         this.currencyIcon.visible = true;
         this.removeCurrencytBtn.visible = true;
         this.price.visible = true;
         mouseChildren = true;
         this.salePrice.visible = true;
      }
      
      private function onRemoveCurrencytBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.REMOVE_ITEM,this._id,this._groupId));
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(param1.target != this.removeCurrencytBtn)
         {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM,null,this._id,-1);
         }
      }
   }
}
