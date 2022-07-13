package net.wg.gui.components.carousels.filters
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.VO.TankCarouselFilterInitVO;
   import net.wg.data.VO.TankCarouselFilterSelectedVO;
   import net.wg.gui.components.controls.ButtonIconNormal;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.ToggleRenderer;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.IPopoverManager;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class TankCarouselFilters extends UIComponentEx implements IPopOverCaller
   {
      
      private static const SELECTED_INVALID:String = "selected_invalid";
      
      private static const INIT_INVALID:String = "init_invalid";
      
      private static const LINKAGE_TOGGLE_RENDERER:String = "ToggleHotFilterRendererUI";
      
      private static const IS_RANKED_FIELD:String = "isRanked";
      
      private static const IS_FRONTLINE_FIELD:String = "isFrontline";
      
      private static const IS_FUN_RANDOM_FIELD:String = "isFunRandom";
      
      private static const HOT_FILTER_TILE_WIDTH:uint = 58;
      
      private static const HOT_FILTER_TILE_HEIGHT:uint = 22;
      
      private static const HOT_FILTERS_GAP:int = 13;
       
      
      public var paramsFilter:ButtonIconNormal = null;
      
      public var listHotFilter:SimpleTileList = null;
      
      protected var popoverMgr:IPopoverManager;
      
      private var _initVO:TankCarouselFilterInitVO = null;
      
      private var _selectedVO:TankCarouselFilterSelectedVO = null;
      
      private var _enableStateInitialized:Boolean = false;
      
      private var _popoverData:Object;
      
      private var _gapOffset:int = 0;
      
      private var _updateHotFilterSelectedFromData:Boolean = true;
      
      public function TankCarouselFilters()
      {
         this.popoverMgr = App.popoverMgr;
         this._popoverData = {};
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         initSize();
         mouseEnabled = false;
         this.listHotFilter.itemRenderer = App.utils.classFactory.getClass(LINKAGE_TOGGLE_RENDERER);
         this.listHotFilter.tileWidth = HOT_FILTER_TILE_WIDTH;
         this.listHotFilter.tileHeight = HOT_FILTER_TILE_HEIGHT;
         this.listHotFilter.verticalGap = this.getHorizontalGap();
         this.listHotFilter.directionMode = DirectionMode.HORIZONTAL;
         this.listHotFilter.autoSize = false;
         this.paramsFilter.addEventListener(ButtonEvent.CLICK,this.onParamsFilterClickHandler);
         addEventListener(ComponentEvent.HIDE,this.onHideHandler);
      }
      
      override protected function onDispose() : void
      {
         this.popoverMgr = null;
         this._initVO = null;
         this._selectedVO = null;
         this.listHotFilter.dispose();
         this.listHotFilter = null;
         this.paramsFilter.removeEventListener(ButtonEvent.CLICK,this.onParamsFilterClickHandler);
         this.paramsFilter.dispose();
         this.paramsFilter = null;
         App.utils.data.cleanupDynamicObject(this._popoverData);
         this._popoverData = null;
         removeEventListener(ComponentEvent.HIDE,this.onHideHandler);
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:IListItemRenderer = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Vector.<Boolean> = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:ToggleRenderer = null;
         super.draw();
         var _loc2_:Boolean = this._initVO != null;
         var _loc3_:Boolean = this.listHotFilter != null;
         if(isInvalid(INIT_INVALID) && _loc2_)
         {
            this.paramsFilter.iconSource = this._initVO.mainBtn.value;
            this.paramsFilter.tooltip = this._initVO.mainBtn.tooltip;
            this.listHotFilter.dataProvider = this._initVO.hotFilters;
         }
         if(isInvalid(InvalidationType.SIZE) && _loc3_ && _loc2_)
         {
            _loc4_ = this.getHorizontalGap();
            _loc5_ = HOT_FILTER_TILE_HEIGHT + _loc4_;
            _loc6_ = Math.round((height - this.listHotFilter.y + _loc4_) / _loc5_) * _loc5_ - _loc4_;
            _loc7_ = _loc5_ * this._initVO.hotFilters.length - _loc4_;
            this.listHotFilter.height = Math.min(_loc6_,_loc7_);
            _height = this.listHotFilter.y + this.listHotFilter.height;
            dispatchEvent(new Event(Event.RESIZE));
         }
         if(this._selectedVO != null && isInvalid(SELECTED_INVALID) && _loc3_)
         {
            this.listHotFilter.validateNow();
            if(this._selectedVO != null)
            {
               _loc8_ = this._selectedVO.hotFilters;
               _loc9_ = this.listHotFilter.length;
               _loc10_ = 0;
               while(_loc10_ < _loc9_)
               {
                  _loc1_ = this.listHotFilter.getRendererAt(_loc10_);
                  _loc1_.validateNow();
                  _loc1_.selectable = _loc10_ < _loc8_.length ? Boolean(_loc8_[_loc10_]) : Boolean(false);
                  _loc10_++;
               }
            }
         }
         if(!this._enableStateInitialized && _loc3_)
         {
            _loc9_ = this.listHotFilter.length;
            if(_loc9_ > 0)
            {
               _loc11_ = 0;
               while(_loc11_ < _loc9_)
               {
                  _loc12_ = this.listHotFilter.getRendererAt(_loc11_) as ToggleRenderer;
                  if(_loc12_ && this._initVO.hotFilters[_loc11_])
                  {
                     _loc12_.btn.enabled = this._initVO.hotFilters[_loc11_].enabled;
                  }
                  _loc11_++;
               }
               this._enableStateInitialized = true;
            }
         }
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.paramsFilter;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.paramsFilter;
      }
      
      public function initData(param1:TankCarouselFilterInitVO) : void
      {
         this._initVO = param1;
         invalidate(INIT_INVALID);
      }
      
      public function setSelectedData(param1:TankCarouselFilterSelectedVO) : void
      {
         if(param1 != null)
         {
            this._selectedVO = param1;
            invalidate(SELECTED_INVALID);
         }
      }
      
      protected function showPopup() : void
      {
         this._popoverData[IS_RANKED_FIELD] = this._initVO.isRanked;
         this._popoverData[IS_FRONTLINE_FIELD] = this._initVO.isFrontline;
         this._popoverData[IS_FUN_RANDOM_FIELD] = this._initVO.isFunRandom;
         this.popoverMgr.show(this,this._initVO.popoverAlias,this._popoverData);
      }
      
      private function getHorizontalGap() : int
      {
         return HOT_FILTERS_GAP + this._gapOffset;
      }
      
      public function set updateHotFilterSelectedFromData(param1:Boolean) : void
      {
         var _loc4_:uint = 0;
         if(this._updateHotFilterSelectedFromData == param1)
         {
            return;
         }
         this._updateHotFilterSelectedFromData = param1;
         var _loc2_:int = this.listHotFilter.length;
         var _loc3_:ToggleRenderer = null;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.listHotFilter.getRendererAt(_loc4_) as ToggleRenderer;
            if(_loc3_)
            {
               _loc3_.updateSelectedFromData = this._updateHotFilterSelectedFromData;
            }
            _loc4_++;
         }
      }
      
      public function get gapOffset() : int
      {
         return this._gapOffset;
      }
      
      public function set gapOffset(param1:int) : void
      {
         this._gapOffset = param1;
         var _loc2_:int = this.getHorizontalGap();
         this.listHotFilter.verticalGap = _loc2_;
         this.listHotFilter.y = this.paramsFilter.y + this.paramsFilter.height + _loc2_ ^ 0;
         invalidateSize();
      }
      
      public function get popoverData() : Object
      {
         return this._popoverData;
      }
      
      public function set popoverData(param1:Object) : void
      {
         this._popoverData = param1;
      }
      
      private function onParamsFilterClickHandler(param1:ButtonEvent) : void
      {
         if(visible)
         {
            this.showPopup();
         }
      }
      
      private function onHideHandler(param1:ComponentEvent) : void
      {
         if(this.popoverMgr.popoverCaller == this)
         {
            this.popoverMgr.hide();
         }
      }
   }
}
