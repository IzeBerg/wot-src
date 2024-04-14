package net.wg.gui.lobby.vehicleInfo
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class BaseBlock extends Sprite implements IVehicleInfoBlock
   {
       
      
      public var baseName:TextField;
      
      private var _disposed:Boolean = false;
      
      public function BaseBlock()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.baseName = null;
      }
      
      public function setData(param1:Object) : void
      {
         this.baseName.text = String(param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
