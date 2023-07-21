package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.ICarouselEventEntryMeta;
   import net.wg.infrastructure.base.meta.impl.CarouselEventEntryMeta;
   
   public class CarouselEventEntry extends CarouselEventEntryMeta implements ICarouselEventEntryMeta
   {
      
      private static const WRAPPER_MARGIN:int = 2;
      
      private static const WRAPPER_WIDTH_BIG:int = 275 + WRAPPER_MARGIN;
      
      private static const WRAPPER_HEIGHT_BIG:int = 275 + WRAPPER_MARGIN;
      
      private static const WRAPPER_WIDTH_SMALL:int = 150 + WRAPPER_MARGIN;
      
      private static const WRAPPER_HEIGHT_SMALL:int = 150 + WRAPPER_MARGIN;
      
      private static const ENTRY_POINT_WIDTH_BIG:int = 222;
      
      private static const ENTRY_POINT_HEIGHT_BIG:int = 214;
      
      private static const ENTRY_POINT_WIDTH_SMALL:int = 114;
      
      private static const ENTRY_POINT_HEIGHT_SMALL:int = 114;
      
      private static const ENTRY_POINT_MARGIN_LEFT_BIG:int = (ENTRY_POINT_WIDTH_BIG - WRAPPER_WIDTH_BIG >> 1) - 10;
      
      private static const ENTRY_POINT_MARGIN_TOP_BIG:int = (ENTRY_POINT_HEIGHT_BIG - WRAPPER_HEIGHT_BIG >> 1) + 20;
      
      private static const ENTRY_POINT_MARGIN_LEFT_SMALL:int = (ENTRY_POINT_WIDTH_SMALL - WRAPPER_WIDTH_SMALL >> 1) - 10;
      
      private static const ENTRY_POINT_MARGIN_TOP_SMALL:int = (ENTRY_POINT_HEIGHT_SMALL - WRAPPER_HEIGHT_SMALL >> 1) + 10;
       
      
      private var _isSmall:Boolean = false;
      
      public function CarouselEventEntry()
      {
         super();
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         this._isSmall = param1;
         var _loc2_:int = !!param1 ? int(WRAPPER_WIDTH_SMALL) : int(WRAPPER_WIDTH_BIG);
         var _loc3_:int = !!param1 ? int(WRAPPER_HEIGHT_SMALL) : int(WRAPPER_HEIGHT_BIG);
         setSize(_loc2_,_loc3_);
         validateNow();
      }
      
      public function get entryPointWidth() : int
      {
         return !!this._isSmall ? int(ENTRY_POINT_WIDTH_SMALL) : int(ENTRY_POINT_WIDTH_BIG);
      }
      
      public function get marginTop() : int
      {
         return !!this._isSmall ? int(ENTRY_POINT_MARGIN_TOP_SMALL) : int(ENTRY_POINT_MARGIN_TOP_BIG);
      }
      
      public function get marginLeft() : int
      {
         return !!this._isSmall ? int(ENTRY_POINT_MARGIN_LEFT_SMALL) : int(ENTRY_POINT_MARGIN_LEFT_BIG);
      }
   }
}
