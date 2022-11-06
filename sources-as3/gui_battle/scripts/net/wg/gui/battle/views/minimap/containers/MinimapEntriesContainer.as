package net.wg.gui.battle.views.minimap.containers
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MinimapEntriesContainer extends Sprite implements IDisposable
   {
       
      
      public var points:Sprite = null;
      
      public var icons:Sprite = null;
      
      public var equipments:Sprite = null;
      
      public var deadVehicles:Sprite = null;
      
      public var aliveVehicles:Sprite = null;
      
      public var personal:Sprite = null;
      
      public var flags:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function MinimapEntriesContainer()
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
         this.points = null;
         this.icons = null;
         this.equipments = null;
         this.deadVehicles = null;
         this.aliveVehicles = null;
         this.personal = null;
         this.flags = null;
      }
   }
}
