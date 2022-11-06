package net.wg.gui.components.questProgress.components
{
   import flash.display.Sprite;
   import net.wg.gui.components.questProgress.interfaces.ITypedViewItem;
   
   public class SpriteComponent extends Sprite implements ITypedViewItem
   {
       
      
      private var _viewType:String = null;
      
      private var _disposed:Boolean = false;
      
      public function SpriteComponent()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
      }
      
      public function get viewType() : String
      {
         return this._viewType;
      }
      
      public function set viewType(param1:String) : void
      {
         this._viewType = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
