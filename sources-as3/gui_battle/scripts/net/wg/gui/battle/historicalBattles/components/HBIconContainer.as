package net.wg.gui.battle.historicalBattles.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HBIconContainer extends MovieClip implements IDisposable
   {
       
      
      public var icon:UILoaderAlt;
      
      private var _disposed:Boolean = false;
      
      public function HBIconContainer()
      {
         super();
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
         this.icon.dispose();
         this.icon = null;
      }
      
      public function get source() : String
      {
         return this.icon.source;
      }
      
      public function set source(param1:String) : void
      {
         this.icon.source = param1;
      }
   }
}
