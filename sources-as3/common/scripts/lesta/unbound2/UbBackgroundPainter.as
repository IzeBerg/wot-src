package lesta.unbound2
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.system.ApplicationDomain;
   import flash.utils.getDefinitionByName;
   import lesta.managers.windows.BitmapManager;
   
   public class UbBackgroundPainter
   {
      
      public static const BACKGROUND_SIZE_COVER:int = 0;
      
      public static const BACKGROUND_SIZE_CROP:int = 1;
      
      public static const BACKGROUND_SIZE_FILL:int = 2;
      
      public static const BACKGROUND_SIZE_REPEAT:int = 3;
      
      public static const BACKGROUND_SIZE_AUTO:int = 4;
      
      public static const BACKGROUND_SIZE_INVALID:int = 5;
      
      public static const IMAGE_SOURCE_URL:int = 0;
      
      public static const IMAGE_SOURCE_BITMAP:int = 1;
      
      public static const IMAGE_SOURCE_SYMBOL:int = 2;
      
      public static const IMAGE_SOURCE_INVALID:int = 3;
       
      
      private var m_bitmapManager:BitmapManager;
      
      private var m_element:Sprite;
      
      private var m_canvas:Graphics;
      
      private var m_onPainImageCallback:Function = null;
      
      private var m_matrix:Matrix;
      
      private var m_prevBitmapName:String = "";
      
      private var m_sprite:DisplayObject = null;
      
      private var m_prevSpriteName:String = null;
      
      private var m_solidColorIsSet:Boolean = false;
      
      private var m_solidColor:uint = 0;
      
      private var m_solidColorAlpha:Number = 1.0;
      
      private var m_image:String = null;
      
      private var m_imageSource:int = 3;
      
      private var m_backgroundSize:int = 5;
      
      private var m_width:Number = 0;
      
      private var m_height:Number = 0;
      
      public function UbBackgroundPainter(param1:Sprite)
      {
         this.m_matrix = new Matrix();
         super();
         this.m_element = param1;
         this.m_canvas = param1.graphics;
      }
      
      public function destructorCalledByUnbound() : void
      {
         if(this.m_bitmapManager != null)
         {
            this.m_bitmapManager.unloadBitmap(this.m_prevBitmapName,this.onLoader);
            this.m_bitmapManager.fini();
            this.m_bitmapManager = null;
            this.m_prevBitmapName = null;
         }
         this.clearSprite();
         this.m_canvas.clear();
         this.m_canvas = null;
         this.m_element = null;
         this.m_onPainImageCallback = null;
         this.m_matrix = null;
      }
      
      public function get bitmapManager() : BitmapManager
      {
         if(!this.m_bitmapManager)
         {
            this.m_bitmapManager = new BitmapManager();
         }
         return this.m_bitmapManager;
      }
      
      public function setSolidColor(param1:uint, param2:Number) : void
      {
         this.m_solidColor = param1;
         this.m_solidColorAlpha = param2;
         this.m_solidColorIsSet = true;
      }
      
      public function setImage(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         this.m_image = null;
         this.m_imageSource = IMAGE_SOURCE_INVALID;
         if(param1 == "null")
         {
            this.clearSprite();
         }
         else
         {
            _loc2_ = param1.split(":");
            if(_loc2_.length != 2)
            {
               throw new Error("[UbBackgroundPainter] Invalid background image format (expected source:name): " + param1);
            }
            _loc3_ = _loc2_[0];
            if(_loc3_ == "url")
            {
               this.m_imageSource = IMAGE_SOURCE_URL;
               this.m_image = _loc2_[1];
            }
            else if(_loc3_ == "bitmap")
            {
               this.m_imageSource = IMAGE_SOURCE_BITMAP;
               this.m_image = _loc2_[1];
            }
            else if(_loc3_ == "symbol")
            {
               this.m_imageSource = IMAGE_SOURCE_SYMBOL;
               this.m_image = _loc2_[1];
            }
            else
            {
               if(_loc3_ != "img")
               {
                  throw new Error("[UbBackgroundPainter] Invalid source identifier (expected url|bitmap|symbol|img): " + param1);
               }
               this.m_imageSource = IMAGE_SOURCE_URL;
               this.m_image = param1;
            }
         }
      }
      
      public function setBackgroundSize(param1:int) : void
      {
         this.m_backgroundSize = param1;
      }
      
      public function repaintBackground(param1:Number, param2:Number) : void
      {
         this.m_width = param1;
         this.m_height = param2;
         this.m_canvas.clear();
         if(this.m_solidColorIsSet)
         {
            this.paintSolidColor();
         }
         if(this.m_image)
         {
            this.paintImage();
         }
      }
      
      public function setOnPaintImageCallback(param1:Function) : void
      {
         this.m_onPainImageCallback = param1;
      }
      
      private function paintSolidColor() : void
      {
         this.m_canvas.beginFill(this.m_solidColor,this.m_solidColorAlpha);
         this.m_canvas.drawRect(0,0,this.m_width,this.m_height);
         this.m_canvas.endFill();
      }
      
      private function paintImage() : void
      {
         var _loc1_:Class = null;
         var _loc2_:BitmapData = null;
         var _loc3_:String = null;
         if(this.m_imageSource == IMAGE_SOURCE_BITMAP)
         {
            this.clearSprite();
            _loc1_ = this.getClass(this.m_image);
            if(_loc1_ != null)
            {
               _loc2_ = new _loc1_();
               this.doPaintImage(_loc2_);
            }
         }
         else if(this.m_imageSource == IMAGE_SOURCE_URL)
         {
            this.clearSprite();
            _loc3_ = this.m_prevBitmapName;
            this.m_prevBitmapName = this.m_image;
            this.bitmapManager.unloadBitmap(_loc3_,this.onLoader);
            this.bitmapManager.loadBitmap(this.m_prevBitmapName,this.onLoader);
         }
         else if(this.m_imageSource == IMAGE_SOURCE_SYMBOL)
         {
            this.createSprite();
            this.updateSpriteSize();
         }
      }
      
      private function onLoader(param1:String, param2:BitmapData) : void
      {
         if(this.m_imageSource == IMAGE_SOURCE_URL && this.m_image == param1)
         {
            this.doPaintImage(param2);
         }
      }
      
      private function doPaintImage(param1:BitmapData) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         this.m_matrix.identity();
         var _loc2_:Number = this.m_width;
         var _loc3_:Number = this.m_height;
         if(this.m_backgroundSize == BACKGROUND_SIZE_FILL)
         {
            _loc6_ = _loc2_ / param1.width;
            _loc7_ = _loc3_ / param1.height;
            this.m_matrix.scale(_loc6_,_loc7_);
            _loc4_ = _loc2_;
            _loc5_ = _loc3_;
         }
         else if(this.m_backgroundSize == BACKGROUND_SIZE_CROP)
         {
            _loc4_ = Math.min(_loc2_,param1.width);
            _loc5_ = Math.min(_loc3_,param1.height);
         }
         else if(this.m_backgroundSize == BACKGROUND_SIZE_COVER)
         {
            _loc8_ = _loc2_ / _loc3_;
            _loc9_ = param1.width / param1.height;
            _loc10_ = _loc9_ > _loc8_ ? Number(_loc3_ / param1.height) : Number(_loc2_ / param1.width);
            this.m_matrix.scale(_loc10_,_loc10_);
            this.m_matrix.translate(0.5 * (_loc2_ - _loc10_ * param1.width),0.5 * (_loc3_ - _loc10_ * param1.height));
            _loc4_ = _loc2_;
            _loc5_ = _loc3_;
         }
         else if(this.m_backgroundSize == BACKGROUND_SIZE_REPEAT)
         {
            _loc4_ = _loc2_;
            _loc5_ = _loc3_;
         }
         else if(this.m_backgroundSize == BACKGROUND_SIZE_AUTO)
         {
            if(_loc2_ == 0)
            {
               _loc4_ = param1.width;
               _loc6_ = 1;
            }
            else
            {
               _loc6_ = _loc2_ / param1.width;
               _loc4_ = _loc2_;
            }
            if(_loc3_ == 0)
            {
               _loc5_ = param1.height;
               _loc7_ = 1;
            }
            else
            {
               _loc7_ = _loc3_ / param1.height;
               _loc5_ = _loc3_;
            }
            this.m_matrix.scale(_loc6_,_loc7_);
         }
         else
         {
            _loc4_ = param1.width;
            _loc5_ = param1.height;
         }
         this.m_canvas.beginBitmapFill(param1,this.m_matrix,true,true);
         this.m_canvas.drawRect(0,0,_loc4_,_loc5_);
         this.m_canvas.endFill();
         this.m_onPainImageCallback(_loc4_,_loc5_);
      }
      
      private function createSprite() : void
      {
         var _loc1_:Class = null;
         if(this.m_prevSpriteName != this.m_image)
         {
            this.clearSprite();
            this.m_prevSpriteName = this.m_image;
            _loc1_ = this.getClass(this.m_image);
            if(_loc1_)
            {
               this.m_sprite = new _loc1_();
               this.m_element.addChildAt(this.m_sprite,0);
            }
         }
      }
      
      private function clearSprite() : void
      {
         if(this.m_sprite)
         {
            this.m_element.removeChild(this.m_sprite);
            this.m_prevSpriteName = null;
            this.m_sprite = null;
         }
      }
      
      private function updateSpriteSize() : void
      {
         if(this.m_sprite == null)
         {
            return;
         }
         if(this.m_backgroundSize == BACKGROUND_SIZE_FILL)
         {
            this.m_sprite.width = this.m_width;
            this.m_sprite.height = this.m_height;
         }
         else if(this.m_backgroundSize != BACKGROUND_SIZE_CROP)
         {
            if(this.m_backgroundSize != BACKGROUND_SIZE_COVER)
            {
               if(this.m_backgroundSize == BACKGROUND_SIZE_AUTO)
               {
               }
            }
         }
      }
      
      private function getClass(param1:String) : Class
      {
         if(!ApplicationDomain.currentDomain.hasDefinition(param1))
         {
            throw new Error("[UbBackgroundPainter] can\'t find class: " + param1);
         }
         return getDefinitionByName(param1) as Class;
      }
   }
}
