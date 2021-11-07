package net.wg.gui.lobby.storage.categories.cards.configs
{
   import flash.geom.Rectangle;
   import net.wg.utils.StageSizeBoundaries;
   
   public class CustomizationCardImageConfig extends CardImageConfig
   {
       
      
      public function CustomizationCardImageConfig()
      {
         super();
      }
      
      override public function initialize() : void
      {
         _imagesByResolution[StageSizeBoundaries.WIDTH_1024] = _imagesByResolution[StageSizeBoundaries.WIDTH_1366] = new CardImageSizeVO(new Rectangle(-1,18,80,80),new Rectangle(-1,18,178,80));
         _imagesByResolution[StageSizeBoundaries.WIDTH_1600] = _imagesByResolution[StageSizeBoundaries.WIDTH_1920] = new CardImageSizeVO(new Rectangle(-1,28,102,102),new Rectangle(-1,28,226,102));
      }
   }
}
