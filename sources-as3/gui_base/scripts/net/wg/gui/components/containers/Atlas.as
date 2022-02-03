package net.wg.gui.components.containers
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import net.wg.data.VO.AtlasItemVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.infrastructure.events.AtlasEvent;
   import net.wg.infrastructure.interfaces.IAtlas;
   import net.wg.infrastructure.interfaces.IAtlasItemVO;
   
   [Event(name="ioError",type="flash.events.IOErrorEvent")]
   [Event(name="atlasInitializedEvent",type="net.wg.infrastructure.events.AtlasEvent")]
   public class Atlas extends EventDispatcher implements IAtlas
   {
      
      private static const BITMAP_LOADED_MASK:uint = 1;
      
      private static const XML_LOADED_MASK:uint = 2;
      
      private static const INITIALIZED_MASK:uint = 3;
       
      
      private var _atlasName:String = "";
      
      private var _atlasBitmapLoader:Loader = null;
      
      private var _atlasBitmapData:BitmapData = null;
      
      private var _atlasXMLURLLoader:URLLoader = null;
      
      private var _atlasItemsDictionary:Dictionary = null;
      
      private var _isInitialized:Boolean = false;
      
      private var _isDisposed:Boolean = false;
      
      private var _initializationMask:uint = 0;
      
      private var _disposed:Boolean = false;
      
      public function Atlas()
      {
         super();
         this._atlasItemsDictionary = new Dictionary(true);
      }
      
      public function get atlasName() : String
      {
         return this._atlasName;
      }
      
      public function initResources(param1:String) : void
      {
         this.assert(!this._isDisposed,"Atlas manager" + Errors.ALREADY_DISPOSED);
         this.assert(!this._atlasName,"Atlas manager already initialized!");
         this.assert(Boolean(param1),"value is null or empty");
         this._atlasName = param1;
         this.initializeAtlasBitmapLoading();
         this.initializeAtlasXMLLoading();
      }
      
      private function initializeAtlasBitmapLoading() : void
      {
         this._atlasBitmapLoader = new Loader();
         this._atlasBitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onAtlasBitmapLoadingCompleteHandler);
         this._atlasBitmapLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onAtlasBitmapIOErrorHandler);
         var _loc1_:String = ATLAS_CONSTANTS.ATLAS_RESOURCES_PATH + this.atlasName + ".dds";
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this._atlasBitmapLoader.load(_loc2_,_loc3_);
      }
      
      private function onAtlasBitmapIOErrorHandler(param1:IOErrorEvent) : void
      {
         this.cleanAtlasBitmapLoader();
         DebugUtils.LOG_ERROR(param1.toString());
         dispatchEvent(param1);
      }
      
      private function onAtlasBitmapLoadingCompleteHandler(param1:Event) : void
      {
         this._atlasBitmapData = Bitmap(this._atlasBitmapLoader.content).bitmapData;
         this._initializationMask |= BITMAP_LOADED_MASK;
         this.cleanAtlasBitmapLoader();
         this.verifyIsAtlasInitialized();
      }
      
      private function initializeAtlasXMLLoading() : void
      {
         var _loc1_:String = ATLAS_CONSTANTS.ATLAS_RESOURCES_PATH + this.atlasName + ".xml";
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         this._atlasXMLURLLoader = new URLLoader();
         this._atlasXMLURLLoader.addEventListener(Event.COMPLETE,this.onAtlasXMLLoadingCompleteHandler);
         this._atlasXMLURLLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onAtlasXMLIOErrorHandler);
         this._atlasXMLURLLoader.load(_loc2_);
      }
      
      private function onAtlasXMLLoadingCompleteHandler(param1:Event) : void
      {
         var _loc3_:AtlasItemVO = null;
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc2_:XML = new XML(this._atlasXMLURLLoader.data);
         this._atlasItemsDictionary = new Dictionary(true);
         for each(_loc5_ in _loc2_.SubTexture)
         {
            _loc3_ = new AtlasItemVO();
            _loc4_ = _loc5_.child("name");
            _loc3_.name = _loc4_;
            _loc3_.x = parseInt(_loc5_.x);
            _loc3_.y = parseInt(_loc5_.y);
            _loc3_.width = parseInt(_loc5_.width);
            _loc3_.height = parseInt(_loc5_.height);
            this._atlasItemsDictionary[_loc4_] = _loc3_;
         }
         this._initializationMask |= XML_LOADED_MASK;
         this.cleanAtlasXMLLoader();
         this.verifyIsAtlasInitialized();
      }
      
      private function onAtlasXMLIOErrorHandler(param1:IOErrorEvent) : void
      {
         this.cleanAtlasXMLLoader();
         DebugUtils.LOG_ERROR(param1.toString());
         dispatchEvent(param1);
      }
      
      public function get atlasBitmapData() : BitmapData
      {
         return this._atlasBitmapData;
      }
      
      public function get isAtlasInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      private function verifyIsAtlasInitialized() : void
      {
         if(this._initializationMask == INITIALIZED_MASK)
         {
            this._isInitialized = true;
            dispatchEvent(new AtlasEvent(AtlasEvent.ATLAS_INITIALIZED));
         }
      }
      
      public function getAtlasItemVOByName(param1:String) : IAtlasItemVO
      {
         this.assert(!this._isDisposed,"Atlas manager" + Errors.ALREADY_DISPOSED);
         return this._atlasItemsDictionary[param1];
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         this._disposed = true;
         this.assert(!this._isDisposed,"Atlas manager" + Errors.ALREADY_DISPOSED);
         this._isDisposed = true;
         if(this._atlasBitmapLoader && !(this._initializationMask & BITMAP_LOADED_MASK))
         {
            this._atlasBitmapLoader.close();
         }
         if(this._atlasXMLURLLoader && !(this._initializationMask & XML_LOADED_MASK))
         {
            this._atlasXMLURLLoader.close();
         }
         this.cleanAtlasBitmapLoader();
         this.cleanAtlasXMLLoader();
         if(this._atlasBitmapData)
         {
            this._atlasBitmapData.dispose();
            this._atlasBitmapData = null;
         }
         for(_loc1_ in this._atlasItemsDictionary)
         {
            delete this._atlasItemsDictionary[_loc1_];
         }
         this._atlasItemsDictionary = null;
      }
      
      private function assert(param1:Boolean, param2:String) : void
      {
         if(App.instance)
         {
            App.utils.asserter.assert(param1,param2);
         }
      }
      
      private function cleanAtlasBitmapLoader() : void
      {
         if(!this._atlasBitmapLoader)
         {
            return;
         }
         this._atlasBitmapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onAtlasBitmapLoadingCompleteHandler);
         this._atlasBitmapLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onAtlasBitmapIOErrorHandler);
         this._atlasBitmapLoader.unload();
         this._atlasBitmapLoader = null;
      }
      
      private function cleanAtlasXMLLoader() : void
      {
         if(!this._atlasBitmapLoader)
         {
            return;
         }
         this._atlasXMLURLLoader.removeEventListener(Event.COMPLETE,this.onAtlasXMLLoadingCompleteHandler);
         this._atlasXMLURLLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onAtlasXMLIOErrorHandler);
         this._atlasXMLURLLoader = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
