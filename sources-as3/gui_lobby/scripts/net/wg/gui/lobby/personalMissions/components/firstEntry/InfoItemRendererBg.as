package net.wg.gui.lobby.personalMissions.components.firstEntry
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class InfoItemRendererBg extends Sprite implements IDisposable
   {
       
      
      public var sprite:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function InfoItemRendererBg()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.sprite = null;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this.sprite.width = param1;
         this.sprite.height = param2;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
