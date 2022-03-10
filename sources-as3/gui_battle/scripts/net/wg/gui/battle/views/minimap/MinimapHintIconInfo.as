package net.wg.gui.battle.views.minimap
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MinimapHintIconInfo extends MovieClip implements IDisposable
   {
       
      
      public var icons:MinimapIconCollection = null;
      
      private var _disposed:Boolean = false;
      
      public function MinimapHintIconInfo()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icons.dispose();
         this.icons = null;
      }
      
      public function setIconType(param1:uint) : void
      {
         this.icons.setIconType(param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
