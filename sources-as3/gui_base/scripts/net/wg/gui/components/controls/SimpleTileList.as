package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.utils.IAssertable;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class SimpleTileList extends UIComponentEx implements ITutorialCustomComponent
   {
      
      protected static const INVALIDATE_LAYOUT:String = "invalidate_layout";
      
      private static const INVALIDATE_RENDERER:String = "invalidate_renderer";
      
      private static const CHILD_SIZE_ERROR:String = "Child size exceeds container size";
      
      private static const DELIMITER:String = ":";
      
      public static const RENDERERS_ALIGN_LEFT:String = "renderers_left";
      
      public static const RENDERERS_ALIGN_RIGHT:String = "renderers_right";
      
      public static const RENDERERS_ALIGN_CENTER:String = "renderers_center";
       
      
      public var border:Sprite = null;
      
      private var _renderers:Vector.<IListItemRenderer> = null;
      
      private var _dataProvider:IDataProvider = null;
      
      private var _itemRenderer:Class = null;
      
      private var _directionMode:String = "horizontal";
      
      private var _tileWidth:uint = 0;
      
      private var _tileHeight:uint = 0;
      
      private var _autoSize:Boolean = true;
      
      private var _asserter:IAssertable = null;
      
      private var _horizontalGap:Number = 0;
      
      private var _verticalGap:Number = 0;
      
      private var _renderersAlign:String = "renderers_left";
      
      private var _renderersChanged:Boolean = false;
      
      public function SimpleTileList()
      {
         App.tutorialMgr.addListenersToCustomTutorialComponent(this);
         super();
         this._asserter = App.utils.asserter;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         if(_width == param1 && _height == param2)
         {
            return;
         }
         super.setSize(param1,param2);
         invalidateData();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(this.border == null)
         {
            this.border = new Sprite();
            this.border.graphics.beginFill(16711680);
            this.border.graphics.drawRect(0,0,10,10);
            this.border.graphics.endFill();
            addChild(this.border);
         }
         this.border.visible = false;
         this._renderers = new Vector.<IListItemRenderer>();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         initSize();
      }
      
      override protected function draw() : void
      {
         var _loc3_:int = 0;
         super.draw();
         var _loc1_:Boolean = isInvalid(INVALIDATE_RENDERER);
         var _loc2_:Boolean = isInvalid(InvalidationType.DATA);
         if(_loc1_)
         {
            this.removeRenderers(this._renderers.length);
         }
         if(_loc2_ || _loc1_)
         {
            this._renderersChanged = true;
            if(this._dataProvider != null)
            {
               _loc3_ = this.getDiffRenderers();
               if(_loc3_ > 0)
               {
                  this.removeRenderers(_loc3_);
               }
               else if(_loc3_ < 0)
               {
                  this.createRenderers(-_loc3_);
               }
               this.updateRenderers();
            }
            else
            {
               this.removeRenderers(this._renderers.length);
            }
            invalidate(INVALIDATE_LAYOUT);
         }
         if(isInvalid(INVALIDATE_LAYOUT))
         {
            this.updateLayout();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.border.width = _width;
            this.border.height = _height;
            this.updateLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
         this.removeRenderers(this._renderers.length);
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this._dataProvider = null;
         }
         this.border = null;
         this._renderers = null;
         this._itemRenderer = null;
         this._asserter = null;
         super.onDispose();
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getRendererAt(param1:uint) : IListItemRenderer
      {
         if(param1 < this._renderers.length)
         {
            return this._renderers[param1];
         }
         return null;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return name + DELIMITER + App.utils.classFactory.getClassName(this._itemRenderer);
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return true;
      }
      
      protected function updateLayout() : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:IListItemRenderer = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc1_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Number = 0;
         if(this._directionMode == DirectionMode.HORIZONTAL)
         {
            _loc2_ = _height;
            _loc6_ = this._tileWidth + this._horizontalGap;
            _loc5_ = width / _loc6_ - 1;
            this._asserter.assert(_loc5_ >= _loc3_,CHILD_SIZE_ERROR);
            for each(_loc7_ in this._renderers)
            {
               if(!this.isRenderStatic(_loc7_))
               {
                  _loc7_.x = _loc3_ * _loc6_;
                  _loc7_.y = _loc4_;
                  if(_loc5_ > _loc3_)
                  {
                     _loc3_++;
                  }
                  else
                  {
                     _loc4_ += this._tileHeight + this._verticalGap;
                     _loc3_ = 0;
                  }
               }
            }
            if(this._autoSize)
            {
               if(_loc3_ > 0)
               {
                  height = _loc4_ + this._tileHeight;
               }
               else if(_loc4_ > 0)
               {
                  height = _loc4_ - this._verticalGap;
               }
               else
               {
                  height = 0;
               }
               _loc1_ = _loc2_ != _height;
            }
         }
         else
         {
            _loc2_ = _width;
            _loc6_ = this._tileHeight + this._verticalGap;
            _loc5_ = height / _loc6_ - 1;
            this._asserter.assert(_loc5_ >= _loc3_,CHILD_SIZE_ERROR);
            for each(_loc7_ in this._renderers)
            {
               if(!this.isRenderStatic(_loc7_))
               {
                  _loc7_.y = _loc3_ * _loc6_;
                  _loc7_.x = _loc4_;
                  if(_loc5_ > _loc3_)
                  {
                     _loc3_++;
                  }
                  else
                  {
                     _loc4_ += this._tileWidth + this._horizontalGap;
                     _loc3_ = 0;
                  }
               }
            }
            if(this._autoSize)
            {
               if(_loc3_ > 0)
               {
                  width = _loc4_ + this._tileWidth;
               }
               else if(_loc4_ > 0)
               {
                  width = _loc4_ - this._horizontalGap;
               }
               else
               {
                  width = 0;
               }
               _loc1_ = _loc2_ != _width;
            }
         }
         var _loc8_:int = this._renderers.length;
         var _loc9_:int = width / (this.tileWidth + this.horizontalGap) | 0;
         if(_loc9_ > 0 && this._renderersAlign != RENDERERS_ALIGN_LEFT)
         {
            _loc10_ = Math.ceil(_loc8_ / _loc9_);
            _loc16_ = 1;
            while(_loc16_ <= _loc10_)
            {
               if(_loc16_ == _loc10_)
               {
                  _loc11_ = _loc9_ - (_loc9_ * _loc16_ - _loc8_);
               }
               else
               {
                  _loc11_ = _loc9_;
               }
               _loc12_ = _loc11_ * this.tileWidth + (_loc11_ - 1) * this.horizontalGap;
               if(this._renderersAlign == RENDERERS_ALIGN_CENTER)
               {
                  _loc13_ = width - _loc12_ >> 1;
               }
               else
               {
                  _loc13_ = width - _loc12_;
               }
               _loc14_ = _loc9_ * (_loc16_ - 1);
               _loc15_ = _loc14_ + _loc11_ - 1;
               this.moveElements(_loc14_,_loc15_,_loc13_);
               _loc16_++;
            }
         }
         if(_loc1_)
         {
            dispatchEvent(new Event(Event.RESIZE));
         }
         if(this._renderersChanged)
         {
            this._renderersChanged = false;
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      protected function isRenderStatic(param1:IListItemRenderer) : Boolean
      {
         return false;
      }
      
      private function getDiffRenderers() : int
      {
         var _loc1_:int = this._renderers.length - this._dataProvider.length;
         if(this._directionMode == DirectionMode.HORIZONTAL && !this._autoSize)
         {
            _loc1_ = this._renderers.length - ((height + this._verticalGap) / (this._tileHeight + this._verticalGap) ^ 0);
         }
         if(this._directionMode == DirectionMode.VERTICAL && !this._autoSize)
         {
            _loc1_ = this._renderers.length - ((width + this._horizontalGap) / (this._tileWidth + this._horizontalGap) ^ 0);
         }
         return _loc1_;
      }
      
      private function updateRenderers() : void
      {
         var _loc4_:IListItemRenderer = null;
         var _loc1_:uint = this._renderers.length;
         var _loc2_:Array = this._dataProvider.requestItemRange(0,_loc1_);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = this._renderers[_loc3_];
            _loc4_.index = _loc3_;
            _loc4_.setData(_loc2_[_loc3_]);
            _loc3_++;
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      private function createRenderers(param1:uint) : void
      {
         var _loc3_:IListItemRenderer = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = IListItemRenderer(new this._itemRenderer());
            addChild(DisplayObject(_loc3_));
            _loc3_.validateNow();
            this._renderers.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function removeRenderers(param1:uint) : void
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = this._renderers[_loc3_];
            _loc2_.dispose();
            removeChild(DisplayObject(_loc2_));
            _loc3_++;
         }
         this._renderers.splice(0,param1);
      }
      
      private function moveElements(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:IListItemRenderer = null;
         var _loc5_:int = param1;
         while(_loc5_ <= param2)
         {
            _loc4_ = this._renderers[_loc5_];
            _loc4_.x += param3;
            _loc5_++;
         }
      }
      
      public function get renderersAlign() : String
      {
         return this._renderersAlign;
      }
      
      public function set renderersAlign(param1:String) : void
      {
         if(this._renderersAlign == param1)
         {
            return;
         }
         this._renderersAlign = param1;
         invalidate(INVALIDATE_LAYOUT);
      }
      
      public function get length() : int
      {
         return this._renderers.length;
      }
      
      public function get itemRenderer() : Class
      {
         return this._itemRenderer;
      }
      
      public function set itemRenderer(param1:Class) : void
      {
         if(this._itemRenderer == param1)
         {
            return;
         }
         this._asserter.assertNotNull(param1,"itemRenderer" + Errors.CANT_NULL);
         this._itemRenderer = param1;
         invalidate(INVALIDATE_RENDERER);
      }
      
      public function get directionMode() : String
      {
         return this._directionMode;
      }
      
      public function set directionMode(param1:String) : void
      {
         if(this._directionMode == param1)
         {
            return;
         }
         this._asserter.assert(param1 == DirectionMode.HORIZONTAL || param1 == DirectionMode.VERTICAL,"Invalid value directionMode in SimpleTileList");
         this._directionMode = param1;
         invalidate(INVALIDATE_LAYOUT);
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(param1 != this._dataProvider)
         {
            if(this._dataProvider != null)
            {
               this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            }
            this._dataProvider = param1;
            if(this._dataProvider != null)
            {
               this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            }
            invalidateData();
         }
      }
      
      public function get autoSize() : Boolean
      {
         return this._autoSize;
      }
      
      public function set autoSize(param1:Boolean) : void
      {
         if(this._autoSize == param1)
         {
            return;
         }
         this._autoSize = param1;
         invalidate(INVALIDATE_LAYOUT);
      }
      
      public function get tileWidth() : uint
      {
         return this._tileWidth;
      }
      
      public function set tileWidth(param1:uint) : void
      {
         if(this._tileWidth == param1)
         {
            return;
         }
         this._tileWidth = param1;
         invalidate(INVALIDATE_LAYOUT);
      }
      
      public function get tileHeight() : uint
      {
         return this._tileHeight;
      }
      
      public function set tileHeight(param1:uint) : void
      {
         if(this._tileHeight == param1)
         {
            return;
         }
         this._tileHeight = param1;
         invalidate(INVALIDATE_LAYOUT);
      }
      
      public function get horizontalGap() : Number
      {
         return this._horizontalGap;
      }
      
      public function set horizontalGap(param1:Number) : void
      {
         if(this._horizontalGap == param1)
         {
            return;
         }
         this._horizontalGap = param1;
         invalidate(INVALIDATE_LAYOUT);
      }
      
      public function get verticalGap() : Number
      {
         return this._verticalGap;
      }
      
      public function set verticalGap(param1:Number) : void
      {
         if(this._verticalGap == param1)
         {
            return;
         }
         this._verticalGap = param1;
         invalidate(INVALIDATE_LAYOUT);
      }
      
      protected function get renderers() : Vector.<IListItemRenderer>
      {
         return this._renderers;
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         invalidateData();
      }
   }
}
