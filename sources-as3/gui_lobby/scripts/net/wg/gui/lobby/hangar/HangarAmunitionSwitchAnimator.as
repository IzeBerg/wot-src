package net.wg.gui.lobby.hangar
{
   import fl.transitions.easing.Regular;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class HangarAmunitionSwitchAnimator extends EventDispatcher implements IDisposable
   {
      
      private static const ANIM_DURATION:int = 300;
      
      private static const CAROUSEL_CONTAINER:String = "carouselContainer";
      
      private static const CAROUSEL_CONTAINER_OFFSET:int = -82;
      
      public static const MAKE_HANGAR_VISIBILE:String = "makeHangarVisibile";
      
      public static const PLAY_ANIM_SHOW_HANGAR:String = "showHangar";
      
      public static const AMMUNITION_VIEW_SHOW_ANIM_START:String = "ammunitionViewShowAnimStart";
      
      public static const AMMUNITION_VIEW_SHOW_ANIM_COMPLETE:String = "ammunitionViewShowAnimComplete";
      
      public static const AMMUNITION_VIEW_HIDE_ANIM_COMPLETE:String = "ammunitionViewHideAnimComplete";
      
      private static const AMMUNITION_PANEL_OFFSET_Y:int = 7;
      
      private static const STAGE_MOUSE_ENABLED_TIMEOUT:int = 1000;
       
      
      private var _hangar:Hangar = null;
      
      private var _alphaAnimatedParts:Vector.<DisplayObject> = null;
      
      private var _moveDownAnimatedParts:Vector.<DisplayObject> = null;
      
      private var _ammunitionPanel:DisplayObject = null;
      
      private var _tween:Tween;
      
      private var _hideCarouselContainerTween:Tween;
      
      private var _percents:Number = 0;
      
      private var _isShow:Boolean = false;
      
      private var _animProps:Object;
      
      private var _appStage:Stage;
      
      private var _viewHeight:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function HangarAmunitionSwitchAnimator(param1:Hangar, param2:Vector.<DisplayObject>, param3:Vector.<DisplayObject>, param4:DisplayObject, param5:int)
      {
         this._animProps = {};
         this._appStage = App.stage;
         super();
         this._hangar = param1;
         this._tween = new Tween(ANIM_DURATION,this,{"percents":1},{"ease":Regular.easeOut});
         this._tween.onComplete = this.onAnimationComplete;
         this._tween.paused = true;
         this._hideCarouselContainerTween = new Tween(ANIM_DURATION,this._hangar.carouselContainer,{"alpha":0},{"ease":Regular.easeOut});
         this._viewHeight = param5;
         this._hideCarouselContainerTween.fastTransform = false;
         this._hideCarouselContainerTween.paused = true;
         this._alphaAnimatedParts = this.validateItems(param2);
         this._moveDownAnimatedParts = this.validateItems(param3);
         this._ammunitionPanel = param4;
         this.updateDefaultPositions();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         App.utils.scheduler.cancelTask(this.stageMouseChildrenSetEnabled);
         this.stageMouseChildrenSetEnabled();
         this._appStage.removeEventListener(HangarAmunitionSwitchAnimator.AMMUNITION_VIEW_SHOW_ANIM_START,this.onAmmunitionViewLoadedHandler);
         this._appStage.removeEventListener(HangarAmunitionSwitchAnimator.MAKE_HANGAR_VISIBILE,this.onMakeHangarVisible);
         this._appStage.removeEventListener(HangarAmunitionSwitchAnimator.PLAY_ANIM_SHOW_HANGAR,this.onShowHangarHandler);
         this._appStage.removeEventListener(HangarAmunitionSwitchAnimator.AMMUNITION_VIEW_SHOW_ANIM_COMPLETE,this.onAmmunitionSetupViewAnimComplete);
         removeEventListener(Event.COMPLETE,this.onHangarPreparationToSwitchComplete);
         removeEventListener(Event.COMPLETE,this.onAnimSwitchFromAmmunitionComplete);
         this._tween.dispose();
         this._tween = null;
         this._hideCarouselContainerTween.dispose();
         this._hideCarouselContainerTween = null;
         this._hangar = null;
         this._alphaAnimatedParts.splice(0,this._alphaAnimatedParts.length);
         this._alphaAnimatedParts = null;
         this._moveDownAnimatedParts.splice(0,this._moveDownAnimatedParts.length);
         this._moveDownAnimatedParts = null;
         this._ammunitionPanel = null;
         this._animProps = null;
         this._appStage = null;
      }
      
      public function playHideAnimation() : void
      {
         App.graphicsOptimizationMgr.unregister(this._hangar.carousel);
         this.percents = 0;
         this._tween.reset();
         this._tween.paused = false;
         this._isShow = false;
         addEventListener(Event.COMPLETE,this.onHangarPreparationToSwitchComplete);
         this._hangar.mouseEnabled = false;
         this._hangar.ammunitionPanelInject.onHangarSwitchAnimCompleteS(false);
         App.utils.scheduler.scheduleTask(this.stageMouseChildrenSetEnabled,STAGE_MOUSE_ENABLED_TIMEOUT);
         this._appStage.mouseChildren = false;
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._viewHeight = param2;
         AnimPositionProps(this._animProps.ammunitionPanelInject).topY = this._ammunitionPanel.y;
         AnimPositionProps(this._animProps.ammunitionPanelInject).bottomY = this.calculateAmmunitionPanelBottomY();
         AnimPositionProps(this._animProps.carouselContainer).bottomY = this._hangar.carousel.actualHeight + CAROUSEL_CONTAINER_OFFSET;
      }
      
      private function stageMouseChildrenSetEnabled() : void
      {
         this._appStage.mouseChildren = true;
      }
      
      private function calculateAmmunitionPanelBottomY() : int
      {
         return this._ammunitionPanel.y + (this._viewHeight - this._ammunitionPanel.y - this._ammunitionPanel.height + AMMUNITION_PANEL_OFFSET_Y);
      }
      
      private function hideBottomItemsBeforDestroy() : void
      {
         this._hideCarouselContainerTween.reset();
         this._hideCarouselContainerTween.paused = false;
      }
      
      private function playShowAnimation() : void
      {
         this.percents = 0;
         this._isShow = true;
         this.updatePosition();
         this._tween.reset();
         this._tween.paused = false;
         this.updateAlpha();
      }
      
      private function onAnimationComplete() : void
      {
         if(this._isShow)
         {
            this._hangar.mouseChildren = true;
            this._hangar.ammunitionPanelInject.onHangarSwitchAnimCompleteS(true);
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function validateItems(param1:Vector.<DisplayObject>) : Vector.<DisplayObject>
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         for each(_loc3_ in param1)
         {
            if(_loc3_)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function updateDefaultPositions() : void
      {
         var _loc1_:String = null;
         var _loc2_:DisplayObject = null;
         var _loc3_:Rectangle = null;
         var _loc4_:int = 0;
         for each(_loc2_ in this._moveDownAnimatedParts)
         {
            _loc1_ = _loc2_.name;
            _loc3_ = _loc2_.getBounds(this._appStage);
            _loc4_ = _loc2_.y;
            if(_loc1_ == CAROUSEL_CONTAINER)
            {
               this._animProps[_loc1_] = new AnimPositionProps(0,this._hangar.carousel.actualHeight + CAROUSEL_CONTAINER_OFFSET);
            }
            else
            {
               this._animProps[_loc1_] = new AnimPositionProps(_loc4_,_loc4_ + (this._appStage.stageHeight - _loc3_.y));
            }
         }
         this._animProps[this._ammunitionPanel.name] = new AnimPositionProps(this._ammunitionPanel.y,this.calculateAmmunitionPanelBottomY());
         this._moveDownAnimatedParts.push(this._ammunitionPanel);
      }
      
      private function updateAlpha() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:Number = 0;
         if(this._isShow)
         {
            _loc1_ = this.percents;
         }
         else
         {
            _loc1_ = 1 - this.percents;
         }
         for each(_loc2_ in this._alphaAnimatedParts)
         {
            _loc2_.alpha = _loc1_;
         }
      }
      
      private function updatePosition() : void
      {
         var _loc2_:AnimPositionProps = null;
         var _loc3_:DisplayObject = null;
         var _loc1_:int = 0;
         for each(_loc3_ in this._moveDownAnimatedParts)
         {
            _loc2_ = AnimPositionProps(this._animProps[_loc3_.name]);
            if(this._isShow)
            {
               _loc1_ = _loc2_.topY + (1 - this._percents) * (_loc2_.bottomY - _loc2_.topY);
            }
            else
            {
               _loc1_ = _loc2_.topY + this._percents * (_loc2_.bottomY - _loc2_.topY);
            }
            _loc3_.y = _loc1_;
         }
      }
      
      public function get percents() : Number
      {
         return this._percents;
      }
      
      public function set percents(param1:Number) : void
      {
         this._percents = param1;
         this.updateAlpha();
         this.updatePosition();
      }
      
      private function onMakeHangarVisible(param1:Event) : void
      {
         this._hangar.setAnimatorVisibility(true);
         this._ammunitionPanel.y = this._animProps["ammunitionPanelInject"].bottomY;
      }
      
      private function onHangarPreparationToSwitchComplete(param1:Event) : void
      {
         this.hideBottomItemsBeforDestroy();
         this._appStage.addEventListener(HangarAmunitionSwitchAnimator.AMMUNITION_VIEW_SHOW_ANIM_START,this.onAmmunitionViewLoadedHandler);
         this._appStage.addEventListener(HangarAmunitionSwitchAnimator.MAKE_HANGAR_VISIBILE,this.onMakeHangarVisible);
         this._appStage.addEventListener(HangarAmunitionSwitchAnimator.AMMUNITION_VIEW_SHOW_ANIM_COMPLETE,this.onAmmunitionSetupViewAnimComplete);
         this._appStage.addEventListener(HangarAmunitionSwitchAnimator.PLAY_ANIM_SHOW_HANGAR,this.onShowHangarHandler);
      }
      
      private function onAmmunitionSetupViewAnimComplete(param1:Event) : void
      {
         this._appStage.removeEventListener(HangarAmunitionSwitchAnimator.AMMUNITION_VIEW_SHOW_ANIM_COMPLETE,this.onAmmunitionSetupViewAnimComplete);
         App.utils.scheduler.cancelTask(this.stageMouseChildrenSetEnabled);
         this.stageMouseChildrenSetEnabled();
      }
      
      private function onAmmunitionViewLoadedHandler(param1:Event) : void
      {
         this._hangar.setAnimatorVisibility(false);
      }
      
      private function onShowHangarHandler(param1:Event) : void
      {
         removeEventListener(Event.COMPLETE,this.onHangarPreparationToSwitchComplete);
         addEventListener(Event.COMPLETE,this.onAnimSwitchFromAmmunitionComplete);
         this.playShowAnimation();
         if(this._hangar.carouselContainer)
         {
            this._hangar.carouselContainer.alpha = 1;
         }
      }
      
      private function onAnimSwitchFromAmmunitionComplete(param1:Event) : void
      {
         removeEventListener(Event.COMPLETE,this.onAnimSwitchFromAmmunitionComplete);
         App.graphicsOptimizationMgr.register(this._hangar.carousel);
         this._appStage.dispatchEvent(new Event(AMMUNITION_VIEW_HIDE_ANIM_COMPLETE));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}

class AnimPositionProps
{
    
   
   public var topY:int = 0;
   
   public var bottomY:int = 0;
   
   function AnimPositionProps(param1:int, param2:int)
   {
      super();
      this.topY = param1;
      this.bottomY = param2;
   }
}
