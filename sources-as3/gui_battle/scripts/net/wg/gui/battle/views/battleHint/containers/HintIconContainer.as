package net.wg.gui.battle.views.battleHint.containers
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintIconContainer extends Sprite implements IDisposable
   {
       
      
      public var icon:UILoaderAlt = null;
      
      private var _disposed:Boolean = false;
      
      public function HintIconContainer()
      {
         super();
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler,false,0,true);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.dispose();
         this.icon = null;
      }
      
      public function clear() : void
      {
         this.icon.unload();
      }
      
      public function setHintData(param1:String) : void
      {
         this.icon.source = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent) : void
      {
         this.icon.x = -this.icon.width >> 1;
      }
   }
}
