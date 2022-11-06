package net.wg.gui.lobby.storage.categories.cards.configs
{
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.StageSizeBoundaries;
   
   public class CardImageConfig implements IDisposable
   {
       
      
      protected var _imagesByResolution:Object;
      
      private var _disposed:Boolean = false;
      
      public function CardImageConfig()
      {
         this._imagesByResolution = {};
         super();
      }
      
      public function initialize() : void
      {
         this._imagesByResolution[StageSizeBoundaries.WIDTH_1024] = this._imagesByResolution[StageSizeBoundaries.WIDTH_1366] = new CardImageSizeVO(new Rectangle(-1,-1,144,108),new Rectangle(-1,-1,144,108));
         this._imagesByResolution[StageSizeBoundaries.WIDTH_1600] = this._imagesByResolution[StageSizeBoundaries.WIDTH_1920] = new CardImageSizeVO(new Rectangle(-1,-1,180,135),new Rectangle(-1,-1,180,135));
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._imagesByResolution = App.utils.data.cleanupDynamicObject(this._imagesByResolution);
      }
      
      public function getConfig(param1:int) : CardImageSizeVO
      {
         return this._imagesByResolution[param1];
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
