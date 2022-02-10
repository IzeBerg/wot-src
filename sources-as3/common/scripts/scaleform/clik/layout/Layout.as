package scaleform.clik.layout
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import scaleform.clik.constants.LayoutMode;
   import scaleform.clik.events.ResizeEvent;
   import scaleform.gfx.Extensions;
   
   public class Layout extends Sprite
   {
      
      public static const STAGE_ALIGN_CENTER:String = "";
       
      
      public var identifier:String = null;
      
      protected var _rect:Rectangle = null;
      
      protected var _tiedToStageSize:Boolean = false;
      
      protected var _tiedToParent:Boolean = false;
      
      protected var _hidden:Boolean = false;
      
      protected var _parent:Sprite = null;
      
      protected var _managedSprites:Vector.<Sprite>;
      
      protected var _aspectRatio:String = "";
      
      public function Layout()
      {
         super();
         this.initialize();
      }
      
      public function initialize() : void
      {
         addEventListener(Event.ADDED_TO_STAGE,this.handleAddedToStage,false,0,true);
         this._managedSprites = new Vector.<Sprite>();
      }
      
      public function get rect() : Rectangle
      {
         return this._rect;
      }
      
      public function set rect(param1:Rectangle) : void
      {
         this._rect = param1;
      }
      
      [Inspectable(defaultValue="false")]
      public function get tiedToStageSize() : Boolean
      {
         return this._tiedToStageSize;
      }
      
      public function set tiedToStageSize(param1:Boolean) : void
      {
         if(param1 == this._tiedToStageSize)
         {
            return;
         }
         this._tiedToStageSize = param1;
         this._tiedToParent = false;
         if(stage != null)
         {
            stage.removeEventListener(Event.RESIZE,this.handleStageResize,false);
            if(this._tiedToStageSize)
            {
               stage.addEventListener(Event.RESIZE,this.handleStageResize,false,0,true);
               this.updateAspectRatio();
            }
         }
      }
      
      [Inspectable(defaultValue="false")]
      public function get tiedToParent() : Boolean
      {
         return this._tiedToParent;
      }
      
      public function set tiedToParent(param1:Boolean) : void
      {
         if(param1 == this._tiedToParent)
         {
            return;
         }
         this._tiedToParent = param1;
         this._tiedToStageSize = false;
         if(this._parent != null)
         {
            this._parent.removeEventListener(ResizeEvent.RESIZE,this.handleParentResize,false);
            if(this._tiedToParent)
            {
               this._parent.addEventListener(ResizeEvent.RESIZE,this.handleParentResize,false,0,true);
            }
         }
      }
      
      [Inspectable(defaultValue="true")]
      public function get hidden() : Boolean
      {
         return this._hidden;
      }
      
      public function set hidden(param1:Boolean) : void
      {
         this._hidden = param1;
         visible = !this._hidden;
      }
      
      override public function get width() : Number
      {
         return super.width;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         if(param1 > 0)
         {
            this.invalidate();
         }
      }
      
      override public function get height() : Number
      {
         return super.height;
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         if(param1 > 0)
         {
            this.invalidate();
         }
      }
      
      override public function get scaleX() : Number
      {
         return super.scaleX;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
         this.invalidate();
      }
      
      override public function get scaleY() : Number
      {
         return super.scaleY;
      }
      
      override public function set scaleY(param1:Number) : void
      {
         super.scaleY = param1;
         this.invalidate();
      }
      
      public function reflow() : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:LayoutData = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:Sprite = null;
         var _loc10_:String = null;
         var _loc11_:Sprite = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._managedSprites.length)
         {
            _loc2_ = this._managedSprites[_loc1_];
            _loc3_ = _loc2_["layoutData"] as LayoutData;
            _loc4_ = _loc3_.alignH;
            _loc5_ = _loc3_.alignV;
            _loc6_ = this._tiedToStageSize && _loc3_.offsetHashH[this._aspectRatio] != undefined ? Number(_loc3_.offsetHashH[this._aspectRatio]) : Number(_loc3_.offsetH);
            _loc7_ = this._tiedToStageSize && _loc3_.offsetHashV[this._aspectRatio] != undefined ? Number(_loc3_.offsetHashV[this._aspectRatio]) : Number(_loc3_.offsetV);
            _loc8_ = _loc3_.relativeToH;
            _loc9_ = _loc8_ != null ? this._parent.getChildByName(_loc8_) as Sprite : null;
            _loc10_ = _loc3_.relativeToV;
            _loc11_ = _loc10_ != null ? this._parent.getChildByName(_loc10_) as Sprite : null;
            if(_loc4_ != LayoutMode.ALIGN_NONE)
            {
               if(_loc4_ == LayoutMode.ALIGN_LEFT)
               {
                  if(_loc9_ == null)
                  {
                     _loc2_.x = this.rect.x + _loc6_;
                  }
                  else
                  {
                     _loc2_.x = _loc9_.x - _loc2_.width + _loc6_;
                  }
               }
               else if(_loc4_ == LayoutMode.ALIGN_RIGHT)
               {
                  if(_loc9_ == null)
                  {
                     _loc2_.x = this.rect.width - _loc2_.width + _loc6_;
                     if(this._tiedToStageSize && (stage.align == STAGE_ALIGN_CENTER || stage.align == StageAlign.TOP || stage.align == StageAlign.BOTTOM))
                     {
                        _loc2_.x += this.rect.x;
                     }
                  }
                  else
                  {
                     _loc2_.x = _loc9_.x + _loc9_.width + _loc6_;
                  }
               }
               else if(_loc4_ == LayoutMode.ALIGN_CENTER)
               {
                  _loc2_.x = this.rect.width / 2 + this.rect.x - (_loc2_.width / 2 + _loc6_);
               }
            }
            if(_loc5_ != LayoutMode.ALIGN_NONE)
            {
               if(_loc5_ == LayoutMode.ALIGN_TOP)
               {
                  if(_loc11_ == null)
                  {
                     _loc2_.y = this.rect.y + _loc7_;
                  }
                  else
                  {
                     _loc2_.y = _loc11_.y - _loc2_.height + _loc7_;
                  }
               }
               else if(_loc5_ == LayoutMode.ALIGN_BOTTOM)
               {
                  if(_loc11_ == null)
                  {
                     _loc2_.y = this.rect.height - _loc2_.height + _loc7_;
                     if(this._tiedToStageSize && (stage.align == STAGE_ALIGN_CENTER || stage.align == StageAlign.TOP || stage.align == StageAlign.BOTTOM))
                     {
                        _loc2_.y += this.rect.y;
                     }
                  }
                  else
                  {
                     _loc2_.y = _loc11_.y + _loc11_.height + _loc7_;
                  }
               }
               else if(_loc5_ == LayoutMode.ALIGN_CENTER)
               {
                  _loc2_.y = this.rect.height / 2 + this.rect.y - (_loc2_.height / 2 + _loc7_);
               }
            }
            _loc1_++;
         }
      }
      
      public function reset() : void
      {
         if(stage == null)
         {
            return;
         }
         this._managedSprites = new Vector.<Sprite>();
         this.configUI();
      }
      
      public function resortManagedSprites() : void
      {
         var _loc1_:Vector.<Sprite> = new Vector.<Sprite>();
         while(this._managedSprites.length >= 1)
         {
            this.insertIntoSortedVector(this._managedSprites.pop(),_loc1_);
         }
         this._managedSprites = _loc1_;
      }
      
      protected function invalidate() : void
      {
         addEventListener(Event.RENDER,this.handleStageInvalidation,false,0,true);
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      protected function handleStageInvalidation(param1:Event) : void
      {
         removeEventListener(Event.RENDER,this.handleStageInvalidation,false);
         this._rect.x = x;
         this._rect.y = y;
         this._rect.width = this.width;
         this._rect.height = this.height;
         this.reflow();
      }
      
      protected function handleAddedToStage(param1:Event) : void
      {
         this.configUI();
      }
      
      protected function configUI() : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.handleAddedToStage,false);
         this._parent = parent as MovieClip;
         visible = !this._hidden;
         if(this.width > 0 && this.height > 0)
         {
            this._rect = new Rectangle(x,y,this.width,this.height);
         }
         if(this._rect == null)
         {
            if(this._tiedToStageSize)
            {
               this._rect = !!Extensions.enabled ? Extensions.visibleRect : new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
            }
            else
            {
               this._rect = new Rectangle(0,0,this._parent.width,this._parent.height);
               this._tiedToParent = true;
            }
         }
         addEventListener(Event.ENTER_FRAME,this.handleFirstEnterFrame,false,0,true);
         this._parent.addEventListener(Event.ADDED_TO_STAGE,this.handleSpriteAddedToParent,false,0,true);
         this._parent.addEventListener(Event.REMOVED_FROM_STAGE,this.handleSpriteRemovedFromParent,false,0,true);
         if(this._tiedToStageSize)
         {
            stage.addEventListener(Event.RESIZE,this.handleStageResize,false,0,true);
         }
         else if(this._tiedToParent)
         {
            this._parent.addEventListener(ResizeEvent.RESIZE,this.handleParentResize,false,0,true);
         }
      }
      
      protected function handleFirstEnterFrame(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.handleFirstEnterFrame,false);
         this.analyzeSpritesOnStage();
      }
      
      protected function analyzeSpritesOnStage() : void
      {
         var _loc2_:Sprite = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._parent.numChildren)
         {
            _loc2_ = this._parent.getChildAt(_loc1_) as Sprite;
            if(_loc2_ != this)
            {
               this.evaluateLayoutForSprite(_loc2_);
            }
            _loc1_++;
         }
         this.reflow();
      }
      
      protected function handleSpriteAddedToParent(param1:Event) : void
      {
         var _loc2_:Sprite = param1.target as Sprite;
         if(_loc2_.parent != this._parent)
         {
            return;
         }
         this.evaluateLayoutForSprite(_loc2_);
         this.reflow();
      }
      
      protected function handleSpriteRemovedFromParent(param1:Event) : void
      {
         var _loc2_:Sprite = param1.target as Sprite;
         if(_loc2_.parent != this._parent)
         {
            return;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this._managedSprites.length)
         {
            if(this._managedSprites[_loc3_] == _loc2_)
            {
               this._managedSprites.splice(_loc3_,1);
            }
            _loc3_++;
         }
      }
      
      protected function handleParentResize(param1:Event) : void
      {
         this._rect.width = this._parent.width;
         this._rect.height = this._parent.height;
         this.reflow();
      }
      
      protected function handleStageResize(param1:Event) : void
      {
         this.updateAspectRatio();
         this.reflow();
      }
      
      protected function updateAspectRatio() : void
      {
         var _loc1_:Number = NaN;
         if(Extensions.enabled)
         {
            this._rect = Extensions.visibleRect;
            _loc1_ = this.rect.width / this.rect.height;
            switch(_loc1_)
            {
               case 4 / 3:
                  this._aspectRatio = LayoutData.ASPECT_RATIO_4_3;
                  break;
               case 16 / 9:
                  this._aspectRatio = LayoutData.ASPECT_RATIO_16_9;
                  break;
               case 16 / 10:
                  this._aspectRatio = LayoutData.ASPECT_RATIO_16_10;
            }
         }
         else
         {
            this._rect.width = stage.stageWidth;
            this._rect.height = stage.stageHeight;
         }
      }
      
      protected function evaluateLayoutForSprite(param1:Sprite) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:LayoutData = null;
         _loc2_ = param1["layoutData"];
         if(_loc2_ != null && (_loc2_.layoutIdentifier == null || _loc2_.layoutIdentifier == this.identifier))
         {
            this.insertIntoSortedVector(param1,this._managedSprites);
            this.calculateOffsets(param1);
         }
      }
      
      protected function insertIntoSortedVector(param1:Sprite, param2:Vector.<Sprite>) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         var _loc6_:LayoutData = null;
         var _loc3_:int = (param1["layoutData"] as LayoutData).layoutIndex;
         if(param2.length == 0 || _loc3_ == -1)
         {
            param2.push(param1);
         }
         else
         {
            _loc4_ = false;
            _loc5_ = 0;
            while(_loc5_ < param2.length && !_loc4_)
            {
               _loc6_ = param2[_loc5_]["layoutData"] as LayoutData;
               if(_loc3_ >= 0 && _loc3_ <= _loc6_.layoutIndex)
               {
                  param2.splice(_loc5_,0,param1);
                  _loc4_ = true;
               }
               _loc5_++;
            }
            if(!_loc4_)
            {
               param2.push(param1);
            }
         }
      }
      
      protected function calculateOffsets(param1:Sprite) : void
      {
         var _loc2_:LayoutData = param1["layoutData"] as LayoutData;
         var _loc3_:String = _loc2_.alignH;
         var _loc4_:String = _loc2_.alignV;
         var _loc5_:String = _loc2_.relativeToH;
         var _loc6_:Sprite = _loc5_ != null ? this._parent.getChildByName(_loc5_) as Sprite : null;
         var _loc7_:String = _loc2_.relativeToV;
         var _loc8_:Sprite = _loc7_ != null ? this._parent.getChildByName(_loc7_) as Sprite : null;
         if(_loc2_.offsetH == -1)
         {
            if(_loc3_ != LayoutMode.ALIGN_NONE)
            {
               if(_loc3_ == LayoutMode.ALIGN_LEFT)
               {
                  if(_loc6_ == null)
                  {
                     _loc2_.offsetH = param1.x - this.rect.x;
                  }
                  else
                  {
                     _loc2_.offsetH = param1.x - (_loc6_.x + _loc6_.width);
                  }
               }
               else if(_loc3_ == LayoutMode.ALIGN_RIGHT)
               {
                  if(_loc6_ == null)
                  {
                     _loc2_.offsetH = param1.x + param1.width - this.rect.width;
                  }
                  else
                  {
                     _loc2_.offsetH = param1.x - _loc6_.x;
                  }
               }
            }
         }
         if(_loc2_.offsetV == -1)
         {
            if(_loc4_ != LayoutMode.ALIGN_NONE)
            {
               if(_loc4_ == LayoutMode.ALIGN_TOP)
               {
                  if(_loc8_ == null)
                  {
                     _loc2_.offsetV = param1.y - this.rect.y;
                  }
                  else
                  {
                     _loc2_.offsetV = param1.y - (_loc8_.y + _loc8_.height);
                  }
               }
               else if(_loc4_ == LayoutMode.ALIGN_BOTTOM)
               {
                  if(_loc8_ == null)
                  {
                     _loc2_.offsetV = param1.y + param1.height - this.rect.height;
                  }
                  else
                  {
                     _loc2_.offsetV = param1.y - _loc8_.y;
                  }
               }
            }
         }
      }
   }
}
