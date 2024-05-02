package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ItemSlot extends Sprite implements IDisposable
   {
      
      private static const ITEM_SLOT_H:int = 32;
      
      private static const ITEM_SLOT_W:int = 62;
       
      
      public var img:Image = null;
      
      private var _disposed:Boolean = false;
      
      public function ItemSlot()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.img.dispose();
         this.img = null;
      }
      
      public function layout() : void
      {
         this.img.height = ITEM_SLOT_H;
         this.img.scaleX = this.img.scaleY;
         if(this.img.width > ITEM_SLOT_W)
         {
            this.img.width = ITEM_SLOT_W;
            this.img.scaleY = this.img.scaleX;
         }
         this.img.x = ITEM_SLOT_W - this.img.width >> 1;
         this.img.y = ITEM_SLOT_H - this.img.height >> 1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
