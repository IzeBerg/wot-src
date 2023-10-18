package net.wg.gui.battle.views.ammunitionPanel
{
   import fl.motion.easing.Circular;
   import flash.display.Sprite;
   import net.wg.infrastructure.base.meta.IPrebattleAmmunitionPanelViewMeta;
   import net.wg.infrastructure.base.meta.impl.PrebattleAmmunitionPanelViewMeta;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class PrebattleAmmunitionPanelView extends PrebattleAmmunitionPanelViewMeta implements IPrebattleAmmunitionPanelViewMeta, IDisplayableComponent
   {
      
      private static const WIDTH:int = 1024;
      
      private static const HEIGHT:int = 280;
      
      private static const HIDE_TWEEN_DURATION:int = 300;
      
      private static const HIDE_OFFSET:int = 15;
       
      
      public var prebattleShadow:Sprite = null;
      
      public var battleLoadingShadow:Sprite = null;
      
      private var _tween:Tween = null;
      
      private var _visible:Boolean = true;
      
      private var _isHidden:Boolean = true;
      
      private var _isInLoading:Boolean = false;
      
      private var _showShadows:Boolean = true;
      
      private var _useAnim:Boolean = false;
      
      private var _originalY:int;
      
      public function PrebattleAmmunitionPanelView()
      {
         super();
         setManageSize(true);
         setSize(WIDTH,HEIGHT);
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this.prebattleShadow = null;
         this.battleLoadingShadow = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.updateVisibility();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.prebattleShadow.mouseEnabled = this.prebattleShadow.mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.battleLoadingShadow.visible = this._showShadows && this._isInLoading;
            this.prebattleShadow.visible = this._showShadows && !this._isInLoading;
            dispatchEvent(new PrbAmmunitionPanelEvent(PrbAmmunitionPanelEvent.STATE_CHANGED));
         }
      }
      
      public function as_hide(param1:Boolean) : void
      {
         this._useAnim = param1;
         if(param1)
         {
            this._tween = new Tween(HIDE_TWEEN_DURATION,this,{
               "alpha":0,
               "y":y + HIDE_OFFSET
            },{
               "ease":Circular.easeOut,
               "onComplete":this.onHideCompleted
            });
         }
         else
         {
            this.onHideCompleted();
         }
      }
      
      public function as_setIsInLoading(param1:Boolean) : void
      {
         this._isInLoading = param1;
         invalidateState();
      }
      
      public function as_show() : void
      {
         alpha = 1;
         y = this._originalY;
         this._isHidden = false;
         this.clearTween();
         this.updateVisibility();
         dispatchEvent(new PrbAmmunitionPanelEvent(PrbAmmunitionPanelEvent.VIEW_SHOWN));
      }
      
      public function as_showShadows(param1:Boolean) : void
      {
         this._showShadows = param1;
         invalidateState();
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         this._visible = param1;
         this.updateVisibility();
      }
      
      public function setYPos(param1:int) : void
      {
         this._originalY = param1;
         this.y = param1;
      }
      
      private function updateVisibility() : void
      {
         visible = this._visible && !this._isHidden;
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function onHideCompleted(param1:Tween = null) : void
      {
         this._isHidden = true;
         dispatchEvent(new PrbAmmunitionPanelEvent(PrbAmmunitionPanelEvent.VIEW_HIDDEN,this._useAnim));
         this.clearTween();
         visible = false;
         onViewIsHiddenS();
      }
      
      public function get isHidden() : Boolean
      {
         return this._isHidden;
      }
      
      public function get isInLoading() : Boolean
      {
         return this._isInLoading;
      }
   }
}
