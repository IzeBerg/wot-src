package net.wg.gui.components.assets
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.components.assets.interfaces.INewIndicator;
   
   public class NewIndicator extends MovieClip implements INewIndicator
   {
      
      private static const SHOW_LABEL:String = "show";
      
      private static const SHINE_LABEL:String = "shine";
      
      private static const PAUSE_LABEL:String = "pause";
      
      private static const HIDE_LABEL:String = "hide";
       
      
      public var newLabel:MovieClip = null;
      
      private var _hitMC:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function NewIndicator()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._hitMC = null;
         this.newLabel = null;
      }
      
      public function hide() : void
      {
         gotoAndStop(PAUSE_LABEL);
         this.newLabel.gotoAndPlay(HIDE_LABEL);
      }
      
      public function pause() : void
      {
         gotoAndStop(PAUSE_LABEL);
         this.newLabel.gotoAndStop(SHOW_LABEL);
      }
      
      public function shine() : void
      {
         this.newLabel.gotoAndStop(SHOW_LABEL);
         gotoAndPlay(SHINE_LABEL);
      }
      
      public function get hitMC() : Sprite
      {
         return this._hitMC;
      }
      
      public function set hitMC(param1:Sprite) : void
      {
         this._hitMC = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
