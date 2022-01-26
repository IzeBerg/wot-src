package net.wg.gui.lobby.sessionStats.components
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SessionStatsTankInfoBackground extends Sprite implements IDisposable
   {
      
      private static const FLAG_X:int = 0;
      
      private static const FLAG_Y:int = 0;
      
      private static const FLAG_DRAW_BOX_X:int = 0;
      
      private static const FLAG_DRAW_BOX_Y:int = 0;
      
      private static const FLAG_DRAW_BOX_HEIGHT:int = 362;
      
      private static const FLAG_ALPHA:Number = 0.6;
      
      private static const FLAG_NAME:String = "Flag background";
      
      private static const TANK_X:int = 90;
      
      private static const TANK_Y:int = -75;
      
      private static const TANK_DRAW_BOX_X:int = 90;
      
      private static const TANK_DRAW_BOX_Y:int = 0;
      
      private static const TANK_DRAW_BOX_WIDTH:int = 273;
      
      private static const TANK_DRAW_BOX_HEIGHT:int = 235;
      
      private static const TANK_NAME:String = "Tank background";
       
      
      private var _loaderTankImage:Loader = null;
      
      private var _loaderFlagImage:Loader = null;
      
      private var _tankBitmapData:BitmapData = null;
      
      private var _flagBitmapData:BitmapData = null;
      
      private var _tankBackground:Sprite = null;
      
      private var _flagBackground:Sprite = null;
      
      public function SessionStatsTankInfoBackground()
      {
         super();
         this._flagBackground = new Sprite();
         this._flagBackground.name = FLAG_NAME;
         this._flagBackground.alpha = FLAG_ALPHA;
         addChild(this._flagBackground);
         this._tankBackground = new Sprite();
         this._tankBackground.name = TANK_NAME;
         addChild(this._tankBackground);
         this._loaderFlagImage = new Loader();
         this._loaderTankImage = new Loader();
         this._loaderFlagImage.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFlagImageLoaderComplete);
         this._loaderTankImage.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onTankImageLoaderComplete);
      }
      
      private static function getDataByLoader(param1:Object) : BitmapData
      {
         return Bitmap(LoaderInfo(param1).content).bitmapData;
      }
      
      public function setSource(param1:String, param2:String) : void
      {
         this._loaderTankImage.unload();
         this._loaderFlagImage.unload();
         this._loaderTankImage.load(new URLRequest(param2));
         this._loaderFlagImage.load(new URLRequest(param1));
      }
      
      private function onTankImageLoaderComplete(param1:Event) : void
      {
         this._tankBitmapData = getDataByLoader(param1.target);
         this.drawBitmap();
      }
      
      private function onFlagImageLoaderComplete(param1:Event) : void
      {
         this._flagBitmapData = getDataByLoader(param1.target);
         this.drawBitmap();
      }
      
      private function drawBitmap() : void
      {
         var _loc1_:Matrix = null;
         var _loc2_:Matrix = null;
         if(this._flagBitmapData && this._tankBitmapData)
         {
            _loc1_ = new Matrix();
            _loc1_.tx = FLAG_X;
            _loc1_.ty = FLAG_Y;
            this._flagBackground.graphics.beginBitmapFill(this._flagBitmapData,_loc1_);
            this._flagBackground.graphics.drawRect(FLAG_DRAW_BOX_X,FLAG_DRAW_BOX_Y,width,FLAG_DRAW_BOX_HEIGHT);
            this._flagBackground.graphics.endFill();
            _loc2_ = new Matrix();
            _loc2_.tx = TANK_X;
            _loc2_.ty = TANK_Y;
            this._tankBackground.graphics.beginBitmapFill(this._tankBitmapData,_loc2_,false);
            this._tankBackground.graphics.drawRect(TANK_DRAW_BOX_X,TANK_DRAW_BOX_Y,TANK_DRAW_BOX_WIDTH,TANK_DRAW_BOX_HEIGHT);
            this._tankBackground.graphics.endFill();
         }
      }
      
      public function dispose() : void
      {
         this._loaderFlagImage.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onFlagImageLoaderComplete);
         this._loaderTankImage.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onTankImageLoaderComplete);
         this._loaderTankImage.unload();
         this._loaderTankImage = null;
         this._loaderFlagImage.unload();
         this._loaderFlagImage = null;
         if(this._tankBitmapData)
         {
            this._tankBitmapData.dispose();
            this._tankBitmapData = null;
         }
         if(this._flagBitmapData)
         {
            this._flagBitmapData.dispose();
            this._flagBitmapData = null;
         }
         this._flagBackground = null;
         this._tankBackground = null;
      }
   }
}
