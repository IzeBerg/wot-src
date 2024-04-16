package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import flash.display.MovieClip;
   
   public class VehiclePreviewBottomPanelShowcaseStyleBuyingBg extends MovieClip
   {
      
      private static const EXTRA_LARGE_FRAME_LABEL:String = "extraLarge";
      
      private static const LARGE_FRAME_LABEL:String = "large";
      
      private static const MEDIUM_FRAME_LABEL:String = "medium";
      
      private static const SMALL_FRAME_LABEL:String = "small";
      
      private static const EXTRA_SMALL_FRAME_LABEL:String = "extraSmall";
      
      private static const SMALL_LONG_FRAME_LABEL:String = "smallLong";
      
      private static const LONG_HEIGHT:uint = 120;
      
      private static const STANDARD_HEIGHT:uint = 90;
      
      private static const WIDTH_OFFSET:uint = 80;
       
      
      private var _isLongHeight:Boolean = true;
      
      public function VehiclePreviewBottomPanelShowcaseStyleBuyingBg()
      {
         super();
      }
      
      public function useExtraLargeSize() : void
      {
         this._isLongHeight = true;
         gotoAndStop(EXTRA_LARGE_FRAME_LABEL);
      }
      
      public function useExtraSmallSize() : void
      {
         this._isLongHeight = false;
         gotoAndStop(EXTRA_SMALL_FRAME_LABEL);
      }
      
      public function useLargeSize() : void
      {
         this._isLongHeight = false;
         gotoAndStop(LARGE_FRAME_LABEL);
      }
      
      public function useMediumSize() : void
      {
         this._isLongHeight = false;
         gotoAndStop(MEDIUM_FRAME_LABEL);
      }
      
      public function useSmallLongSize() : void
      {
         this._isLongHeight = true;
         gotoAndStop(SMALL_LONG_FRAME_LABEL);
      }
      
      public function useSmallSize() : void
      {
         this._isLongHeight = false;
         gotoAndStop(SMALL_FRAME_LABEL);
      }
      
      override public function get height() : Number
      {
         if(this._isLongHeight)
         {
            return LONG_HEIGHT;
         }
         return STANDARD_HEIGHT;
      }
      
      override public function get width() : Number
      {
         return super.width - WIDTH_OFFSET;
      }
   }
}
