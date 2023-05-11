package net.wg.gui.lobby.battleMatters.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.containers.AnimatedHtmlTextContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimatedMovieClipContainer extends MovieClip implements IDisposable
   {
       
      
      public var content:MovieClip = null;
      
      public var contentText:AnimatedHtmlTextContainer = null;
      
      private var _disposed:Boolean = false;
      
      public function AnimatedMovieClipContainer()
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
         this.content = null;
         if(this.contentText)
         {
            this.contentText.dispose();
            this.contentText = null;
         }
      }
      
      public function addContent(param1:DisplayObject) : void
      {
         this.content.addChild(param1);
      }
      
      public function removeAllContent() : void
      {
         while(this.content.numChildren)
         {
            this.content.removeChildAt(0);
         }
      }
      
      public function set frame(param1:String) : void
      {
         this.content.gotoAndStop(param1);
      }
      
      public function set text(param1:String) : void
      {
         this.contentText.text = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
