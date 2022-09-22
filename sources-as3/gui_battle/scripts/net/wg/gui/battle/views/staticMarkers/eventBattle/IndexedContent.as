package net.wg.gui.battle.views.staticMarkers.eventBattle
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class IndexedContent extends MovieClip implements IDisposable
   {
       
      
      public var indexField:TextField = null;
      
      public var icon:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function IndexedContent()
      {
         super();
      }
      
      public function setIndex(param1:int) : void
      {
         this.indexField.text = param1.toString();
      }
      
      public function setAlpha(param1:Number) : void
      {
         this.icon.alpha = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      protected function onDispose() : void
      {
         this.indexField = null;
         this.icon = null;
      }
   }
}
