package scaleform.clik.controls
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   [InspectableList("enableInitCallback")]
   public class UILoader extends UIComponent
   {
       
      
      public var bytesLoaded:int = 0;
      
      public var bytesTotal:int = 0;
      
      protected var _source:String;
      
      protected var _autoSize:Boolean = true;
      
      protected var _maintainAspectRatio:Boolean = true;
      
      protected var _loadOK:Boolean = false;
      
      protected var _sizeRetries:Number = 0;
      
      protected var _visiblilityBeforeLoad:Boolean = true;
      
      protected var _isLoading:Boolean = false;
      
      public var bg:Sprite;
      
      public var loader:Loader;
      
      public function UILoader()
      {
         super();
      }
      
      [Inspectable(defaultValue="true")]
      public function get autoSize() : Boolean
      {
         return this._autoSize;
      }
      
      public function set autoSize(param1:Boolean) : void
      {
         this._autoSize = param1;
         invalidateSize();
      }
      
      [Inspectable(defaultValue="")]
      public function get source() : String
      {
         return this._source;
      }
      
      public function set source(param1:String) : void
      {
         if(this._source == param1)
         {
            return;
         }
         if((param1 == "" || param1 == null) && (this.loader != null && this.loader.content == null))
         {
            this.unload();
         }
         else
         {
            this.load(param1);
         }
      }
      
      [Inspectable(defaultValue="true")]
      public function get maintainAspectRatio() : Boolean
      {
         return this._maintainAspectRatio;
      }
      
      public function set maintainAspectRatio(param1:Boolean) : void
      {
         this._maintainAspectRatio = param1;
         invalidateSize();
      }
      
      public function get content() : DisplayObject
      {
         return this.loader.content;
      }
      
      public function get percentLoaded() : Number
      {
         if(this.bytesTotal == 0 || this._source == null)
         {
            return 0;
         }
         return this.bytesLoaded / this.bytesTotal * 100;
      }
      
      [Inspectable(defaultValue="true")]
      override public function get visible() : Boolean
      {
         return super.visible;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(this._isLoading)
         {
            this._visiblilityBeforeLoad = param1;
         }
         else
         {
            super.visible = param1;
         }
      }
      
      public function unload() : void
      {
         if(this.loader != null)
         {
            this.visible = this._visiblilityBeforeLoad;
            this.loader.unloadAndStop(true);
         }
         this._source = null;
         this._loadOK = false;
         this._sizeRetries = 0;
      }
      
      override public function toString() : String
      {
         return "[CLIK UILoader " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         initSize();
         if(this.bg != null)
         {
            removeChild(this.bg);
            this.bg = null;
         }
         if(this.loader == null && this._source)
         {
            this.load(this._source);
         }
      }
      
      protected function load(param1:String) : void
      {
         if(param1 == "")
         {
            return;
         }
         this.unload();
         this._source = param1;
         this._visiblilityBeforeLoad = this.visible;
         this.visible = false;
         if(this.loader == null)
         {
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.OPEN,this.handleLoadOpen,false,0,true);
            this.loader.contentLoaderInfo.addEventListener(Event.INIT,this.handleLoadInit,false,0,true);
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.handleLoadComplete,false,0,true);
            this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.handleLoadProgress,false,0,true);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleLoadIOError,false,0,true);
         }
         addChild(this.loader);
         this._isLoading = true;
         this.loader.load(new URLRequest(this._source));
      }
      
      override protected function draw() : void
      {
         if(!this._loadOK)
         {
            return;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.loader.scaleX = this.loader.scaleY = 1;
            if(!this._autoSize)
            {
               this.visible = this._visiblilityBeforeLoad;
            }
            else
            {
               if(this.loader.width <= 0)
               {
                  if(this._sizeRetries < 10)
                  {
                     ++this._sizeRetries;
                     invalidateData();
                  }
                  return;
               }
               if(this._maintainAspectRatio)
               {
                  this.loader.scaleX = this.loader.scaleY = Math.min(height / this.loader.height,width / this.loader.width);
                  this.loader.x = _width - this.loader.width >> 1;
                  this.loader.y = _height - this.loader.height >> 1;
               }
               else
               {
                  this.loader.width = _width;
                  this.loader.height = _height;
               }
               this.visible = this._visiblilityBeforeLoad;
            }
         }
      }
      
      protected function handleLoadIOError(param1:Event) : void
      {
         this.visible = this._visiblilityBeforeLoad;
         dispatchEventAndSound(param1);
      }
      
      protected function handleLoadOpen(param1:Event) : void
      {
         dispatchEventAndSound(param1);
      }
      
      protected function handleLoadInit(param1:Event) : void
      {
         dispatchEventAndSound(param1);
      }
      
      protected function handleLoadProgress(param1:ProgressEvent) : void
      {
         this.bytesLoaded = param1.bytesLoaded;
         this.bytesTotal = param1.bytesTotal;
         dispatchEventAndSound(param1);
      }
      
      protected function handleLoadComplete(param1:Event) : void
      {
         this._loadOK = true;
         this._isLoading = false;
         invalidateSize();
         validateNow();
         dispatchEventAndSound(param1);
      }
   }
}
