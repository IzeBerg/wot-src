package net.wg.gui.components.battleRoyale
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.battleRoyale.data.ArrowDrawCommand;
   import net.wg.gui.components.battleRoyale.data.ConfiguratorColumnVO;
   import net.wg.gui.components.battleRoyale.data.ConfiguratorModuleVO;
   import net.wg.infrastructure.base.meta.IVehModulesConfiguratorCmpMeta;
   import net.wg.infrastructure.base.meta.impl.VehModulesConfiguratorCmpMeta;
   import net.wg.infrastructure.interfaces.IViewStackExContent;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.IDataUtils;
   
   public class VehModuleConfiguratorCmp extends VehModulesConfiguratorCmpMeta implements IVehModulesConfiguratorCmpMeta, IViewStackExContent
   {
      
      private static const COLUMN_STEP:int = 100;
      
      private static const COLUMN_PIVOT_POINT_X:int = -20;
      
      private static const COLUMN_PIVOT_POINT_Y:int = -20;
      
      private static const ARROW_CENTER_COLLISION_OFFSET:int = 10;
      
      private static const ARROW_COLOR_ACTIVE:uint = 4294967295;
      
      private static const ARROW_COLOR_DISABLE:uint = 872415231;
      
      private static const HEADER_BOTTOM_OFFSET:Number = -15;
      
      private static const MODULE_X:Number = -9;
      
      private static const MODULE_OFFSET_Y:Number = 12;
      
      private static const POINTER_BITMAP_DATA_LINKAGE:String = "ArrowPointerBD";
       
      
      private var _columnSelectorIdx:int = -1;
      
      private var _classFactory:IClassFactory;
      
      private var _dataUtils:IDataUtils;
      
      private var _columnSelector:Bitmap;
      
      private var _data:Vector.<ConfiguratorColumnVO> = null;
      
      private var _itemsByIntCD:Dictionary;
      
      private var _columnsContainers:Vector.<Sprite>;
      
      private var _headers:Vector.<ColumnHeader>;
      
      private var _arrowsRenderer:Bitmap;
      
      private var _arrowsGraphics:BitmapData = null;
      
      private var _pointerMask:BitmapData = null;
      
      private var _activePointer:BitmapData = null;
      
      private var _disablePointer:BitmapData = null;
      
      private var _currentOverStateModule:IConfiguratorRenderer = null;
      
      public function VehModuleConfiguratorCmp()
      {
         this._classFactory = App.utils.classFactory;
         this._dataUtils = App.utils.data;
         this._columnSelector = new Bitmap();
         this._itemsByIntCD = new Dictionary();
         this._columnsContainers = new Vector.<Sprite>(0);
         this._headers = new Vector.<ColumnHeader>(0);
         this._arrowsRenderer = new Bitmap();
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:Class = this._classFactory.getClass(Linkages.COLUMN_SELECTOR);
         this._columnSelector.bitmapData = new _loc1_();
         this._columnSelector.x = COLUMN_PIVOT_POINT_X;
         this._columnSelector.y = COLUMN_PIVOT_POINT_Y;
         this._pointerMask = this._classFactory.getObject(POINTER_BITMAP_DATA_LINKAGE) as BitmapData;
         this._activePointer = new BitmapData(this._pointerMask.width,this._pointerMask.height,true,ARROW_COLOR_ACTIVE);
         this._disablePointer = new BitmapData(this._pointerMask.width,this._pointerMask.height,true,ARROW_COLOR_DISABLE);
         this._arrowsRenderer.x = COLUMN_PIVOT_POINT_X;
         this._arrowsRenderer.y = COLUMN_PIVOT_POINT_Y;
         addChild(this._arrowsRenderer);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addEventListener(ModuleConfiguratorEvent.MODULE_CLICK,this.onModuleClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(ModuleConfiguratorEvent.MODULE_CLICK,this.onModuleClickHandler);
         App.utils.commons.releaseReferences(this);
         this._dataUtils.cleanupDynamicObject(this._itemsByIntCD);
         this._itemsByIntCD = null;
         this._columnsContainers.length = 0;
         this._columnsContainers = null;
         this._headers.length = 0;
         this._headers = null;
         this._dataUtils = null;
         this._classFactory = null;
         this._columnSelector = null;
         this._arrowsRenderer = null;
         if(this._arrowsGraphics != null)
         {
            this._arrowsGraphics.dispose();
            this._arrowsGraphics = null;
         }
         if(this._disablePointer != null)
         {
            this._disablePointer.dispose();
            this._disablePointer = null;
         }
         if(this._activePointer != null)
         {
            this._activePointer.dispose();
            this._activePointer = null;
         }
         if(this._pointerMask != null)
         {
            this._pointerMask.dispose();
            this._pointerMask = null;
         }
         this._data = null;
         this._currentOverStateModule = null;
         super.onDispose();
      }
      
      override protected function setItems(param1:Vector.<ConfiguratorColumnVO>) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:ConfiguratorColumnVO = null;
         var _loc5_:ConfiguratorModuleVO = null;
         var _loc6_:Sprite = null;
         var _loc7_:Vector.<ConfiguratorModuleVO> = null;
         var _loc8_:ColumnHeader = null;
         var _loc9_:IConfiguratorRenderer = null;
         var _loc10_:Sprite = null;
         var _loc15_:uint = 0;
         this.clear();
         this._data = param1;
         var _loc2_:uint = param1.length;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Class = this._classFactory.getClass(Linkages.BATTLE_ROYALE_COLUMN_BG);
         var _loc14_:uint = 0;
         while(_loc14_ < _loc2_)
         {
            _loc4_ = param1[_loc14_];
            _loc6_ = this.addColumnContainer();
            if(_loc14_ % 2 == 0)
            {
               _loc10_ = new _loc13_();
               _loc6_.addChild(_loc10_);
            }
            _loc7_ = _loc4_.moduleVOs;
            _loc3_ = _loc7_.length;
            _loc8_ = this.createColumnHeader(_loc6_,_loc4_);
            this.updateHeaderAlpha(_loc8_,_loc4_);
            _loc15_ = 0;
            while(_loc15_ < _loc3_)
            {
               _loc5_ = _loc7_[_loc15_];
               _loc9_ = this.createRenderer();
               _loc9_.setIndex(_loc14_,_loc15_);
               _loc9_.x = MODULE_X;
               _loc9_.y = HEADER_BOTTOM_OFFSET + (_loc9_.height + MODULE_OFFSET_Y) * _loc15_ + _loc5_.gap;
               _loc9_.setData(_loc5_);
               this._itemsByIntCD[_loc5_.intCD] = _loc9_;
               _loc6_.addChild(_loc9_ as DisplayObject);
               _loc15_++;
            }
            _loc6_.x = _loc11_;
            _loc11_ += COLUMN_STEP;
            _loc12_ = Math.max(_loc6_.height,_loc12_);
            if(_loc4_.highlighted)
            {
               this.showColumnSelectorInContainer(_loc4_.index);
            }
            _loc14_++;
         }
         this.setupDrawLayout(_loc11_,_loc12_);
         this.drawLinks(param1);
         dispatchEvent(new Event(Event.RESIZE));
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      override protected function updateItems(param1:Vector.<ConfiguratorColumnVO>) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:ConfiguratorColumnVO = null;
         var _loc5_:ConfiguratorModuleVO = null;
         var _loc6_:Vector.<ConfiguratorModuleVO> = null;
         var _loc7_:IConfiguratorRenderer = null;
         var _loc8_:ConfiguratorColumnVO = null;
         var _loc11_:uint = 0;
         this._columnSelectorIdx = Values.DEFAULT_INT;
         var _loc2_:uint = param1.length;
         var _loc9_:uint = 0;
         while(_loc9_ < _loc2_)
         {
            _loc4_ = param1[_loc9_];
            _loc8_ = this._data[_loc4_.index];
            _loc8_.updateStates(_loc4_);
            _loc6_ = _loc4_.moduleVOs;
            _loc3_ = _loc6_.length;
            this.updateHeaderAlpha(this._headers[_loc4_.index],_loc4_);
            _loc11_ = 0;
            while(_loc11_ < _loc3_)
            {
               _loc5_ = _loc6_[_loc11_];
               _loc7_ = this._itemsByIntCD[_loc5_.intCD] as IConfiguratorRenderer;
               if(_loc7_ != null)
               {
                  _loc7_.setData(_loc5_);
               }
               _loc11_++;
            }
            _loc9_++;
         }
         var _loc10_:int = Values.DEFAULT_INT;
         _loc2_ = this._data.length;
         _loc9_ = 0;
         while(_loc9_ < _loc2_)
         {
            if(this._data[_loc9_].availableForSelection)
            {
               _loc10_ = _loc9_;
               break;
            }
            _loc9_++;
         }
         this.showColumnSelectorInContainer(_loc10_);
         this.setupDrawLayout();
         this.drawLinks(this._data);
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function makeOutStateModule() : void
      {
         if(this._currentOverStateModule)
         {
            this._currentOverStateModule.makeUpState();
            this._currentOverStateModule = null;
         }
      }
      
      public function makeOverStateModule(param1:int) : void
      {
         this._currentOverStateModule = this._itemsByIntCD[param1] as IConfiguratorRenderer;
         if(this._currentOverStateModule != null)
         {
            this._currentOverStateModule.makeOverState();
         }
      }
      
      public function selectItem(param1:int) : void
      {
         var _loc2_:IConfiguratorRenderer = this._itemsByIntCD[param1] as IConfiguratorRenderer;
         if(_loc2_ != null)
         {
            onClickS(_loc2_.moduleIntCD,_loc2_.columnIdx,_loc2_.moduleIdx);
         }
         else
         {
            App.utils.asserter.assert(false,Errors.WRONG_VALUE + " intCD = " + param1);
         }
      }
      
      public function setActive(param1:Boolean) : void
      {
      }
      
      public function update(param1:Object) : void
      {
      }
      
      private function addColumnContainer() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         this._columnsContainers.push(_loc1_);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function showColumnSelectorInContainer(param1:int) : void
      {
         if(param1 == Values.DEFAULT_INT)
         {
            this._columnSelector.visible = false;
         }
         else
         {
            this._columnSelectorIdx = param1;
            this._columnsContainers[param1].addChildAt(this._columnSelector,0);
            this._columnSelector.visible = true;
         }
      }
      
      private function drawLinks(param1:Vector.<ConfiguratorColumnVO>) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:ConfiguratorColumnVO = null;
         var _loc5_:ConfiguratorModuleVO = null;
         var _loc6_:Vector.<ConfiguratorModuleVO> = null;
         var _loc8_:Vector.<int> = null;
         var _loc9_:ArrowDrawCommand = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:int = 0;
         var _loc20_:ConfiguratorModuleVO = null;
         var _loc21_:Point = null;
         var _loc22_:Point = null;
         var _loc23_:Point = null;
         var _loc24_:Point = null;
         var _loc25_:Point = null;
         var _loc26_:int = 0;
         var _loc2_:uint = param1.length;
         var _loc7_:Vector.<ArrowDrawCommand> = new Vector.<ArrowDrawCommand>(0);
         var _loc10_:Boolean = false;
         var _loc15_:int = param1[0].moduleVOs[0].intCD;
         var _loc16_:uint = 1;
         while(_loc16_ < _loc2_)
         {
            _loc4_ = param1[_loc16_];
            _loc6_ = _loc4_.moduleVOs;
            _loc3_ = _loc6_.length;
            _loc17_ = 0;
            for(; _loc17_ < _loc3_; _loc17_++)
            {
               _loc5_ = _loc6_[_loc17_];
               _loc8_ = _loc5_.potentialLinks;
               _loc18_ = _loc8_.length;
               if(_loc17_ < _loc3_ - 1 && _loc8_.length > 1)
               {
                  _loc20_ = _loc6_[_loc17_ + 1];
                  if(this.isEqualPotentialLinks(_loc5_.potentialLinks,_loc20_.potentialLinks))
                  {
                     _loc11_ = _loc8_[0];
                     _loc12_ = _loc8_[1];
                     _loc13_ = _loc5_.activeLink;
                     _loc14_ = _loc20_.activeLink;
                     _loc21_ = this.getCenterPointByIntCD(_loc11_,true);
                     _loc22_ = this.getCenterPointByIntCD(_loc12_,true);
                     _loc23_ = this.getCenterPointByIntCD(_loc5_.intCD);
                     _loc24_ = this.getCenterPointByIntCD(_loc20_.intCD);
                     _loc25_ = new Point(_loc21_.x + _loc23_.x >> 1,_loc21_.y + _loc22_.y >> 1);
                     _loc10_ = _loc13_ == _loc11_ || _loc14_ == _loc11_ || _loc5_.available && _loc15_ == _loc11_;
                     _loc9_ = new ArrowDrawCommand(_loc21_,_loc25_,-1,_loc10_,false);
                     this.addDrawCommand(_loc7_,_loc9_);
                     _loc10_ = _loc13_ == _loc11_ || _loc13_ == _loc12_ || _loc5_.available;
                     _loc9_ = new ArrowDrawCommand(_loc25_,_loc23_,-1,_loc10_);
                     this.addDrawCommand(_loc7_,_loc9_);
                     _loc10_ = _loc13_ == _loc12_ || _loc14_ == _loc12_ || _loc5_.available && _loc15_ == _loc12_;
                     _loc9_ = new ArrowDrawCommand(_loc22_,_loc25_,-1,_loc10_,false);
                     this.addDrawCommand(_loc7_,_loc9_);
                     _loc10_ = _loc14_ == _loc11_ || _loc14_ == _loc12_ || _loc5_.available;
                     _loc9_ = new ArrowDrawCommand(_loc25_,_loc24_,-1,_loc10_);
                     this.addDrawCommand(_loc7_,_loc9_);
                     if(_loc5_.selected)
                     {
                        _loc15_ = _loc5_.intCD;
                     }
                     else if(_loc20_.selected)
                     {
                        _loc15_ = _loc20_.intCD;
                     }
                     _loc17_++;
                     continue;
                  }
               }
               _loc19_ = 0;
               while(_loc19_ < _loc18_)
               {
                  _loc26_ = _loc8_[_loc19_];
                  _loc9_ = new ArrowDrawCommand(this.getCenterPointByIntCD(_loc26_,true),this.getCenterPointByIntCD(_loc5_.intCD),_loc18_,_loc5_.activeLink == _loc26_ || _loc5_.available && _loc15_ == _loc26_);
                  this.addDrawCommand(_loc7_,_loc9_);
                  _loc19_++;
               }
               if(_loc5_.selected)
               {
                  _loc15_ = _loc5_.intCD;
               }
            }
            _loc16_++;
         }
         this.doDrawCommands(_loc7_);
      }
      
      private function doDrawCommands(param1:Vector.<ArrowDrawCommand>) : void
      {
         var _loc2_:ArrowDrawCommand = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:Boolean = false;
         this._arrowsGraphics.lock();
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_.fromPoint;
            _loc4_ = _loc2_.toPoint;
            _loc5_ = _loc2_.isActive;
            if(_loc2_.countPotentialLinks > 1 && _loc3_.y != _loc4_.y)
            {
               if(_loc3_.y < _loc4_.y)
               {
                  _loc4_.y -= ARROW_CENTER_COLLISION_OFFSET;
               }
               else
               {
                  _loc4_.y += ARROW_CENTER_COLLISION_OFFSET;
               }
            }
            if(_loc2_.isWithArrow)
            {
               this.drawPointer(_loc4_,_loc5_);
            }
            this.drawPathFromTo(_loc3_,_loc4_,_loc5_);
         }
         this._arrowsGraphics.unlock();
      }
      
      private function getCenterPointByIntCD(param1:int, param2:Boolean = false) : Point
      {
         var _loc3_:IConfiguratorRenderer = this._itemsByIntCD[param1];
         var _loc4_:Rectangle = _loc3_.getNodeBounds(this);
         var _loc5_:int = !!param2 ? int(_loc4_.x + _loc4_.width) : int(_loc4_.x);
         var _loc6_:int = _loc4_.y + (_loc4_.height >> 1);
         return new Point(_loc5_,_loc6_);
      }
      
      private function drawPathFromTo(param1:Point, param2:Point, param3:Boolean = false) : void
      {
         var drawRect:Rectangle = null;
         var centerPoint:Point = null;
         var start:Point = param1;
         var end:Point = param2;
         var isActive:Boolean = param3;
         var setLineRectangle:Function = function(param1:Point, param2:Point):void
         {
            drawRect = new Rectangle(param1.x,param1.y,param2.x - param1.x,param2.y - param1.y);
            drawRect.offset(-_arrowsRenderer.x,-_arrowsRenderer.y);
            if(drawRect.width == 0)
            {
               drawRect.width = 1;
               if(param2.y < param1.y)
               {
                  drawRect.offset(0,1);
               }
            }
            else if(drawRect.height == 0)
            {
               drawRect.height = 1;
               if(param2.x < param1.x)
               {
                  drawRect.offset(1,0);
               }
            }
            else
            {
               drawRect.setEmpty();
            }
         };
         var arrowColor:uint = !!isActive ? uint(ARROW_COLOR_ACTIVE) : uint(ARROW_COLOR_DISABLE);
         drawRect = null;
         if(start.y == end.y)
         {
            setLineRectangle(start,end);
            this._arrowsGraphics.fillRect(drawRect,arrowColor);
         }
         else
         {
            centerPoint = new Point(start.x + end.x >> 1,start.y + end.y >> 1);
            setLineRectangle(start,new Point(centerPoint.x,start.y));
            this._arrowsGraphics.fillRect(drawRect,arrowColor);
            setLineRectangle(new Point(centerPoint.x,start.y),new Point(centerPoint.x,end.y));
            this._arrowsGraphics.fillRect(drawRect,arrowColor);
            setLineRectangle(new Point(centerPoint.x,end.y),end);
            this._arrowsGraphics.fillRect(drawRect,arrowColor);
         }
      }
      
      private function drawPointer(param1:Point, param2:Boolean = false) : void
      {
         var _loc3_:BitmapData = !!param2 ? this._activePointer : this._disablePointer;
         var _loc4_:Rectangle = _loc3_.rect;
         var _loc5_:Point = new Point(param1.x - this._arrowsRenderer.x - _loc4_.width,param1.y - this._arrowsRenderer.y - (_loc4_.height >> 1));
         this._arrowsGraphics.copyPixels(_loc3_,_loc4_,_loc5_,this._pointerMask);
      }
      
      private function createColumnHeader(param1:Sprite, param2:ConfiguratorColumnVO) : ColumnHeader
      {
         var _loc3_:ColumnHeader = this._classFactory.getComponent(Linkages.COLUMN_HEADER,ColumnHeader);
         this._headers.push(_loc3_);
         _loc3_.setData(param2.headerIcon,param2.headerText);
         param1.addChild(_loc3_);
         return _loc3_;
      }
      
      private function clear() : void
      {
         var _loc1_:Sprite = null;
         for each(_loc1_ in this._columnsContainers)
         {
            App.utils.commons.releaseReferences(_loc1_);
            removeChild(_loc1_);
         }
         this._dataUtils.cleanupDynamicObject(this._columnsContainers);
         this._dataUtils.cleanupDynamicObject(this._itemsByIntCD);
         this._dataUtils.cleanupDynamicObject(this._headers);
         this._columnSelectorIdx = Values.DEFAULT_INT;
      }
      
      private function setupDrawLayout(param1:int = -1, param2:int = -1) : void
      {
         if(this._arrowsGraphics != null && (param1 == Values.DEFAULT_INT || this._arrowsGraphics.width == param1) && (param2 == Values.DEFAULT_INT || this._arrowsGraphics.height == param2))
         {
            this._arrowsGraphics.lock();
            this._arrowsGraphics.fillRect(this._arrowsGraphics.rect,0);
            this._arrowsGraphics.unlock();
            return;
         }
         if(this._arrowsGraphics != null)
         {
            this._arrowsGraphics.dispose();
         }
         this._arrowsGraphics = new BitmapData(param1,param2,true,0);
         this._arrowsRenderer.bitmapData = this._arrowsGraphics;
      }
      
      private function createRenderer() : IConfiguratorRenderer
      {
         return this._classFactory.getComponent(Linkages.CONFIGURATOR_RENDERER,IConfiguratorRenderer);
      }
      
      private function isEqualPotentialLinks(param1:Vector.<int>, param2:Vector.<int>) : Boolean
      {
         if(param1.length != param2.length)
         {
            return false;
         }
         var _loc3_:uint = param1.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2.indexOf(param1[_loc4_]) < 0)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      private function addDrawCommand(param1:Vector.<ArrowDrawCommand>, param2:ArrowDrawCommand) : void
      {
         if(param2.isActive)
         {
            param1.push(param2);
         }
         else
         {
            param1.unshift(param2);
         }
      }
      
      private function updateHeaderAlpha(param1:ColumnHeader, param2:ConfiguratorColumnVO) : void
      {
         if(param2.selected)
         {
            param1.status = ColumnHeader.SELECTED;
         }
         else if(param2.availableForSelection)
         {
            param1.status = !!param2.highlighted ? int(ColumnHeader.HIGHLIGHTED) : int(ColumnHeader.ENABLED);
         }
         else
         {
            param1.status = ColumnHeader.DISABLED;
         }
      }
      
      public function get availableForSelection() : Boolean
      {
         return this._columnSelectorIdx != Values.DEFAULT_INT;
      }
      
      private function onModuleClickHandler(param1:ModuleConfiguratorEvent) : void
      {
         onClickS(param1.moduleIntCD,param1.columnIdx,param1.moduleIdx);
         param1.stopPropagation();
      }
   }
}
