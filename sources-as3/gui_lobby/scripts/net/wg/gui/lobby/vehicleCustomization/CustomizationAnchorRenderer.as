package net.wg.gui.lobby.vehicleCustomization
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.lobby.vehicleCustomization.controls.CarouselRendererAttachedBase;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotUpdateVO;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationAnchorEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.MouseEventEx;
   
   public class CustomizationAnchorRenderer extends CustomizationEndPointIcon
   {
      
      public static const ON_ALPHA:int = 2;
      
      public static const OFF_ALPHA:int = 1;
      
      private static const HIT_DIMENSIONS:int = 70;
      
      private static const HALF_HIT_DIMENSION:int = HIT_DIMENSIONS >> 1;
      
      public static const HIT_SCALE:int = 1;
      
      public static const HIT_SCALE_MIN:Number = 0.7;
      
      public static const BASE_SCALE:int = 1;
      
      private static const MAX_TWEEN_SCALE:Number = 1.13;
      
      private static const FULL_TWEEN_MS:int = 1000;
      
      private static const FAST_TWEEN_MS:int = 500;
      
      private static const TWEEN_SCALE_START:Number = 0.25;
      
      private static const HIT_AREA_NAME:String = "hitAreaMc";
      
      private static const DRAG_TARGET_INVALID:String = "drugTargetInvalid";
      
      private static const HIT_AREA_ROTATION:Number = 45;
       
      
      public var anchorBorder:MovieClip = null;
      
      public var anchorUnselectedEmpty:MovieClip = null;
      
      public var anchorUnselectedFilled:MovieClip = null;
      
      protected var hitAreaSprite:Sprite = null;
      
      private var _visibleMcs:Vector.<MovieClip> = null;
      
      private var _lastSelected:Boolean = false;
      
      private var _isDragStart:Boolean = false;
      
      private var _isPressed:Boolean = false;
      
      private var _isDragged:Boolean;
      
      private var _tweens:Vector.<Tween>;
      
      public function CustomizationAnchorRenderer()
      {
         this._tweens = new Vector.<Tween>();
         super();
      }
      
      private static function setIdleAlpha(param1:MovieClip) : void
      {
         param1.alpha = getCurrentAlpha();
      }
      
      private static function bothOn(param1:MovieClip) : Tween
      {
         return new Tween(FAST_TWEEN_MS,param1,{"alpha":ON_ALPHA},{"ease":Strong.easeOut});
      }
      
      private static function resetOn(param1:MovieClip) : void
      {
         param1.alpha = ON_ALPHA;
      }
      
      private static function bothIdle(param1:MovieClip) : Tween
      {
         return new Tween(FULL_TWEEN_MS,param1,{"alpha":getCurrentAlpha()},{"ease":Strong.easeOut});
      }
      
      private static function zoomInstallTween(param1:MovieClip) : Tween
      {
         return new Tween(FAST_TWEEN_MS,param1,{
            "scaleX":BASE_SCALE,
            "scaleY":BASE_SCALE
         },{"ease":Strong.easeOut});
      }
      
      private static function zoomInstallReset(param1:MovieClip) : void
      {
         param1.scaleX = TWEEN_SCALE_START;
         param1.scaleY = TWEEN_SCALE_START;
         resetOn(param1);
      }
      
      private static function getCurrentAlpha(param1:Boolean = false) : Number
      {
         var _loc2_:CarouselRendererAttachedBase = App.cursor.getAttachedSprite() as CarouselRendererAttachedBase;
         return Boolean(_loc2_) && !param1 ? Number(ON_ALPHA) : Number(OFF_ALPHA);
      }
      
      private static function isClickLeftMouse(param1:MouseEvent) : Boolean
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         return _loc3_ == MouseEventEx.LEFT_BUTTON;
      }
      
      override public function applyState(param1:int, param2:Boolean = true) : void
      {
         this.resetPreviousState(param2);
         _currentState = param1;
         this.applyNewState(param2);
      }
      
      override public function getSupportedType() : int
      {
         if(slotData != null && slotData.slotId != null)
         {
            return slotData.slotId.slotType;
         }
         return Values.DEFAULT_INT;
      }
      
      override public function onDragEnd() : void
      {
         hitArea = this.hitAreaSprite;
      }
      
      override public function onDragStart() : void
      {
         hitArea = null;
      }
      
      override public function onDragTargetChange(param1:Boolean) : void
      {
         this._isDragStart = param1;
         invalidate(DRAG_TARGET_INVALID);
      }
      
      override public function setSlotData(param1:CustomizationSlotUpdateVO) : void
      {
         if(param1 && slotData != param1)
         {
            super.setSlotData(param1);
            if(!getLocked())
            {
               this.applyToAnchorFunc(setIdleAlpha);
            }
            this.redrawSelected();
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(DRAG_TARGET_INVALID))
         {
            if(getLocked())
            {
               return;
            }
            if(this._isDragStart)
            {
               this.applyToAnchorFunc(setIdleAlpha);
               this.applyToAnchorTweens(bothOn);
            }
            else
            {
               this.applyToAnchorFunc(resetOn);
               this.applyToAnchorTweens(bothIdle);
            }
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._visibleMcs = new Vector.<MovieClip>(0);
         this.hitAreaSprite = this.createHitArea();
         focusable = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         mouseEnabledOnDisabled = true;
         this.anchorBorder.mouseEnabled = this.anchorBorder.mouseChildren = false;
         this.anchorUnselectedEmpty.mouseEnabled = this.anchorUnselectedEmpty.mouseChildren = false;
         this.anchorUnselectedFilled.mouseEnabled = this.anchorUnselectedFilled.mouseChildren = false;
         addEventListener(MouseEvent.MOUSE_OVER,this.onAnchorMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onAnchorMouseOutHandler);
         addEventListener(MouseEvent.MOUSE_UP,this.onAnchorMouseUpHandler);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onAnchorMouseDownHandler);
         addEventListener(CustomizationItemEvent.INSTALL_ITEM,this.onInstallItemHandler);
         addChild(this.hitAreaSprite);
         hitArea = this.hitAreaSprite;
         this.anchorBorder.hitArea = this.hitAreaSprite;
         this.anchorUnselectedEmpty.hitArea = this.hitAreaSprite;
         this.anchorUnselectedFilled.hitArea = this.hitAreaSprite;
         visible = false;
      }
      
      override protected function onInstallItemDropHandler() : void
      {
         this.zoomInstall(true);
      }
      
      override protected function onDispose() : void
      {
         this.hitAreaSprite.graphics.clear();
         this.hitAreaSprite = null;
         removeEventListener(MouseEvent.MOUSE_OVER,this.onAnchorMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onAnchorMouseOutHandler);
         removeEventListener(MouseEvent.MOUSE_UP,this.onAnchorMouseUpHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onAnchorMouseDownHandler);
         removeEventListener(CustomizationItemEvent.INSTALL_ITEM,this.onInstallItemHandler);
         this.anchorBorder = null;
         this.anchorUnselectedEmpty = null;
         this.anchorUnselectedFilled = null;
         this.clearTweens();
         this._tweens = null;
         this._visibleMcs.splice(0,this._visibleMcs.length);
         this._visibleMcs = null;
         super.onDispose();
      }
      
      protected function createHitArea() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = HIT_AREA_NAME;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-HALF_HIT_DIMENSION,-HALF_HIT_DIMENSION,HIT_DIMENSIONS,HIT_DIMENSIONS);
         _loc1_.graphics.endFill();
         _loc1_.rotation = HIT_AREA_ROTATION;
         return _loc1_;
      }
      
      protected function addVisibleMc(param1:MovieClip) : void
      {
         var _loc2_:int = this._visibleMcs.indexOf(param1);
         if(_loc2_ == Values.DEFAULT_INT)
         {
            param1.visible = true;
            this._visibleMcs.push(param1);
         }
      }
      
      protected function removeVisibleMc(param1:MovieClip) : void
      {
         var _loc2_:int = this._visibleMcs.indexOf(param1);
         if(_loc2_ != Values.DEFAULT_INT)
         {
            param1.visible = false;
            this._visibleMcs.splice(this._visibleMcs.indexOf(param1),1);
         }
      }
      
      protected function getTweenMaxScale(param1:MovieClip) : Number
      {
         return MAX_TWEEN_SCALE;
      }
      
      protected function resetPreviousState(param1:Boolean = true) : void
      {
         switch(_currentState)
         {
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_UNSELECTED_EMPTY:
               this.removeVisibleMc(this.anchorUnselectedEmpty);
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_SELECTED_EMPTY:
               this.removeVisibleMc(this.anchorUnselectedEmpty);
               this.removeVisibleMc(this.anchorBorder);
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_UNSELECTED_FILLED:
               this.removeVisibleMc(this.anchorUnselectedFilled);
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_SELECTED_FILLED:
               this.removeVisibleMc(this.anchorUnselectedFilled);
         }
         this.hitAreaSprite.scaleX = this.hitAreaSprite.scaleY = HIT_SCALE;
      }
      
      protected function applyNewState(param1:Boolean = true) : void
      {
         switch(_currentState)
         {
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_UNSELECTED_EMPTY:
               this.addVisibleMc(this.anchorUnselectedEmpty);
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_SELECTED_EMPTY:
               this.addVisibleMc(this.anchorUnselectedEmpty);
               this.addVisibleMc(this.anchorBorder);
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_UNSELECTED_FILLED:
               this.addVisibleMc(this.anchorUnselectedFilled);
               this.hitAreaSprite.scaleX = this.hitAreaSprite.scaleY = HIT_SCALE_MIN;
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_SELECTED_FILLED:
               this.addVisibleMc(this.anchorUnselectedFilled);
         }
      }
      
      private function zoomOverBase(param1:MovieClip) : Tween
      {
         return new Tween(FAST_TWEEN_MS,param1,{
            "alpha":ON_ALPHA,
            "scaleX":this.getTweenMaxScale(param1),
            "scaleY":this.getTweenMaxScale(param1)
         },{"ease":Strong.easeOut});
      }
      
      private function zoomOutBase(param1:MovieClip) : Tween
      {
         return new Tween(FULL_TWEEN_MS,param1,{
            "alpha":getCurrentAlpha(getLocked()),
            "scaleX":BASE_SCALE,
            "scaleY":BASE_SCALE
         },{"ease":Strong.easeOut});
      }
      
      private function zoomSelectedBase(param1:MovieClip) : Tween
      {
         return new Tween(FAST_TWEEN_MS,param1,{
            "scaleX":this.getTweenMaxScale(param1),
            "scaleY":MAX_TWEEN_SCALE,
            "alpha":ON_ALPHA
         },{"ease":Strong.easeOut});
      }
      
      private function zoomInstallDragAndDrop(param1:MovieClip) : Tween
      {
         return new Tween(FAST_TWEEN_MS,param1,{
            "scaleX":this.getTweenMaxScale(param1),
            "scaleY":MAX_TWEEN_SCALE
         },{"ease":Strong.easeOut});
      }
      
      private function zoomInstall(param1:Boolean) : void
      {
         this.applyToAnchorFunc(zoomInstallReset);
         var _loc2_:Function = !!param1 ? this.zoomInstallDragAndDrop : zoomInstallTween;
         this.applyToAnchorTweens(_loc2_);
      }
      
      private function applyToAnchorTweens(param1:Function) : void
      {
         var _loc2_:MovieClip = null;
         this.clearTweens();
         for each(_loc2_ in this._visibleMcs)
         {
            this._tweens.push(param1(_loc2_));
         }
      }
      
      private function applyToAnchorFunc(param1:Function) : void
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in this._visibleMcs)
         {
            param1(_loc2_);
         }
      }
      
      private function updateSelectedAnchors(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = isAnchorFilled();
         if(_loc3_)
         {
            if(param1)
            {
               _loc2_ = CUSTOMIZATION_ALIASES.ANCHOR_STATE_SELECTED_FILLED;
            }
            else
            {
               _loc2_ = CUSTOMIZATION_ALIASES.ANCHOR_STATE_UNSELECTED_FILLED;
            }
         }
         else if(param1)
         {
            _loc2_ = CUSTOMIZATION_ALIASES.ANCHOR_STATE_SELECTED_EMPTY;
         }
         else
         {
            _loc2_ = CUSTOMIZATION_ALIASES.ANCHOR_STATE_UNSELECTED_EMPTY;
         }
         if(_loc2_ != _currentState)
         {
            this.applyState(_loc2_);
         }
      }
      
      private function clearTweens() : void
      {
         var _loc1_:Tween = null;
         if(this._tweens)
         {
            for each(_loc1_ in this._tweens)
            {
               _loc1_.paused = true;
               _loc1_.dispose();
            }
            this._tweens.splice(0,this._tweens.length);
         }
      }
      
      private function resetAnchorStyleAfterSelect(param1:Boolean = false) : void
      {
         this.clearTweens();
         this.applyToAnchorTweens(!!param1 ? this.zoomSelectedBase : this.zoomOutBase);
      }
      
      private function redrawSelected() : void
      {
         var _loc1_:int = _currentState;
         if(this._lastSelected && (_currentState == CUSTOMIZATION_ALIASES.ANCHOR_STATE_SELECTED_EMPTY || _loc1_ == CUSTOMIZATION_ALIASES.ANCHOR_STATE_SELECTED_EMPTY) || !this._lastSelected && (_loc1_ == CUSTOMIZATION_ALIASES.ANCHOR_STATE_UNSELECTED_FILLED || _loc1_ == CUSTOMIZATION_ALIASES.ANCHOR_STATE_SELECTED_FILLED))
         {
            this.resetAnchorStyleAfterSelect(this._lastSelected);
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(this._lastSelected != param1)
         {
            this._lastSelected = param1;
         }
         this.redrawSelected();
         super.selected = this._lastSelected;
      }
      
      public function get currentState() : int
      {
         return _currentState;
      }
      
      protected function onAnchorMouseOver(param1:MouseEvent) : void
      {
         dispatchEvent(new CustomizationAnchorEvent(CustomizationAnchorEvent.OVER_ANCHOR,this));
         this.applyToAnchorTweens(this.zoomOverBase);
      }
      
      protected function onAnchorMouseOut(param1:MouseEvent) : void
      {
         dispatchEvent(new CustomizationAnchorEvent(CustomizationAnchorEvent.OUT_ANCHOR,this));
         this.applyToAnchorTweens(this.zoomOutBase);
         if(this._isPressed)
         {
            this._isDragged = true;
            dispatchEvent(new CustomizationAnchorEvent(CustomizationAnchorEvent.DRAG_ANCHOR,this));
         }
      }
      
      protected function onAnchorMouseClick(param1:MouseEvent) : void
      {
         if(getLocked())
         {
            return;
         }
         dispatchEvent(new CustomizationAnchorEvent(CustomizationAnchorEvent.SELECT_ANCHOR,this));
         var _loc2_:CarouselRendererAttachedBase = App.cursor.getAttachedSprite() as CarouselRendererAttachedBase;
         if(_loc2_ != null)
         {
            installItem(CustomizationCarouselRendererVO(_loc2_.data));
         }
      }
      
      private function onAnchorMouseOverHandler(param1:MouseEvent) : void
      {
         this.onAnchorMouseOver(param1);
      }
      
      private function onAnchorMouseOutHandler(param1:MouseEvent) : void
      {
         this.onAnchorMouseOut(param1);
      }
      
      private function onAnchorMouseUpHandler(param1:MouseEvent) : void
      {
         if(!this._isDragged && this._isPressed && isClickLeftMouse(param1))
         {
            this.onAnchorMouseClick(param1);
         }
      }
      
      private function onInstallItemHandler(param1:CustomizationItemEvent) : void
      {
         this.zoomInstall(false);
      }
      
      private function onAnchorMouseDownHandler(param1:MouseEvent) : void
      {
         if(!isClickLeftMouse(param1))
         {
            return;
         }
         this._isPressed = true;
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         if(!isClickLeftMouse(param1))
         {
            return;
         }
         this._isPressed = this._isDragged = false;
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
      }
   }
}
