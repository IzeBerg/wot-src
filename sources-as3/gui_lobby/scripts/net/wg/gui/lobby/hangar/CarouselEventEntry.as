package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.impl.CarouselEventEntryMeta;
   
   public class CarouselEventEntry extends CarouselEventEntryMeta
   {
      
      public static const WIDTH:int = 252;
      
      public static const HEIGHT:int = 252;
       
      
      public function CarouselEventEntry()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         setSize(WIDTH,HEIGHT);
      }
   }
}
