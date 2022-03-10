package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DogTagIcon extends Sprite implements IDisposable
   {
       
      
      public var icon:IImage = null;
      
      private var _disposed:Boolean = false;
      
      public function DogTagIcon()
      {
         super();
         this.icon.source = RES_ICONS.MAPS_ICONS_LIBRARY_DOG_TAG_MEDAL;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icon.dispose();
         this.icon = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
