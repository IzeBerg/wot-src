package net.wg.gui.bootcamp.lobby
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.views.ContentBuyView;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyContentVo;
   
   public class BCVehicleBuyView extends ContentBuyView
   {
       
      
      public var freePrice:TextField;
      
      public var priceText:IconText;
      
      public var strike:MovieClip;
      
      public function BCVehicleBuyView()
      {
         super();
      }
      
      override protected function drawContent(param1:VehicleBuyContentVo) : void
      {
         super.drawContent(param1);
         freeRentSlot.visible = false;
         crewInVehicle.visible = false;
         crewCheckbox.visible = false;
         ammoCheckbox.visible = false;
         ammoPrice.visible = false;
         ammoActionPrice.visible = false;
         ammoDashLine.visible = false;
         slotCheckbox.visible = false;
         slotPrice.visible = false;
         slotActionPrice.visible = false;
         slotDashLine.visible = false;
         this.strike.mouseEnabled = this.priceText.mouseEnabled = false;
         this.strike.mouseChildren = this.priceText.mouseChildren = false;
         resultGoldPrice.visible = false;
         academyBtn.showPriceLabel = false;
         var _loc2_:ActionPriceVO = param1.studyAcademyVo.actionPrice;
         this.priceText.text = String(_loc2_.oldPrice);
         this.priceText.icon = _loc2_.ico;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.freePrice.autoSize = TextFieldAutoSize.LEFT;
         this.freePrice.text = BOOTCAMP.PROMO_VEHICLEBUYVIEW;
      }
      
      override protected function onDispose() : void
      {
         this.freePrice = null;
         this.priceText.dispose();
         this.priceText = null;
         this.strike = null;
         super.onDispose();
      }
   }
}
