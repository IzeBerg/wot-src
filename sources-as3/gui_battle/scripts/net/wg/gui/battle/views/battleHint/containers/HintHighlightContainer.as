package net.wg.gui.battle.views.battleHint.containers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintHighlightContainer extends MovieClip implements IDisposable
   {
       
      
      public var highlight:UILoaderAlt = null;
      
      private var _txt:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function HintHighlightContainer()
      {
         super();
         this.highlight.addEventListener(UILoaderEvent.COMPLETE,this.onHighlightCompleteHandler,false,0,true);
      }
      
      public function setTextField(param1:TextField) : void
      {
         if(this._txt == param1)
         {
            return;
         }
         this._txt = param1;
         this.updatePosition();
      }
      
      public final function dispose() : void
      {
         this.highlight.removeEventListener(UILoaderEvent.COMPLETE,this.onHighlightCompleteHandler);
         this.highlight.dispose();
         this.highlight = null;
         this._txt = null;
         this._disposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function clear() : void
      {
         this.highlight.unload();
      }
      
      public function setHighlight(param1:String = null) : void
      {
         this.highlight.source = param1;
      }
      
      private function onHighlightCompleteHandler(param1:UILoaderEvent) : void
      {
         this.updatePosition();
      }
      
      public function updatePosition() : void
      {
         this.highlight.x = -this.highlight.width >> 1;
         this.highlight.y = this._txt.y + (this._txt.height - this.highlight.height >> 1) | 0;
      }
   }
}
