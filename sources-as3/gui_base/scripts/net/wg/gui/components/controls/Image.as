package net.wg.gui.components.controls
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.IImageData;
   import net.wg.infrastructure.managers.IImageManager;
   import org.idmedia.as3commons.util.StringUtils;
   
   [Event(name="change",type="flash.events.Event")]
   public class Image extends Sprite implements IImage
   {
       
      
      private var _bitmap:Bitmap = null;
      
      private var _imgData:IImageData = null;
      
      private var _source:String = "";
      
      private var _sourceAlt:String = "";
      
      private var _loadFailed:Boolean = false;
      
      private var _mgr:IImageManager = null;
      
      private var _cacheType:int = 2;
      
      private var _disposed:Boolean = false;
      
      public function Image()
      {
         super();
         this._mgr = App.imageMgr;
         this._bitmap = new Bitmap();
         addChild(this._bitmap);
      }
      
      public function clearImage() : void
      {
         this.removeImgData();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function readjustSize() : void
      {
         scaleX = scaleY = this._bitmap.scaleX = this._bitmap.scaleY = 1;
      }
      
      protected function onDispose() : void
      {
         this.removeImgData();
         removeChild(this._bitmap);
         this._bitmap = null;
         this._mgr = null;
      }
      
      private function removeImgData() : void
      {
         if(this._imgData != null)
         {
            if(!this._imgData.ready)
            {
               this.removeImgDataListeners();
            }
            this._imgData.removeFrom(this);
            this._imgData = null;
         }
      }
      
      private function setImgData(param1:IImageData) : void
      {
         this._imgData = param1;
         if(this._imgData.ready)
         {
            this._imgData.showTo(this);
         }
         else
         {
            this.addImgDataListeners();
         }
      }
      
      private function addImgDataListeners() : void
      {
         this._imgData.addEventListener(Event.COMPLETE,this.onImgDataCompleteHandler);
         this._imgData.addEventListener(IOErrorEvent.IO_ERROR,this.onImgDataIoErrorHandler);
      }
      
      private function removeImgDataListeners() : void
      {
         this._imgData.removeEventListener(Event.COMPLETE,this.onImgDataCompleteHandler);
         this._imgData.removeEventListener(IOErrorEvent.IO_ERROR,this.onImgDataIoErrorHandler);
      }
      
      public function get source() : String
      {
         return this._source;
      }
      
      public function set source(param1:String) : void
      {
         if(this._source != param1)
         {
            this._source = param1;
            this._loadFailed = false;
            this.removeImgData();
            if(this._source)
            {
               this.setImgData(this._mgr.getImageData(this._source,this._cacheType));
            }
         }
      }
      
      public function get sourceAlt() : String
      {
         return this._sourceAlt;
      }
      
      public function set sourceAlt(param1:String) : void
      {
         if(this._sourceAlt != param1)
         {
            this._sourceAlt = param1;
            if(this._loadFailed)
            {
               this.removeImgData();
               if(this._sourceAlt)
               {
                  this.setImgData(this._mgr.getImageData(this._sourceAlt,this._cacheType));
               }
            }
         }
      }
      
      public function get bitmapData() : BitmapData
      {
         if(this._bitmap)
         {
            return this._bitmap.bitmapData;
         }
         return null;
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
         this._bitmap.bitmapData = param1;
         this._bitmap.visible = param1 != null;
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get ready() : Boolean
      {
         return this._bitmap.bitmapData != null;
      }
      
      public function get cacheType() : int
      {
         return this._cacheType;
      }
      
      public function set cacheType(param1:int) : void
      {
         this._cacheType = param1;
      }
      
      public function get bitmapWidth() : int
      {
         return !!this.ready ? int(this._bitmap.bitmapData.width) : int(0);
      }
      
      public function get bitmapHeight() : int
      {
         return !!this.ready ? int(this._bitmap.bitmapData.height) : int(0);
      }
      
      public function get smoothing() : Boolean
      {
         return this._bitmap.smoothing;
      }
      
      public function set smoothing(param1:Boolean) : void
      {
         this._bitmap.smoothing = param1;
      }
      
      private function onImgDataCompleteHandler(param1:Event) : void
      {
         this._loadFailed = false;
         this.removeImgDataListeners();
         this._imgData.showTo(this);
      }
      
      private function onImgDataIoErrorHandler(param1:IOErrorEvent) : void
      {
         this.removeImgDataListeners();
         if(!this._loadFailed && StringUtils.isNotEmpty(this._sourceAlt))
         {
            this._loadFailed = true;
            dispatchEvent(param1);
            this.setImgData(this._mgr.getImageData(this._sourceAlt,this._cacheType));
         }
         else
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
   }
}
