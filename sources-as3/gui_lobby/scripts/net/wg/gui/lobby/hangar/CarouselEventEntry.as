package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.ICarouselEventEntryMeta;
   import net.wg.infrastructure.base.meta.impl.CarouselEventEntryMeta;
   
   public class CarouselEventEntry extends CarouselEventEntryMeta implements ICarouselEventEntryMeta
   {
      
      private static const WIDTH_BIG:int = 340;
      
      private static const WIDTH_SMALL:int = 274;
      
      private static const HEIGHT_BIG:int = 234;
      
      private static const HEIGHT_SMALL:int = 122;
      
      private static const MARGIN:int = 2;
       
      
      public function CarouselEventEntry()
      {
         super();
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         var _loc2_:int = !!param1 ? int(WIDTH_SMALL) : int(WIDTH_BIG);
         var _loc3_:int = !!param1 ? int(HEIGHT_SMALL) : int(HEIGHT_BIG);
         setSize(_loc2_ + MARGIN,_loc3_ + MARGIN);
         validateNow();
      }
   }
}
