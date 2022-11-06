package net.wg.gui.components.common.waiting
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.interfaces.ISparksManager;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   
   public class WaitingComponent extends UIComponentEx
   {
      
      private static const TEXT_INVALID:String = "textInv";
      
      private static const ANIMATION_STATUS_INVALID:String = "animStatusInv";
      
      private static const INV_BACKGROUND_VISIBILITY:String = "InvBackgroundVisibility";
      
      private static const SPARK_ZONE:Rectangle = new Rectangle(100,0,-200,-100);
      
      private static const SPARK_QUANTITY:uint = 150;
       
      
      public var waitingMc:WaitingMc = null;
      
      public var backgroundMc:Sprite = null;
      
      public var backgroundImg:Image = null;
      
      private var _sparksMc:Sprite = null;
      
      private var _waitingOffset:Point = null;
      
      private var _text:String = "";
      
      private var _isStopped:Boolean = false;
      
      private var _backgroundVisibility:Boolean = true;
      
      private var _sparksManager:ISparksManager = null;
      
      public function WaitingComponent()
      {
         super();
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
         this._waitingOffset = new Point(0,0);
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints.addElement(this.waitingMc.name,this.waitingMc,Constraints.CENTER_H | Constraints.CENTER_V);
         constraints.addElement(this.backgroundMc.name,this.backgroundMc,Constraints.ALL);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
            this.backgroundMc.x ^= 0;
            this.backgroundMc.y ^= 0;
            this.waitingMc.x += this._waitingOffset.x ^ 0;
            this.waitingMc.y += this._waitingOffset.y ^ 0;
            this.waitingMc.x ^= 0;
            this.waitingMc.y ^= 0;
            if(this.backgroundImg != null && this.backgroundImg.source != Values.EMPTY_STR)
            {
               this.resizeBGImg();
            }
            if(this._sparksManager != null)
            {
               this._sparksManager.resetZone(this.getSparkZone());
            }
         }
         if(isInvalid(TEXT_INVALID))
         {
            this.waitingMc.setMessage(this._text);
         }
         if(isInvalid(ANIMATION_STATUS_INVALID))
         {
            if(this._isStopped)
            {
               this.waitingMc.stop();
            }
            else
            {
               this.waitingMc.play();
            }
         }
         if(isInvalid(INV_BACKGROUND_VISIBILITY))
         {
            this.backgroundMc.alpha = !!this._backgroundVisibility ? Number(1) : Number(0);
         }
      }
      
      override protected function onDispose() : void
      {
         this.waitingMc.dispose();
         this.waitingMc = null;
         this.backgroundMc = null;
         this._waitingOffset = null;
         if(this.backgroundImg != null)
         {
            this.backgroundImg.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.backgroundImg.dispose();
            this.backgroundImg = null;
         }
         this.destroySparks();
         super.onDispose();
      }
      
      public function setAnimationStatus(param1:Boolean) : void
      {
         if(this._isStopped != param1)
         {
            this._isStopped = param1;
            invalidate(ANIMATION_STATUS_INVALID);
         }
      }
      
      public function setBackgroundImg(param1:String) : void
      {
         if(this.backgroundImg == null && param1 == Values.EMPTY_STR)
         {
            return;
         }
         if(this.backgroundImg == null)
         {
            this.backgroundImg = new Image();
            addChildAt(this.backgroundImg,getChildIndex(this.backgroundMc) + 1);
            this.backgroundImg.addEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.backgroundImg.cacheType = ImageCacheTypes.NOT_USE_CACHE;
         }
         this.backgroundImg.source = param1;
         if(this._sparksMc == null)
         {
            this._sparksMc = new Sprite();
            addChildAt(this._sparksMc,getChildIndex(this.backgroundImg) + 1);
            this.createSparks();
         }
         this._sparksMc.visible = this.backgroundImg.visible = param1 != Values.EMPTY_STR;
      }
      
      public function setMessage(param1:String) : void
      {
         this._text = param1;
         invalidate(TEXT_INVALID);
      }
      
      public function setWaitingOffset(param1:Point) : void
      {
         this._waitingOffset = param1;
      }
      
      private function destroySparks() : void
      {
         if(this._sparksManager != null)
         {
            this._sparksManager.dispose();
            this._sparksManager = null;
         }
         if(this._sparksMc != null)
         {
            removeChild(this._sparksMc);
            this._sparksMc = null;
         }
      }
      
      private function createSparks() : void
      {
         if(this._sparksManager == null)
         {
            this._sparksManager = ISparksManager(App.utils.classFactory.getObject(Linkages.SPARKS_MGR));
            this._sparksManager.zone = this.getSparkZone();
            this._sparksManager.scope = this._sparksMc;
            this._sparksManager.sparkQuantity = SPARK_QUANTITY;
            this._sparksManager.createSparks();
         }
      }
      
      private function getSparkZone() : Rectangle
      {
         return new Rectangle(SPARK_ZONE.x,SPARK_ZONE.y,_width + SPARK_ZONE.right,_height + SPARK_ZONE.bottom);
      }
      
      private function resizeBGImg() : void
      {
         this.backgroundImg.scaleX = this.backgroundImg.scaleY = Math.max(_width / this.backgroundImg.bitmapWidth,_height / this.backgroundImg.bitmapHeight);
         this.backgroundImg.x = _width - this.backgroundImg.width >> 1;
         this.backgroundImg.y = _height - this.backgroundImg.height >> 1;
      }
      
      public function get backgroundVisibility() : Boolean
      {
         return this._backgroundVisibility;
      }
      
      public function set backgroundVisibility(param1:Boolean) : void
      {
         this._backgroundVisibility = param1;
         invalidate(INV_BACKGROUND_VISIBILITY);
      }
      
      public function get movieVisible() : Boolean
      {
         return this.waitingMc.visible;
      }
      
      public function set movieVisible(param1:Boolean) : void
      {
         this.waitingMc.visible = param1;
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         if(this.backgroundImg.source != Values.EMPTY_STR)
         {
            this.resizeBGImg();
         }
      }
   }
}
