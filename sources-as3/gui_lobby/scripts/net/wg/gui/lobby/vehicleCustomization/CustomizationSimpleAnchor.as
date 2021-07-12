package net.wg.gui.lobby.vehicleCustomization
{
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotUpdateVO;
   
   public class CustomizationSimpleAnchor extends CustomizationEndPointIcon
   {
      
      private static const EMPTY_STATE:int = 1;
      
      private static const FILLED_STATE:int = 2;
      
      private static const ZOOM_IN_FRAME_LABEL:String = "zoomIn";
      
      private static const ZOOM_OUT_FRAME_LABEL:String = "zoomOut";
       
      
      private var _isZoomed:Boolean = false;
      
      public function CustomizationSimpleAnchor()
      {
         super();
      }
      
      override public function playZoomIn() : void
      {
         if(isAnchorFilled())
         {
            if(!this._isZoomed)
            {
               gotoAndPlay(ZOOM_IN_FRAME_LABEL);
            }
            this._isZoomed = true;
         }
      }
      
      override public function playZoomOut() : void
      {
         if(isAnchorFilled())
         {
            if(this._isZoomed)
            {
               gotoAndPlay(ZOOM_OUT_FRAME_LABEL);
            }
            this._isZoomed = false;
         }
      }
      
      override public function setSlotData(param1:CustomizationSlotUpdateVO) : void
      {
         var _loc2_:int = 0;
         if(param1 && slotData != param1)
         {
            super.setSlotData(param1);
            _loc2_ = !!isAnchorFilled() ? int(FILLED_STATE) : int(EMPTY_STATE);
            gotoAndStop(_loc2_);
            this._isZoomed = false;
         }
      }
      
      override protected function onDispose() : void
      {
         hitArea = null;
         super.onDispose();
      }
   }
}
