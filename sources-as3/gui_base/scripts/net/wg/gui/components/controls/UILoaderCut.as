package net.wg.gui.components.controls
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class UILoaderCut extends Sprite implements IDisposable
   {
      
      private static const ERROR_URL:String = "../maps/icons/vehicle/noImage.png";
       
      
      public var background:MovieClip;
      
      private var _loader:Loader;
      
      private var _context:LoaderContext;
      
      private var _source:String = "";
      
      private var _cutRect:Rectangle;
      
      private var _disposed:Boolean = false;
      
      public function UILoaderCut()
      {
         super();
         scaleX = scaleY = 1;
         this.background.visible = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this._loader)
         {
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderIOErrorHandler);
            this._loader.unloadAndStop(true);
            this._loader.close();
            this._loader = null;
            this._context = null;
         }
         this._source = null;
         this._cutRect = null;
         this.background = null;
      }
      
      [Inspectable(defaultValue="x:0,y:0,width:100,height:100",name="cutRect")]
      public function get cutRect() : Object
      {
         return this._cutRect;
      }
      
      public function set cutRect(param1:Object) : void
      {
         this._cutRect = new Rectangle(param1.x,param1.y,param1.width,param1.height);
      }
      
      [Inspectable(defaultValue="")]
      public function get source() : String
      {
         return this._source;
      }
      
      public function set source(param1:String) : void
      {
         if(param1 == null || param1 == Values.EMPTY_STR || param1 == this._source)
         {
            return;
         }
         this._source = param1;
         if(this._loader == null)
         {
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoaderIOErrorHandler);
            this._context = new LoaderContext(false,ApplicationDomain.currentDomain);
         }
         else
         {
            this._loader.unloadAndStop(true);
         }
         this._loader.load(new URLRequest(param1),this._context);
      }
      
      private function onLoaderCompleteHandler(param1:Event) : void
      {
         graphics.clear();
         var _loc2_:Matrix = new Matrix(1,0,0,1,-this._cutRect.x,-this._cutRect.y);
         graphics.beginBitmapFill(Bitmap(this._loader.content).bitmapData,_loc2_,false);
         graphics.moveTo(0,0);
         graphics.lineTo(this._cutRect.width,0);
         graphics.lineTo(this._cutRect.width,this._cutRect.height);
         graphics.lineTo(0,this._cutRect.height);
         graphics.lineTo(0,0);
         graphics.endFill();
      }
      
      private function onLoaderIOErrorHandler(param1:IOErrorEvent) : void
      {
         this._loader.unloadAndStop(true);
         this.source = ERROR_URL;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
