package net.wg.gui.lobby.storage.categories.cards.configs
{
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CardImageSizeVO implements IDisposable
   {
       
      
      private var _imageSize:Rectangle;
      
      private var _imageSizeWide:Rectangle;
      
      private var _disposed:Boolean = false;
      
      public function CardImageSizeVO(param1:Rectangle, param2:Rectangle)
      {
         super();
         this._imageSize = param1;
         this._imageSizeWide = param2;
      }
      
      public function getRect(param1:Boolean) : Rectangle
      {
         return !!param1 ? this._imageSizeWide : this._imageSize;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._imageSize = null;
         this._imageSizeWide = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
