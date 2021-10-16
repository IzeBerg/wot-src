package lesta.managers.windows
{
   import flash.display.BitmapData;
   
   public class BitmapManager
   {
      
      private static var bitmapsCache:Object = {};
       
      
      public function BitmapManager()
      {
         super();
      }
      
      public static function clean() : void
      {
         bitmapsCache = null;
      }
      
      public function fini() : void
      {
      }
      
      public function loadBitmap(param1:String, param2:Function, param3:Function = null) : void
      {
         if(!param1)
         {
            return;
         }
         if(!(param1 in bitmapsCache))
         {
            bitmapsCache[param1] = new BitmapWrapper(param1);
         }
         var _loc4_:BitmapWrapper = bitmapsCache[param1];
         if(_loc4_.failed)
         {
            if(param3 != null)
            {
               param3(param1);
            }
            return;
         }
         _loc4_.load(param2,param3);
      }
      
      public function unloadBitmap(param1:String, param2:Function) : void
      {
         var _loc3_:BitmapWrapper = null;
         if(!param1)
         {
            return;
         }
         if(param1 in bitmapsCache)
         {
            _loc3_ = bitmapsCache[param1];
            if(_loc3_.failed)
            {
               return;
            }
            _loc3_.unload(param2);
            if(_loc3_.isEmpty)
            {
               _loc3_.fini();
               delete bitmapsCache[param1];
            }
         }
      }
      
      public function loadConfig(param1:String, param2:Function) : void
      {
         var loadersCounter:int = 0;
         var imageId:String = null;
         var images:String = param1;
         var callback:Function = param2;
         var checkLoaded:Function = function():void
         {
            if(loadersCounter == 0)
            {
               callback();
            }
         };
         loadersCounter = 0;
         loadersCounter++;
         for each(imageId in images.split(","))
         {
            loadersCounter++;
            imageId = this.trim(imageId);
            this.loadBitmap(imageId,function(param1:String, param2:BitmapData):void
            {
               --loadersCounter;
               checkLoaded();
            });
         }
         loadersCounter--;
         checkLoaded();
      }
      
      public function unloadConfig(param1:String) : void
      {
         var _loc2_:String = null;
         for each(_loc2_ in param1.split(","))
         {
            _loc2_ = this.trim(_loc2_);
            this.unloadBitmap(_loc2_,null);
         }
      }
      
      private function trim(param1:String) : String
      {
         return param1.replace(/^\s+|\s+$/gs,"");
      }
   }
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

class BitmapWrapper
{
    
   
   public var failed:Boolean = false;
   
   private var bitmapData:BitmapData;
   
   private var loader:Loader;
   
   private var imageId:String;
   
   private var counter:int = 0;
   
   private var onLoadCallbackList:Array;
   
   private var onFailCallbackList:Array;
   
   function BitmapWrapper(param1:String)
   {
      this.onLoadCallbackList = [];
      this.onFailCallbackList = [];
      super();
      this.imageId = param1;
      this.loader = new Loader();
      this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoad);
      this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onFail);
      this.loader.load(new URLRequest(param1));
   }
   
   private function onLoad(param1:Event) : void
   {
      this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoad);
      this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onFail);
      this.bitmapData = Bitmap(this.loader.content).bitmapData;
      while(this.onLoadCallbackList.length)
      {
         this.onLoadCallbackList.pop()(this.imageId,this.bitmapData);
      }
      this.onLoadCallbackList = null;
   }
   
   private function onFail(param1:Event) : void
   {
      this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoad);
      this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onFail);
      while(this.onFailCallbackList.length)
      {
         this.onFailCallbackList.pop()(this.imageId,this.bitmapData);
      }
      this.onFailCallbackList = null;
      this.failed = true;
      this.counter -= this.onLoadCallbackList.length;
      this.onLoadCallbackList = null;
      this.loader.close();
      this.loader = null;
   }
   
   public function fini() : void
   {
      if(this.bitmapData)
      {
         this.bitmapData.dispose();
         this.bitmapData = null;
      }
      if(this.loader)
      {
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoad);
         this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onFail);
         this.loader.close();
         this.loader = null;
      }
      this.onLoadCallbackList = null;
      this.onFailCallbackList = null;
      this.imageId = "";
   }
   
   public function load(param1:Function, param2:Function) : void
   {
      if(this.failed)
      {
         return;
      }
      ++this.counter;
      if(this.bitmapData)
      {
         param1(this.imageId,this.bitmapData);
      }
      else
      {
         this.onLoadCallbackList.push(param1);
         if(param2 != null)
         {
            this.onFailCallbackList.push(param2);
         }
      }
   }
   
   public function unload(param1:Function) : void
   {
      var _loc2_:int = 0;
      --this.counter;
      if(this.onLoadCallbackList)
      {
         _loc2_ = this.onLoadCallbackList.indexOf(param1);
         if(_loc2_ > -1)
         {
            this.onLoadCallbackList.splice(_loc2_,1);
         }
      }
   }
   
   public function get isEmpty() : Boolean
   {
      return this.counter <= 0;
   }
   
   public function toString() : String
   {
      return "[BitmapWrapper" + " imageId:" + this.imageId + " bitmap:" + this.bitmapData + " counter:" + this.counter + " callbacks_len:" + (Boolean(this.onLoadCallbackList) ? this.onLoadCallbackList.length : "null") + " failed:" + this.failed + "]";
   }
}
