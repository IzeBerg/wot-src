package net.wg.gui.battle.views.minimap
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MinimapHint extends MovieClip implements IDisposable
   {
       
      
      public var iconInfoLeft:MinimapHintIconInfo = null;
      
      public var iconInfoRight:MinimapHintIconInfo = null;
      
      private var _disposed:Boolean = false;
      
      public function MinimapHint()
      {
         super();
      }
      
      public function setLeftMinimapHintIconType(param1:uint) : void
      {
         this.iconInfoLeft.setIconType(param1);
      }
      
      public function setRightMinimapHintIconType(param1:uint) : void
      {
         this.iconInfoRight.setIconType(param1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.iconInfoLeft.dispose();
         this.iconInfoRight.dispose();
         this.iconInfoLeft = null;
         this.iconInfoRight = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
