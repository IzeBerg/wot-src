package net.wg.gui.battle.views.minimap.components.entries.fallout.absorptionFlag.containers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AbsorptionFlagAnimContainer extends MovieClip implements IDisposable
   {
       
      
      public var animItem:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function AbsorptionFlagAnimContainer()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.animItem = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
