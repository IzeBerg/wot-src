package net.wg.gui.lobby.hangar.ammunitionPanel
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   
   public class SlotAnimation extends SimpleLoader
   {
      
      public static const ANIMATION_COMPLETE:String = "animationComplete";
       
      
      private const ICON_NAME:String = "mcIcon";
      
      private var _mc:MovieClip;
      
      private var _slotBitmap:Bitmap;
      
      private var _loaded:Boolean;
      
      public function SlotAnimation()
      {
         super();
      }
      
      public function setData(param1:String, param2:BitmapData) : void
      {
         if(param2 != null)
         {
            this._slotBitmap = new Bitmap(param2,"auto",true);
         }
         setSource(param1);
      }
      
      override protected function onLoadingComplete() : void
      {
         if(this._mc != null)
         {
            this.disposeMovieClip();
         }
         this._mc = loader.content as MovieClip;
         this.drawIcon();
         if(this._mc != null)
         {
            this._mc.play();
         }
         this._loaded = true;
      }
      
      override public function clear() : void
      {
         super.clear();
         this.disposeMovieClip();
         this.disposeIcon();
         this._loaded = false;
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
         this.disposeMovieClip();
         this.disposeIcon();
         this._loaded = false;
      }
      
      private function disposeMovieClip() : void
      {
         if(this._mc != null)
         {
            this._mc.stop();
            this._mc = null;
         }
      }
      
      private function disposeIcon() : void
      {
         if(this._slotBitmap != null)
         {
            if(this._slotBitmap.parent != null)
            {
               this._slotBitmap.parent.removeChild(this._slotBitmap);
            }
            this._slotBitmap.bitmapData.dispose();
            this._slotBitmap = null;
         }
      }
      
      private function drawIcon() : void
      {
         if(this._slotBitmap == null)
         {
            return;
         }
         var _loc1_:DisplayObjectContainer = this._mc.getChildByName(this.ICON_NAME) as DisplayObjectContainer;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.addChild(this._slotBitmap);
      }
      
      public function get loaded() : Boolean
      {
         return this._loaded;
      }
   }
}
