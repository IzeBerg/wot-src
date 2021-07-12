package net.wg.gui.components.controls
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.LayoutMode;
   
   public class CurrencyContextMenuItem extends ContextMenuItem
   {
      
      private static const ITEMPRICE_INDEX:String = "price";
      
      private static const PRICE_ALERT_OFFSET:int = 153;
      
      private static const PRICE_NO_ALERT_OFFSET:int = 177;
       
      
      public var price:CompoundPrice;
      
      public var alertIcon:AlertIco = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _showAlert:Boolean = false;
      
      private var _tooltipVO:ActionPriceVO = null;
      
      public function CurrencyContextMenuItem()
      {
         this._tooltipMgr = App.toolTipMgr;
         autoSize = LayoutMode.ALIGN_NONE;
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraintsDisabled = true;
         this.alertIcon.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.price.dispose();
         this.price = null;
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.clearTooltipVO();
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.drawIcons();
         }
         scaleY = 1;
         scaleX = 1;
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         super.handleClick(param1);
         this._tooltipMgr.hide();
      }
      
      private function drawIcons() : void
      {
         var _loc1_:ItemPriceVO = null;
         if(data != null)
         {
            _loc1_ = new ItemPriceVO(data[ITEMPRICE_INDEX]);
            if(_loc1_ == null || this.price == null)
            {
               return;
            }
            this.price.setData(_loc1_);
            this.alertIcon.visible = this._showAlert;
            this.price.x = !!this._showAlert ? Number(PRICE_ALERT_OFFSET) : Number(PRICE_NO_ALERT_OFFSET);
         }
      }
      
      private function clearTooltipVO() : void
      {
         if(this._tooltipVO != null)
         {
            this._tooltipVO.dispose();
            this._tooltipVO = null;
         }
      }
      
      public function get showAlert() : Boolean
      {
         return this._showAlert;
      }
      
      public function set showAlert(param1:Boolean) : void
      {
         this._showAlert = param1;
      }
      
      public function get tooltipVO() : Object
      {
         return this._tooltipVO;
      }
      
      public function set tooltipVO(param1:Object) : void
      {
         this.clearTooltipVO();
         if(param1 != null)
         {
            this._tooltipVO = new ActionPriceVO(param1);
         }
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         if(this._tooltipVO != null)
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,this._tooltipVO.type,this._tooltipVO.key,this._tooltipVO.newPrices,this._tooltipVO.oldPrices,this._tooltipVO.isBuying,this._tooltipVO.forCredits,this._tooltipVO.rentPackage);
         }
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this._tooltipMgr.hide();
      }
   }
}
