package net.wg.gui.lobby.dialogs
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.lobby.dialogs.data.IconPriceDialogVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class PriceMc extends UIComponentEx
   {
      
      public static var IS_INVALID_PRICE:String = "isInvalidPrice";
      
      private static const OPERATION_INVALID:String = "opInv";
       
      
      public var dashLine:DashLine;
      
      public var textField:TextField;
      
      public var actionPrice:CompoundPrice;
      
      private var _allowed:Boolean = true;
      
      private var _priceData:IconPriceDialogVO = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function PriceMc()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this._tooltipMgr = null;
         this._priceData = null;
         this.dashLine.dispose();
         this.dashLine = null;
         this.textField = null;
         this.actionPrice.removeEventListener(MouseEvent.MOUSE_OVER,this.onActionPriceMouseOverHandler);
         this.actionPrice.dispose();
         this.actionPrice = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.dashLine.width = 305;
         this.actionPrice.addEventListener(MouseEvent.MOUSE_OVER,this.onActionPriceMouseOverHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:PriceVO = null;
         var _loc2_:PriceVO = null;
         var _loc3_:PriceVO = null;
         super.draw();
         if(this._priceData != null && isInvalid(IS_INVALID_PRICE))
         {
            this.actionPrice.setData(this._priceData.itemPrices[0]);
         }
         if(isInvalid(OPERATION_INVALID))
         {
            _loc1_ = new PriceVO([CURRENCIES_CONSTANTS.GOLD,int(this._allowed)]);
            _loc2_ = new PriceVO([CURRENCIES_CONSTANTS.CREDITS,int(this._allowed)]);
            _loc3_ = new PriceVO([CURRENCIES_CONSTANTS.CRYSTAL,int(this._allowed)]);
            this.actionPrice.updateEnoughStatuses(new <PriceVO>[_loc1_,_loc2_,_loc3_]);
         }
      }
      
      public function setPriceData(param1:IconPriceDialogVO) : void
      {
         this._priceData = param1;
         invalidate(IS_INVALID_PRICE);
      }
      
      public function get allowed() : Boolean
      {
         return this._allowed;
      }
      
      public function set allowed(param1:Boolean) : void
      {
         this._allowed = param1;
         invalidate(OPERATION_INVALID);
      }
      
      private function onActionPriceMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ActionPriceVO = this._priceData.actionPrice;
         if(_loc2_.newPrice > 0)
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,_loc2_.type,_loc2_.key,_loc2_.newPrices,_loc2_.oldPrices,_loc2_.isBuying,_loc2_.forCredits,_loc2_.rentPackage);
         }
      }
   }
}
