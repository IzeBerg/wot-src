package net.wg.gui.components.controls
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.getQualifiedClassName;
   import net.wg.data.constants.SoundTypes;
   import net.wg.infrastructure.events.IconLoaderEvent;
   import scaleform.clik.constants.InvalidationType;
   
   [Event(name="iconLoadingFailed",type="net.wg.infrastructure.events.IconLoaderEvent")]
   [Event(name="iconLoaded",type="net.wg.infrastructure.events.IconLoaderEvent")]
   public class IconButton extends SoundButtonEx
   {
       
      
      protected var _iconOffsetTop:Number = 0;
      
      protected var _iconOffsetLeft:Number = 0;
      
      protected var loader:Loader;
      
      protected var _iconSource:String;
      
      private var isIconSourceChanged:Boolean;
      
      private var arrangeLayout:Boolean;
      
      private var updateNestedChild:Boolean = false;
      
      public function IconButton()
      {
         super();
         soundType = SoundTypes.ICON_BTN;
      }
      
      override protected function onDispose() : void
      {
         if(this.loader)
         {
            this.removeIconListeners(this.loader.contentLoaderInfo);
            this.loader.unloadAndStop();
            this.loader.unload();
            removeChild(this.loader);
            this.loader = null;
         }
         super.onDispose();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.updateNestedChild = true;
      }
      
      [Inspectable(name="iconSource",type="String")]
      public function get iconSource() : String
      {
         return this._iconSource;
      }
      
      public function set iconSource(param1:String) : void
      {
         if(this._iconSource != param1)
         {
            this._iconSource = param1;
            this.isIconSourceChanged = true;
            invalidate();
         }
      }
      
      [Inspectable(defaultValue="0",name="iconOffsetTop",type="Number")]
      public function get iconOffsetTop() : Number
      {
         return this._iconOffsetTop;
      }
      
      public function set iconOffsetTop(param1:Number) : void
      {
         this._iconOffsetTop = param1;
         this.arrangeLayout = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="0",name="iconOffsetLeft",type="Number")]
      public function get iconOffsetLeft() : Number
      {
         return this._iconOffsetLeft;
      }
      
      public function set iconOffsetLeft(param1:Number) : void
      {
         this._iconOffsetLeft = param1;
         this.arrangeLayout = true;
         invalidate();
      }
      
      override protected function draw() : void
      {
         var _loc1_:URLRequest = null;
         super.draw();
         if(this.isIconSourceChanged)
         {
            this.isIconSourceChanged = false;
            if(this.loader)
            {
               this.loader.unload();
               this.removeIconListeners(this.loader.contentLoaderInfo);
               removeChild(this.loader);
               this.loader = null;
            }
            if(this._iconSource != null && this._iconSource != "")
            {
               _loc1_ = new URLRequest(this._iconSource);
               this.loader = new Loader();
               this.addIconListeners(this.loader.contentLoaderInfo);
               this.loader.load(_loc1_);
               this.loader.visible = false;
               addChild(this.loader);
            }
         }
         if(this.loader && this.contains(this.loader) && this.updateNestedChild)
         {
            this.setChildIndex(this.loader,this.numChildren - 1);
            this.updateNestedChild = false;
         }
         if(_baseDisposed)
         {
            return;
         }
         if(this.arrangeLayout)
         {
            this.arrangeLayout = false;
            this.configIcon();
         }
         else if(isInvalid(InvalidationType.SIZE))
         {
            this.configIcon();
         }
      }
      
      protected function addIconListeners(param1:LoaderInfo) : void
      {
         param1.addEventListener(Event.COMPLETE,this.iconLoadingCompleteHandler);
         param1.addEventListener(IOErrorEvent.IO_ERROR,this.iconLoadingIOErrorHandler);
      }
      
      protected function configIcon() : void
      {
         if(this.loader)
         {
            this.loader.x = this._iconOffsetLeft * (1 / this.scaleX);
            this.loader.y = this._iconOffsetTop * (1 / this.scaleY);
            this.loader.tabEnabled = this.loader.mouseEnabled = false;
            this.loader.visible = true;
            this.loader.scaleX = 1 / this.scaleX;
            this.loader.scaleY = 1 / this.scaleY;
         }
      }
      
      private function removeIconListeners(param1:LoaderInfo) : void
      {
         param1.removeEventListener(Event.COMPLETE,this.iconLoadingCompleteHandler);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.iconLoadingIOErrorHandler);
      }
      
      [Event(name="iconLoadingFailed",type="net.wg.infrastructure.events.IconLoaderEvent")]
      protected function iconLoadingIOErrorHandler(param1:IOErrorEvent) : void
      {
         DebugUtils.LOG_WARNING("Flash :: Icon Loading IO Error!",getQualifiedClassName(this),param1.toString());
         dispatchEvent(this.getNewLoadingEvent(IconLoaderEvent.ICON_LOADING_FAILED,loaderInfo.loader,loaderInfo.url));
         this.removeIconListeners(LoaderInfo(param1.target));
      }
      
      [Event(name="iconLoaded",type="net.wg.infrastructure.events.IconLoaderEvent")]
      protected function iconLoadingCompleteHandler(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.target);
         this.removeIconListeners(_loc2_);
         dispatchEvent(this.getNewLoadingEvent(IconLoaderEvent.ICON_LOADED,_loc2_.loader,_loc2_.url));
         this.arrangeLayout = true;
         invalidate();
         if(this is IconTextButton)
         {
            App.utils.asserter.assert(this.loader.x + this.loader.width <= this.scale9Grid.left,"Icon cut because scale9Grid.left position less than icon position. In: " + this + ". Cut off by " + (this.loader.x + this.loader.width - this.scale9Grid.left) + " pixels. " + " Name: " + this.name + " Parent: " + parent);
         }
      }
      
      private function getNewLoadingEvent(param1:String, param2:Loader, param3:String) : IconLoaderEvent
      {
         return new IconLoaderEvent(param1,param2,param3,false,true);
      }
   }
}
