package net.wg.gui.lobby.header.rankedBattles
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.common.ContentLoader;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SparkAnimLoader extends Sprite implements IDisposable
   {
      
      private static const SPARKS_ANIM_URL:String = "sparksAnim.swf";
       
      
      private var _loader:ContentLoader;
      
      private var _isDisposed:Boolean = false;
      
      private var _contentMain:MovieClip = null;
      
      public function SparkAnimLoader()
      {
         super();
         name = SPARKS_ANIM_URL;
         mouseChildren = mouseEnabled = false;
      }
      
      public function dispose() : void
      {
         this._contentMain = null;
         if(this._loader)
         {
            this._loader.removeEventListener(Event.COMPLETE,this.onComplete);
            this._loader.dispose();
         }
         this._isDisposed = true;
         this._loader = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      private function start() : void
      {
         if(this._isDisposed)
         {
            return;
         }
         if(!this._loader || !this._loader.isLoaded && !this._loader.isInProgress)
         {
            this._loader = new ContentLoader();
            this._loader.addEventListener(Event.COMPLETE,this.onComplete);
            this._loader.loadURL(SPARKS_ANIM_URL);
            addChild(this._loader);
         }
         if(this._contentMain)
         {
            MovieClip(this._loader.content).gotoAndPlay(1);
            this._contentMain.play();
         }
      }
      
      private function stop() : void
      {
         if(this._contentMain)
         {
            this._contentMain.stop();
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1)
         {
            this.start();
         }
         else
         {
            this.stop();
         }
         super.visible = param1;
      }
      
      private function onComplete(param1:Event) : void
      {
         this._loader.removeEventListener(Event.COMPLETE,this.onComplete);
         this._contentMain = MovieClip(this._loader.content).main;
         if(visible)
         {
            this._contentMain.play();
         }
         else
         {
            this._contentMain.stop();
         }
      }
   }
}
