package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import net.wg.gui.components.carousels.ScrollCarousel;
   
   public class VPScrollCarousel extends ScrollCarousel
   {
       
      
      private var _scrollListOffset:int;
      
      private var _showArrows:Boolean = true;
      
      public function VPScrollCarousel()
      {
         super();
      }
      
      override public function get width() : Number
      {
         return !!this._showArrows ? Number(super.width) : Number(scrollList.width);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._scrollListOffset = scrollList.x;
      }
      
      override protected function updateLayout(param1:int, param2:int = 0) : void
      {
      }
      
      public function showArrows(param1:Boolean) : void
      {
         if(this._showArrows == param1)
         {
            return;
         }
         this._showArrows = hasScrollButtons = param1;
         leftArrow.visible = rightArrow.visible = param1;
         scrollList.x = !!param1 ? Number(this._scrollListOffset) : Number(0);
      }
   }
}
