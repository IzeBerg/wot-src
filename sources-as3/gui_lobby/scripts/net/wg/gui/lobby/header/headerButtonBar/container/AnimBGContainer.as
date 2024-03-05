package net.wg.gui.lobby.header.headerButtonBar.container
{
   import flash.display.MovieClip;
   
   public class AnimBGContainer extends MovieClip
   {
       
      
      private var _content:MovieClip = null;
      
      private var _linkage:String = "";
      
      private var _disposed:Boolean = false;
      
      public function AnimBGContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.stopAnim();
         this._content = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function playAnim() : void
      {
         if(this._content)
         {
            this._content.play();
         }
      }
      
      public function setAnimLinkage(param1:String) : void
      {
         if(this._linkage == param1)
         {
            return;
         }
         if(this._content)
         {
            this._content.stop();
            removeChild(this._content);
         }
         this._content = App.utils.classFactory.getComponent(param1,MovieClip);
         addChild(this._content);
      }
      
      public function stopAnim() : void
      {
         stop();
         if(this._content)
         {
            this._content.stop();
         }
      }
   }
}
