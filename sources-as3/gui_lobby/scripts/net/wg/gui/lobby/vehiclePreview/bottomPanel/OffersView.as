package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.lobby.vehiclePreview.VehiclePreviewEvent;
   import net.wg.gui.lobby.vehiclePreview.data.VPOfferVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   
   [Event(name="VehiclePreviewEvent:select",type="net.wg.gui.lobby.vehiclePreview.VehiclePreviewEvent")]
   public class OffersView extends UIComponentEx
   {
      
      private static const REAL_RENDERER_WIDTH_FOR_BUTTON_BAR:int = OfferRenderer.WIDTH + 12 * 2;
       
      
      public var buttons:ButtonBarEx = null;
      
      public function OffersView()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.buttons.removeEventListener(IndexEvent.INDEX_CHANGE,this.onButtonIndexChangeHandler);
         this.buttons.dispose();
         this.buttons = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.buttons.addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonIndexChangeHandler);
      }
      
      public function setData(param1:DataProvider) : void
      {
         var _loc2_:int = 0;
         _loc2_ = -1;
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(VPOfferVO(param1[_loc4_]).active)
            {
               _loc2_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         width = (OfferRenderer.WIDTH + OfferRenderer.SPACING) * param1.length - OfferRenderer.SPACING;
         this.buttons.width = (REAL_RENDERER_WIDTH_FOR_BUTTON_BAR + OfferRenderer.SPACING) * param1.length - OfferRenderer.SPACING;
         this.buttons.dataProvider = param1;
         this.buttons.selectedIndex = _loc2_;
      }
      
      private function onButtonIndexChangeHandler(param1:IndexEvent) : void
      {
         dispatchEvent(new VehiclePreviewEvent(VehiclePreviewEvent.SELECT,param1.data));
      }
   }
}
