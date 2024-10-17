package net.wg.gui.battle.pveBase.views.minimap
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import net.wg.gui.battle.pveBase.views.minimap.jacket.grid.PveMinimapGrid;
   import net.wg.gui.battle.views.minimap.ScenarioLayer;
   import net.wg.gui.battle.views.minimap.containers.MinimapEntriesContainer;
   
   public class PveMinimapEntriesContainer extends MinimapEntriesContainer
   {
       
      
      public var scenarioLayer:ScenarioLayer = null;
      
      public var arrows:Sprite = null;
      
      public var attention:Sprite = null;
      
      public var enemy:Sprite = null;
      
      public var ally:Sprite = null;
      
      public var deathZone:Sprite = null;
      
      public var stretchableDeathZone:Sprite = null;
      
      public var goal:Sprite = null;
      
      public var grid:PveMinimapGrid = null;
      
      private var _backgroundLoader:Loader = null;
      
      public var _container:Sprite;
      
      private var _containerRect:Rectangle;
      
      private var _backgroundRect:Rectangle;
      
      private var _gridRect:Rectangle;
      
      private var _zoom:Number = 1;
      
      private var _width:Number = 1;
      
      private var _height:Number = 1;
      
      private var _minimalSize:int = 210;
      
      private var _layersWithSameScaleAsBackground:Vector.<DisplayObject>;
      
      private var _additionalLayerScale:Dictionary;
      
      public function PveMinimapEntriesContainer()
      {
         var _loc3_:DisplayObject = null;
         this._additionalLayerScale = new Dictionary();
         super();
         this._containerRect = new Rectangle(0,0,this._minimalSize,this._minimalSize);
         this._backgroundRect = new Rectangle(0,0,this._minimalSize,this._minimalSize);
         this._gridRect = new Rectangle(0,0,this._minimalSize,this._minimalSize);
         var _loc1_:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
         var _loc2_:int = 0;
         while(_loc2_ < numChildren)
         {
            _loc3_ = getChildAt(_loc2_);
            if(!(_loc3_ == this.grid || _loc3_ == this.scenarioLayer))
            {
               _loc1_.push(_loc3_);
            }
            _loc2_++;
         }
         this._container = new Sprite();
         addChild(this._container);
         for each(_loc3_ in _loc1_)
         {
            this._container.addChild(_loc3_);
         }
         this._layersWithSameScaleAsBackground = new <DisplayObject>[this.arrows,this.stretchableDeathZone,personal];
         this._backgroundLoader = new Loader();
         this._backgroundLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadingCompleteHandler);
         this._backgroundLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingIoErrorHandler);
         addChildAt(this._backgroundLoader,0);
      }
      
      public function getMousePosition() : Point
      {
         return new Point(this._backgroundLoader.mouseX * this._backgroundLoader.scaleX / this._width / this._zoom,this._backgroundLoader.mouseY * this._backgroundLoader.scaleY / this._height / this._zoom);
      }
      
      public function setMinimalSize(param1:int) : void
      {
         if(this._minimalSize == param1)
         {
            return;
         }
         this._minimalSize = param1;
         this._containerRect.width = this._containerRect.height = this._backgroundRect.width = this._backgroundRect.height = this._gridRect.width = this._gridRect.height = param1;
         this.updateSize();
         this.updateScrolling();
      }
      
      override protected function onDispose() : void
      {
         this.scenarioLayer.dispose();
         this.scenarioLayer = null;
         this.grid.dispose();
         this.grid = null;
         this.arrows = null;
         this.attention = null;
         this.enemy = null;
         this.ally = null;
         this.deathZone = null;
         this.stretchableDeathZone = null;
         this.goal = null;
         this._container = null;
         this._backgroundLoader.close();
         this._backgroundLoader.unload();
         this._backgroundLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadingCompleteHandler);
         this._backgroundLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadingIoErrorHandler);
         this._backgroundLoader = null;
         this._layersWithSameScaleAsBackground.length = 0;
         this._layersWithSameScaleAsBackground = null;
         App.instance.utils.data.cleanupDynamicObject(this._additionalLayerScale);
         this._additionalLayerScale = null;
         super.onDispose();
      }
      
      public function setAdditionalLayerScale(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         if(param1 != null && this._container.contains(param1))
         {
            this._additionalLayerScale[param1] = new Point(param2,param3);
         }
      }
      
      public function setGlobalMarkersScale(param1:Number) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = this._container.numChildren;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this._container.getChildAt(_loc4_);
            if(this._layersWithSameScaleAsBackground.indexOf(_loc2_) == -1)
            {
               _loc2_.scaleX = _loc2_.scaleY = param1;
            }
            _loc4_++;
         }
      }
      
      public function setScrolling(param1:Number, param2:Number, param3:Number) : void
      {
         this._containerRect.x = param1;
         this._containerRect.y = param2;
         if(this._zoom != param3)
         {
            this._zoom = param3;
            this.updateSize();
         }
         this.updateScrolling();
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         if(this._width == param1 && this._height == param2)
         {
            return;
         }
         this._width = param1;
         this._height = param2;
         this.updateSize();
         this.updateScrolling();
      }
      
      private function updateSize() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc4_:* = undefined;
         var _loc5_:Point = null;
         this._backgroundLoader.width = this._width * this._zoom;
         this._backgroundLoader.height = this._height * this._zoom;
         this._container.scaleX = this._width / this._minimalSize;
         this._container.scaleY = this._height / this._minimalSize;
         var _loc2_:Number = this._width * this._zoom / this._minimalSize / this._container.scaleX;
         var _loc3_:Number = this._height * this._zoom / this._minimalSize / this._container.scaleY;
         for each(_loc1_ in this._layersWithSameScaleAsBackground)
         {
            _loc1_.scaleX = _loc2_;
            _loc1_.scaleY = _loc3_;
         }
         for(_loc4_ in this._additionalLayerScale)
         {
            _loc1_ = _loc4_ as DisplayObject;
            if(_loc1_ != null)
            {
               _loc5_ = this._additionalLayerScale[_loc4_] as Point;
               if(this._layersWithSameScaleAsBackground.indexOf(_loc1_) != -1)
               {
                  _loc1_.scaleX *= _loc5_.x;
                  _loc1_.scaleY *= _loc5_.y;
               }
               else
               {
                  _loc1_.scaleX = _loc5_.x;
                  _loc1_.scaleY = _loc5_.y;
               }
            }
         }
         this.scenarioLayer.updateSize(this._backgroundLoader.width,this._backgroundLoader.height);
         this.grid.setSize(this._backgroundLoader.width,this._backgroundLoader.height);
         this._backgroundRect.width = this._width / this._backgroundLoader.scaleX;
         this._backgroundRect.height = this._height / this._backgroundLoader.scaleY;
         this._gridRect.width = this._width;
         this._gridRect.height = this._height;
      }
      
      private function updateScrolling() : void
      {
         var _loc1_:Number = this._minimalSize * this._zoom / 2;
         this._gridRect.x = (_loc1_ + this._containerRect.x) * this._container.scaleX | 0;
         this._gridRect.y = (_loc1_ + this._containerRect.y) * this._container.scaleY | 0;
         this._backgroundRect.x = (_loc1_ + this._containerRect.x) * this._container.scaleX / this._backgroundLoader.scaleX;
         this._backgroundRect.y = (_loc1_ + this._containerRect.y) * this._container.scaleY / this._backgroundLoader.scaleY;
         this._container.scrollRect = this._containerRect;
         this.grid.scrollRect = this.scenarioLayer.scrollRect = this._gridRect;
         this._backgroundLoader.scrollRect = this._backgroundRect;
      }
      
      public function get scrollingX() : int
      {
         return this._gridRect.x;
      }
      
      public function get scrollingY() : int
      {
         return this._gridRect.y;
      }
      
      public function getZoom() : Number
      {
         return this._zoom;
      }
      
      public function setBackground(param1:String) : void
      {
         this._backgroundLoader.load(new URLRequest(param1));
      }
      
      private function onLoadingIoErrorHandler(param1:IOErrorEvent) : void
      {
         DebugUtils.LOG_DEBUG(" Couldn\'t load minimap image!");
      }
      
      private function onLoadingCompleteHandler(param1:Event) : void
      {
         this.updateSize();
         this.updateScrolling();
      }
   }
}
