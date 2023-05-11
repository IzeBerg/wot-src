package net.wg.gui.battle.views.questProgress.animated
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimIconContainer extends Sprite implements IDisposable
   {
       
      
      public var taskIcon:UILoaderAlt = null;
      
      private var _disposed:Boolean = false;
      
      public function AnimIconContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.taskIcon.dispose();
         this.taskIcon = null;
      }
      
      public function set source(param1:String) : void
      {
         this.taskIcon.source = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
