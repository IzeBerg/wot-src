package net.wg.gui.components.carousels
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.DragType;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.carousels.interfaces.ICarouselItemRenderer;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.utils.Padding;
   
   public class CarouselBase extends CoreList implements IDraggable
   {
      
      public static const INIT_CAROUSEL:String = "initCarousel";
      
      private static const SHOW_EMPTY_ITEMS:Boolean = false;
      
      private static const DRAG_ACCELERATOR:Number = 3;
      
      private static const SLIDE_SELF_ACCELERATOR:Number = 7;
      
      private static const SLIDE_TO_POS_ACCELERATOR:Number = 7;
      
      private static const MAX_DRAG_OFFSET:Number = 100;
      
      private static const MAX_DX:Number = 30;
      
      private static const ARROW_LEFT:String = "left";
      
      private static const ARROW_RIGHT:String = "right";
      
      private static const ARROW_WIDTH:int = 21;
       
      
      [Inspectable(defaultValue="3",verbose="1")]
      public var margin:uint = 3;
      
      [Inspectable(defaultValue="60",verbose="1")]
      public var slotImageWidth:uint = 60;
      
      [Inspectable(defaultValue="60",verbose="1")]
      public var slotImageHeight:uint = 60;
      
      [Inspectable(defaultValue="5",verbose="1")]
      public var countVisibleSlots:uint = 5;
      
      [Inspectable(defaultValue="0",verbose="1")]
      public var offsetArrowHeight:int = 0;
      
      [Inspectable(defaultValue="false",verbose="1")]
      public var useShadow:Boolean = false;
      
      public var renderersMask:MovieClip = null;
      
      public var leftArrow:SoundButton = null;
      
      public var rightArrow:SoundButton = null;
      
      public var shadow:MovieClip = null;
      
      private var _allowDrag:Boolean = false;
      
      private var _skippCall:Boolean = false;
      
      private var _currentFirstRenderer:uint = 0;
      
      private var _initSize:Boolean = false;
      
      private var _padding:Padding;
      
      private var _carouselType:String = "horizontal";
      
      private var _countFactor:int = 0;
      
      private var _slidingScheduled:Boolean = false;
      
      private var _arrowSlideScheduled:Boolean = false;
      
      private var _sourceFactor:Number = 0;
      
      private var _slideSelfAcceleratorDynamic:Number = 7;
      
      private var _lastContainerXPos:Number = 0;
      
      private var _lastDx:Number = 0;
      
      private var _dragEnable:Boolean = false;
      
      public function CarouselBase()
      {
         this._padding = new Padding(0);
         super();
         this.visible = false;
      }
      
      override protected function onDispose() : void
      {
         if(this._dragEnable)
         {
            App.cursor.unRegisterDragging(this);
         }
         App.utils.scheduler.cancelTask(this.updateDragPosition);
         this.startOrStopSlidingFn(false,null);
         this.startOrStopInvokingArrowSlide(false);
         if(_dataProvider != null)
         {
            _dataProvider.removeEventListener(Event.CHANGE,handleDataChange);
            _dataProvider = null;
         }
         container.mask = null;
         this.renderersMask = null;
         this.shadow = null;
         this._padding = null;
         this.leftArrow.removeEventListener(ButtonEvent.PRESS,this.onArrowPressHandler);
         this.rightArrow.removeEventListener(ButtonEvent.PRESS,this.onArrowPressHandler);
         this.leftArrow.removeEventListener(ButtonEvent.CLICK,this.onArrowReleaseOutsideHandler);
         this.rightArrow.removeEventListener(ButtonEvent.CLICK,this.onArrowReleaseOutsideHandler);
         this.leftArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onArrowReleaseOutsideHandler);
         this.rightArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onArrowReleaseOutsideHandler);
         this.leftArrow.dispose();
         this.leftArrow = null;
         this.rightArrow.dispose();
         this.rightArrow = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!_usingExternalRenderers && isInvalid(InvalidationType.SIZE) && this.useShadow)
         {
            this.setChildIndex(this.shadow,this.numChildren - 1);
         }
         if(isInvalid(INIT_CAROUSEL) && dataProvider != null && dataProvider.length > 0)
         {
            this.drawRenderers(dataProvider.length);
            this.drawLayout();
            this.refreshData();
            App.tutorialMgr.dispatchEventForCustomComponent(this);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.leftArrow.x = 0;
         this.leftArrow.soundEnabled = false;
         this.leftArrow.width = ARROW_WIDTH;
         this.rightArrow.soundEnabled = false;
         this.rightArrow.width = ARROW_WIDTH;
         this.shadow.visible = false;
         this.shadow.mouseEnabled = false;
         this.shadow.tabEnabled = this.shadow.tabChildren = this.shadow.mouseChildren = this.shadow.mouseEnabled = false;
         this.leftArrow.addEventListener(ButtonEvent.PRESS,this.onArrowPressHandler);
         this.rightArrow.addEventListener(ButtonEvent.PRESS,this.onArrowPressHandler);
         this.leftArrow.addEventListener(ButtonEvent.CLICK,this.onArrowReleaseOutsideHandler);
         this.rightArrow.addEventListener(ButtonEvent.CLICK,this.onArrowReleaseOutsideHandler);
         this.leftArrow.addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onArrowReleaseOutsideHandler);
         this.rightArrow.addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onArrowReleaseOutsideHandler);
      }
      
      override protected function drawRenderers(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:IListItemRenderer = null;
         var _loc5_:DisplayObject = null;
         if(_itemRenderer == null)
         {
            return;
         }
         _loc2_ = _renderers.length;
         while(_loc2_ < param1)
         {
            _loc4_ = createRenderer(_loc2_);
            if(_loc4_ == null)
            {
               break;
            }
            this.tryToDisableHandCursorForRenderer(_loc4_);
            _renderers.push(_loc4_);
            container.addChild(DisplayObject(_loc4_));
            _loc2_++;
         }
         _loc3_ = _renderers.length;
         _loc2_ = _loc3_ - 1;
         while(_loc2_ >= param1)
         {
            _loc4_ = getRendererAt(_loc2_);
            if(_loc4_ != null)
            {
               cleanUpRenderer(_loc4_);
               _loc5_ = _loc4_ as DisplayObject;
               App.utils.asserter.assertNotNull(_loc5_,"displayObject" + Errors.CANT_NULL);
               if(container.contains(_loc5_))
               {
                  container.removeChild(_loc5_);
               }
            }
            _renderers.splice(_loc2_,1);
            _loc2_--;
         }
         var _loc6_:Boolean = _renderers.length > this.countVisibleSlots;
         if(this._dragEnable != _loc6_)
         {
            if(_loc6_)
            {
               App.cursor.registerDragging(this,Cursors.MOVE);
            }
            else
            {
               App.cursor.unRegisterDragging(this);
            }
            this._dragEnable = _loc6_;
         }
      }
      
      override protected function refreshData() : void
      {
         _dataProvider.requestItemRange(0,_dataProvider.length,this.populateData);
      }
      
      override protected function drawLayout() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:IListItemRenderer = null;
         if(_renderers)
         {
            _loc1_ = _renderers.length;
            _loc2_ = this._padding.left + this._padding.right;
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc5_ = getRendererAt(_loc4_);
               this.tryToDisableHandCursorForRenderer(_loc5_);
               this.updateRenderPosition(_loc5_,_loc4_,_loc3_,_loc2_);
               _loc3_ = _loc5_.x;
               _loc4_++;
            }
            if(!this._initSize)
            {
               this.initPosition();
            }
            else
            {
               this.updateContainerPosition();
               if(this.useShadow)
               {
                  this.shadow.visible = this.leftArrow.visible;
               }
            }
         }
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         return dataProvider.length;
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function getHitArea() : InteractiveObject
      {
         return container;
      }
      
      public function onDragging(param1:Number, param2:Number) : void
      {
         this.renderersMouseEnabled(false);
      }
      
      public function onEndDrag() : void
      {
         var _loc1_:Object = null;
         if(this._allowDrag)
         {
            this._slideSelfAcceleratorDynamic = SLIDE_SELF_ACCELERATOR;
            if(!this._slidingScheduled)
            {
               _loc1_ = {
                  "scopeDefPosition":this.getDefContainerPos(),
                  "allowDragDistance":this.getScopeWidth() - this.renderersMask.width
               };
               this.startOrStopSlidingFn(true,_loc1_);
            }
         }
         else
         {
            this.renderersMouseEnabled(true);
         }
         App.utils.scheduler.cancelTask(this.updateDragPosition);
      }
      
      public function onStartDrag() : void
      {
         var _loc1_:Object = null;
         if(this._allowDrag)
         {
            this.startOrStopSlidingFn(false,null);
            _loc1_ = {
               "scopeStartX":container.x,
               "startMouseX":mouseX,
               "allowDragDistance":this.getScopeWidth() - this.renderersMask.width,
               "scopeDefPosition":this.getDefContainerPos()
            };
            this._lastContainerXPos = container.x;
            this.startOrStopInvokingArrowSlide(false);
            App.utils.scheduler.scheduleTask(this.updateDragPosition,30,this,_loc1_);
         }
      }
      
      protected function getScopeWidth() : Number
      {
         var _loc1_:Number = 0;
         if(_renderers)
         {
            _loc1_ = _renderers.length * this.getSlotWidth() + this.margin;
            _loc1_ -= 3;
         }
         return _loc1_;
      }
      
      protected function populateData(param1:Array) : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:uint = 0;
         var _loc7_:ListData = null;
         var _loc2_:uint = param1.length;
         var _loc3_:uint = _renderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = getRendererAt(_loc4_);
            _loc6_ = _loc4_;
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
            _loc5_.enabled = _loc4_ < _loc2_;
            _loc5_.setListData(_loc7_);
            _loc5_.setData(param1[_loc4_]);
            _loc5_.validateNow();
            if(!SHOW_EMPTY_ITEMS)
            {
               UIComponent(_loc5_).visible = param1[_loc4_] != null;
            }
            _loc4_++;
         }
      }
      
      protected function updateRenderPosition(param1:IListItemRenderer, param2:uint, param3:int, param4:Number) : void
      {
         param1.x = param2 == 0 ? Number(this._padding.left) : Number(param3 + (this.slotImageWidth + param4));
         param1.y = this._padding.top;
      }
      
      protected function updateContainerPosition() : void
      {
         var _loc1_:int = 0;
         if(_renderers.length <= this.countVisibleSlots)
         {
            this.leftArrow.visible = this.rightArrow.visible = false;
            _loc1_ = (this.slotImageWidth + this._padding.left + this._padding.right) * _renderers.length ^ 0;
            container.x = this.renderersMask.x + (this.renderersMask.width >> 1) - (_loc1_ >> 1) ^ 0;
         }
         else
         {
            this.leftArrow.visible = this.rightArrow.visible = true;
         }
         this.updateArrowsState();
      }
      
      protected function initPosition() : void
      {
         this._initSize = true;
         container.x = this.getDefContainerPos();
         this.renderersMask.x = this.leftArrow.x + this.leftArrow.width;
         this.renderersMask.y = 0;
         this.renderersMask.width = this.countVisibleSlots * (this.slotImageWidth + this._padding.left + this._padding.right);
         this.renderersMask.height = this.slotImageHeight + 2;
         this.shadow.x = this.renderersMask.x;
         this.shadow.width = this.renderersMask.width;
         this.shadow.height = this.leftArrow.height;
         container.mask = null;
         container.mask = this.renderersMask;
         this.rightArrow.height = this.leftArrow.height = this.renderersMask.height + this.offsetArrowHeight;
         this.rightArrow.x = container.x + this.renderersMask.width + this.leftArrow.width ^ 0;
         this.rightArrow.y = this.leftArrow.y = this.renderersMask.height - this.leftArrow.height >> 1;
         this.visible = true;
         this.updateContainerPosition();
         this.updateArrowsState();
      }
      
      protected function getSlotWidth() : Number
      {
         return this.slotImageWidth + this._padding.left + this._padding.right;
      }
      
      protected function getDefContainerPos() : Number
      {
         if(this.leftArrow && this.leftArrow.visible)
         {
            return this.leftArrow.x + this.leftArrow.width ^ 0;
         }
         return 0;
      }
      
      protected function updateArrowsState() : void
      {
         var _loc1_:Number = this.calculateRendererTotal(0,0);
         if(_loc1_ <= this.countVisibleSlots)
         {
            this.enableLeftArrow(false);
            this.enableRightArrow(false);
            this._skippCall = false;
            this._allowDrag = false;
         }
         else if(this.currentFirstRenderer == 0)
         {
            this.enableLeftArrow(false);
            this.enableRightArrow(true);
            this._skippCall = false;
            this._allowDrag = true;
         }
         else if(this.currentFirstRenderer >= _loc1_ - this.countVisibleSlots)
         {
            this.enableLeftArrow(true);
            this.enableRightArrow(false);
            this._skippCall = false;
            this._allowDrag = true;
         }
         else
         {
            this.enableLeftArrow(true);
            this.enableRightArrow(true);
            this._allowDrag = true;
         }
      }
      
      protected function enableLeftArrow(param1:Boolean = false) : void
      {
         if(this.leftArrow.enabled != param1)
         {
            this.leftArrow.enabled = param1;
            this.leftArrow.validateNow();
         }
      }
      
      protected function enableRightArrow(param1:Boolean = false) : void
      {
         if(this.rightArrow.enabled != param1)
         {
            this.rightArrow.enabled = param1;
            this.rightArrow.validateNow();
         }
      }
      
      private function tryToDisableHandCursorForRenderer(param1:IListItemRenderer) : void
      {
         var _loc2_:Button = null;
         if(param1 is Button)
         {
            _loc2_ = Button(param1);
            _loc2_.useHandCursor = _loc2_.buttonMode = false;
         }
      }
      
      private function renderersMouseEnabled(param1:Boolean = false) : void
      {
         var _loc2_:int = Boolean(_renderers) ? int(_renderers.length) : int(0);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!(_renderers[_loc3_] is ICarouselItemRenderer))
            {
               return;
            }
            ICarouselItemRenderer(_renderers[_loc3_]).canBeSelected = param1;
            _loc3_++;
         }
      }
      
      private function updateDragPosition(param1:DisplayObject, param2:Object) : void
      {
         var _loc3_:Number = param2.scopeStartX + (param1.mouseX - param2.startMouseX);
         if(_loc3_ > param2.scopeDefPosition + MAX_DRAG_OFFSET)
         {
            _loc3_ = param2.scopeDefPosition + MAX_DRAG_OFFSET;
         }
         else if(_loc3_ < param2.scopeDefPosition - param2.allowDragDistance - MAX_DRAG_OFFSET)
         {
            _loc3_ = param2.scopeDefPosition - param2.allowDragDistance - MAX_DRAG_OFFSET;
         }
         container.x += (_loc3_ - container.x) / DRAG_ACCELERATOR;
         container.x ^= 0;
         this._lastDx = container.x - this._lastContainerXPos;
         this._lastContainerXPos = container.x;
         App.utils.scheduler.scheduleTask(this.updateDragPosition,30,this,param2);
      }
      
      private function startOrStopSlidingFn(param1:Boolean, param2:Object) : void
      {
         if(param1)
         {
            App.utils.scheduler.scheduleTask(this.slidingFn,30,param2);
         }
         else
         {
            App.utils.scheduler.cancelTask(this.slidingFn);
            this.renderersMouseEnabled(true);
            this._lastDx = 0;
         }
         this._slidingScheduled = param1;
      }
      
      private function slidingFn(param1:Object) : void
      {
         this.startOrStopSlidingFn(true,param1);
         var _loc2_:Number = container.x + this._lastDx;
         this._lastDx += -this._lastDx / this._slideSelfAcceleratorDynamic;
         this.currentFirstRenderer = this.getCurrentFirstRendererOnAnim();
         if(_loc2_ > param1.scopeDefPosition)
         {
            container.x += (param1.scopeDefPosition - container.x + this._lastDx) / SLIDE_TO_POS_ACCELERATOR;
            this._slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
            if(container.x - param1.scopeDefPosition + this._lastDx < 1 && Math.abs(this._lastDx) < 1)
            {
               container.x = param1.scopeDefPosition;
               this.startOrStopSlidingFn(false,null);
               this.currentFirstRenderer = 0;
            }
         }
         else if(_loc2_ < param1.scopeDefPosition - param1.allowDragDistance)
         {
            container.x += (param1.scopeDefPosition - param1.allowDragDistance - container.x + this._lastDx) / SLIDE_TO_POS_ACCELERATOR;
            this._slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
            if(Math.abs(param1.scopeDefPosition - param1.allowDragDistance - container.x + this._lastDx) < 1 && Math.abs(this._lastDx) < 1)
            {
               container.x = param1.scopeDefPosition - param1.allowDragDistance;
               this.startOrStopSlidingFn(false,null);
            }
         }
         else
         {
            container.x = _loc2_;
            if(Math.abs(this._lastDx) < 1)
            {
               container.x ^= 0;
               this.startOrStopSlidingFn(false,null);
               this.beginSlideToPos();
            }
         }
      }
      
      private function beginSlideToPos() : void
      {
         var _loc1_:Number = this.getCurrentFirstRendererOnAnim();
         this.slideToRenderer(_loc1_);
      }
      
      private function slideToRenderer(param1:Number) : void
      {
         this.currentFirstRenderer = param1;
         var _loc2_:Number = -param1 * this.getSlotWidth() + this.getDefContainerPos();
         new Tween(300,container,{"x":_loc2_},{
            "paused":false,
            "onComplete":null
         });
      }
      
      private function stopSlideByArrow(param1:String) : void
      {
         var _loc2_:int = 10;
         var _loc3_:Number = -this.currentFirstRenderer * this.getSlotWidth() - (container.x - this.getDefContainerPos());
         var _loc4_:Number = this._padding.left + this._padding.right + _loc2_;
         var _loc5_:Number = this.currentFirstRenderer;
         if(param1 == ARROW_RIGHT && _loc3_ > _loc4_)
         {
            _loc5_ = this.currentFirstRenderer + Math.round(_loc3_ / this.getSlotWidth()) + 1;
         }
         else if(param1 == ARROW_LEFT && _loc3_ < -_loc4_)
         {
            _loc5_ = this.currentFirstRenderer - Math.floor(-_loc3_ / this.getSlotWidth()) - 1;
         }
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         else if(_loc5_ > _renderers.length - this.countVisibleSlots)
         {
            _loc5_ = _renderers.length - this.countVisibleSlots;
         }
         this.currentFirstRenderer = _loc5_;
         this._sourceFactor = 0;
      }
      
      private function startSlideByArrow(param1:String, param2:Boolean) : void
      {
         this.startOrStopSlidingFn(false,null);
         if(!this._skippCall)
         {
            this._skippCall = param2;
            this.currentFirstRenderer = param1 == ARROW_LEFT ? uint(Math.max(0,this.currentFirstRenderer - 1)) : uint(Math.min(_renderers.length - this.countVisibleSlots,this.currentFirstRenderer + 1));
            if(this.currentFirstRenderer == 0 || this.currentFirstRenderer == _renderers.length - this.countVisibleSlots)
            {
               this._sourceFactor = 0;
            }
            else
            {
               this._sourceFactor = param1 == ARROW_LEFT ? Number(1) : Number(-1);
            }
            if(!this._arrowSlideScheduled && container)
            {
               this._slideSelfAcceleratorDynamic = SLIDE_SELF_ACCELERATOR;
               this.startOrStopInvokingArrowSlide(true);
            }
         }
         else
         {
            this._skippCall = param2;
         }
      }
      
      private function arrowSlide() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         this.startOrStopInvokingArrowSlide(true);
         this._lastDx += (MAX_DX * this._sourceFactor - this._lastDx) / SLIDE_SELF_ACCELERATOR;
         if(this._sourceFactor == 0)
         {
            this._slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
            this._lastDx += -this._lastDx / this._slideSelfAcceleratorDynamic;
            _loc1_ = this.getDefContainerPos() - this.currentFirstRenderer * this.getSlotWidth();
            _loc2_ = (_loc1_ - container.x) / SLIDE_SELF_ACCELERATOR + this._lastDx;
            _loc2_ = _loc2_ >= 0 ? Number(Math.min(MAX_DX,_loc2_)) : Number(-Math.min(-_loc2_,MAX_DX));
            container.x += _loc2_;
            if(Math.abs(container.x + this._lastDx - _loc1_) < 1)
            {
               container.x = _loc1_;
               this.startOrStopInvokingArrowSlide(false);
            }
         }
         else
         {
            ++this._countFactor;
            container.x += this._lastDx;
            if(this.getCurrentFirstRendererOnAnim() == 0 && this._sourceFactor == 1)
            {
               this.currentFirstRenderer = 0;
               this._sourceFactor = 0;
            }
            else if(this.getCurrentFirstRendererOnAnim() == _renderers.length - this.countVisibleSlots && this._sourceFactor == -1)
            {
               this.currentFirstRenderer = _renderers.length - this.countVisibleSlots;
               this._sourceFactor = 0;
            }
         }
      }
      
      private function startOrStopInvokingArrowSlide(param1:Boolean) : void
      {
         if(param1)
         {
            App.utils.scheduler.scheduleTask(this.arrowSlide,30);
         }
         else
         {
            App.utils.scheduler.cancelTask(this.arrowSlide);
         }
         this._arrowSlideScheduled = param1;
      }
      
      private function getCurrentFirstRendererOnAnim() : Number
      {
         var _loc1_:Number = -Math.round((container.x - this.getDefContainerPos()) / this.getSlotWidth());
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         else if(_loc1_ > _renderers.length - this.countVisibleSlots)
         {
            _loc1_ = _renderers.length - this.countVisibleSlots;
         }
         return _loc1_;
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         if(_dataProvider == param1)
         {
            return;
         }
         if(_dataProvider != null)
         {
            _dataProvider.removeEventListener(Event.CHANGE,handleDataChange);
         }
         _dataProvider = param1;
         if(_dataProvider == null)
         {
            return;
         }
         _dataProvider.addEventListener(Event.CHANGE,handleDataChange);
      }
      
      [Inspectable(defaultValue="top:0,right:0,bottom:0,left:0",name="padding")]
      public function get padding() : Object
      {
         return this._padding;
      }
      
      public function set padding(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         this._padding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }
      
      [Inspectable(defaultValue="horizontal",type="list",enumeration="horizontal,vertical")]
      public function get carouselType() : String
      {
         return this._carouselType;
      }
      
      public function set carouselType(param1:String) : void
      {
         this._carouselType = param1;
      }
      
      private function get currentFirstRenderer() : uint
      {
         return this._currentFirstRenderer;
      }
      
      private function set currentFirstRenderer(param1:uint) : void
      {
         if(param1 == this._currentFirstRenderer)
         {
            return;
         }
         this._currentFirstRenderer = param1;
         this.updateArrowsState();
      }
      
      override protected function handleMouseWheel(param1:MouseEvent) : void
      {
         if(App.contextMenuMgr.isShown())
         {
            return;
         }
         if(_renderers.length > this.countVisibleSlots)
         {
            this.startSlideByArrow(param1.delta > 0 ? ARROW_LEFT : ARROW_RIGHT,false);
            this.stopSlideByArrow(param1.delta > 0 ? ARROW_LEFT : ARROW_RIGHT);
         }
      }
      
      private function onArrowReleaseOutsideHandler(param1:ButtonEvent) : void
      {
         this.stopSlideByArrow(param1.target == this.leftArrow ? ARROW_LEFT : ARROW_RIGHT);
      }
      
      private function onArrowPressHandler(param1:ButtonEvent) : void
      {
         this.startSlideByArrow(param1.target == this.leftArrow ? ARROW_LEFT : ARROW_RIGHT,false);
      }
   }
}
