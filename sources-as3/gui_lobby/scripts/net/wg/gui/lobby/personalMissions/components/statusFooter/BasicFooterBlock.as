package net.wg.gui.lobby.personalMissions.components.statusFooter
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.personalMissions.data.BasicFooterBlockVO;
   import net.wg.gui.lobby.personalMissions.data.FreeSheetPopoverData;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IClosePopoverCallback;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.IPopoverManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.motion.Tween;
   
   public class BasicFooterBlock extends UIComponentEx implements IClosePopoverCallback, IUpdatableComponent, IPopOverCaller
   {
      
      private static const FADE_DURATION:Number = 250;
       
      
      public var icon:IImage = null;
      
      public var hoverMc:Sprite = null;
      
      public var hitMc:Sprite = null;
      
      public var separator1:Sprite = null;
      
      private var _hoverMcHitArea:Sprite = null;
      
      private var _fadeTweens:Vector.<Tween>;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _popoverMgr:IPopoverManager;
      
      private var _data:BasicFooterBlockVO = null;
      
      public function BasicFooterBlock()
      {
         this._fadeTweens = new Vector.<Tween>(0);
         this._tooltipMgr = App.toolTipMgr;
         this._popoverMgr = App.popoverMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         hitArea = this.hitMc;
         mouseChildren = false;
         useHandCursor = buttonMode = true;
         this.hoverMc.visible = false;
         this._hoverMcHitArea = new Sprite();
         addChild(this._hoverMcHitArea);
         this.hoverMc.hitArea = this._hoverMcHitArea;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Tween = null;
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.dispose();
         this.icon = null;
         this.hoverMc = null;
         this.separator1 = null;
         this._tooltipMgr = null;
         this._popoverMgr = null;
         removeChild(this._hoverMcHitArea);
         this._hoverMcHitArea = null;
         this._data = null;
         this.hitMc = null;
         for each(_loc1_ in this._fadeTweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._fadeTweens.splice(0,this._fadeTweens.length);
         this._fadeTweens = null;
         super.onDispose();
      }
      
      public function getHitArea() : DisplayObject
      {
         return this;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this;
      }
      
      public function onPopoverClose() : void
      {
      }
      
      public function onPopoverOpen() : void
      {
      }
      
      public function showPopover(param1:Boolean = false) : void
      {
         var _loc2_:FreeSheetPopoverData = null;
         this._tooltipMgr.hide();
         if(this._data)
         {
            _loc2_ = new FreeSheetPopoverData(this._data.popoverData);
            _loc2_.showAnimation = param1;
            this._popoverMgr.show(this,this._data.popover,_loc2_,this);
         }
      }
      
      public function update(param1:Object) : void
      {
         this._data = BasicFooterBlockVO(param1);
         invalidateData();
      }
      
      private function playFadeTween(param1:int, param2:Function = null) : void
      {
         var _loc3_:Tween = new Tween(FADE_DURATION,this.hoverMc,{"alpha":param1},{"onComplete":param2});
         _loc3_.fastTransform = false;
         this._fadeTweens.push(_loc3_);
      }
      
      private function fadeOutTweenCallback() : void
      {
         this.hoverMc.visible = false;
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            this.showPopover();
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ToolTipVO = null;
         if(this._fadeTweens.length > 0)
         {
            Tween(this._fadeTweens[this._fadeTweens.length - 1]).paused = true;
         }
         this.hoverMc.alpha = 0;
         this.hoverMc.visible = true;
         this.playFadeTween(1);
         if(this._data && this._data.tooltipData)
         {
            _loc2_ = this._data.tooltipData;
            if(_loc2_.isSpecial)
            {
               this._tooltipMgr.showSpecial.apply(this,[_loc2_.specialAlias,null].concat(_loc2_.specialArgs));
            }
            else
            {
               this._tooltipMgr.showComplex(_loc2_.tooltip);
            }
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.playFadeTween(0,this.fadeOutTweenCallback);
         this._tooltipMgr.hide();
      }
   }
}
