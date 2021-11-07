package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.lobby.vehiclePreview.data.VPCouponVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CouponView extends UIComponentEx
   {
       
      
      public var coupon:CouponRenderer = null;
      
      public var label:TextField = null;
      
      public var plus:MovieClip = null;
      
      public function CouponView()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.coupon.removeEventListener(MouseEvent.CLICK,this.onCouponClickHandler);
         this.coupon.dispose();
         this.coupon = null;
         this.label = null;
         this.plus = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.coupon.addEventListener(MouseEvent.CLICK,this.onCouponClickHandler);
      }
      
      public function getSelect() : Boolean
      {
         return this.coupon.selected;
      }
      
      public function setCouponDiscount(param1:int) : void
      {
         this.coupon.setCouponDiscount(param1);
      }
      
      public function setData(param1:VPCouponVO) : void
      {
         this.coupon.data = param1;
         this.label.htmlText = param1.label;
         App.utils.commons.updateTextFieldSize(this.label);
         this.label.y = this.coupon.y + (this.coupon.height - this.label.height) >> 1;
         this.plus.x = this.label.x + this.label.textWidth;
      }
      
      private function onCouponClickHandler(param1:Event) : void
      {
         this.coupon.selected = !this.coupon.selected;
         dispatchEvent(new Event(Event.SELECT));
      }
   }
}
