package net.wg.gui.battle.eventBattle.views.radialMenu.components
{
   import flash.display.Sprite;
   import net.wg.gui.battle.views.radialMenu.components.Icons;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class IconRotationContainer extends Sprite implements IDisposable
   {
       
      
      public var icons:Icons = null;
      
      private var _disposed:Boolean = false;
      
      public function IconRotationContainer()
      {
         super();
      }
      
      public function showIcon(param1:String) : void
      {
         this.icons.showIcon(param1);
      }
      
      public function hideAll() : void
      {
      }
      
      public function setRotation(param1:Number) : void
      {
         this.icons.rotation = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icons.dispose();
         this.icons = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
