package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimationIcon extends Sprite implements IDisposable
   {
       
      
      public var icon:UILoaderAlt = null;
      
      private var _disposed:Boolean = false;
      
      public function AnimationIcon()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.icon.dispose();
         this.icon = null;
      }
      
      public function setImage(param1:String) : void
      {
         this.icon.source = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
