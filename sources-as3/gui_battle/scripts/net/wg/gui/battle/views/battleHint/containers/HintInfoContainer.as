package net.wg.gui.battle.views.battleHint.containers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintInfoContainer extends Sprite implements IDisposable
   {
       
      
      public var txt:TextField = null;
      
      public var highlight:UILoaderAlt = null;
      
      private var _disposed:Boolean = false;
      
      public function HintInfoContainer()
      {
         super();
         this.txt.autoSize = TextFieldAutoSize.CENTER;
         this.highlight.addEventListener(UILoaderEvent.COMPLETE,this.onHighlightCompleteHandler,false,0,true);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.highlight.removeEventListener(UILoaderEvent.COMPLETE,this.onHighlightCompleteHandler);
         this.highlight.dispose();
         this.txt = null;
         this.highlight = null;
      }
      
      public function clear() : void
      {
         this.txt.htmlText = Values.EMPTY_STR;
         this.highlight.unload();
         this.setOffset(0);
      }
      
      public function setHintData(param1:String, param2:String = null) : void
      {
         this.txt.htmlText = param1;
         this.highlight.source = param2;
      }
      
      public function setOffset(param1:int) : void
      {
         this.txt.y = param1;
         this.updateHighlightPosition();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      private function onHighlightCompleteHandler(param1:UILoaderEvent) : void
      {
         this.updateHighlightPosition();
      }
      
      private function updateHighlightPosition() : void
      {
         this.highlight.x = -this.highlight.width >> 1;
         this.highlight.y = this.txt.y + (this.txt.height - this.highlight.height >> 1) | 0;
      }
   }
}
