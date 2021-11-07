package net.wg.gui.lobby.eventBattleResult.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.eventBattleResult.data.ResultEventRewardVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class MedalRenderer extends UIComponentEx implements IUpdatable
   {
      
      private static const SMALL_FRAME:int = 2;
      
      private static const NORMAL_FRAME:int = 1;
      
      private static const LOADER_SMALL_SCALE:Number = 0.8;
       
      
      public var icon:UILoaderAlt = null;
      
      public var textField:TextField = null;
      
      public var hitMc:Sprite = null;
      
      private var _medalData:ResultEventRewardVO = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _iconW:int = -1;
      
      private var _iconH:int = -1;
      
      private var _isMin:Boolean = false;
      
      public function MedalRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this._iconW = this.icon.originalWidth;
         this._iconH = this.icon.originalHeight;
         if(this.hitMc != null)
         {
            this.icon.mouseEnabled = this.icon.mouseChildren = false;
            hitArea = this.hitMc;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._medalData && isInvalid(InvalidationType.DATA))
         {
            if(this.textField != null)
            {
               this.textField.text = this._medalData.label;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.icon.scaleY = this.icon.scaleX = !!this.getIsMin() ? Number(LOADER_SMALL_SCALE) : Number(1);
            this.icon.x = this._iconW - this.icon.width >> 1;
            this.icon.y = this._iconH - this.icon.height >> 1;
            if(this.hitMc != null)
            {
               this.hitMc.x = this._iconW - this.hitMc.width >> 1;
               this.hitMc.y = this._iconH - this.hitMc.height >> 1;
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.textField = null;
         this.hitMc = null;
         this._tooltipMgr = null;
         this._medalData = null;
         super.onDispose();
      }
      
      public function setMin(param1:Boolean) : void
      {
         if(this._isMin != param1)
         {
            gotoAndStop(!!param1 ? SMALL_FRAME : NORMAL_FRAME);
            if(_baseDisposed)
            {
               return;
            }
            this._isMin = param1;
            invalidateData();
            invalidateSize();
         }
      }
      
      public function update(param1:Object) : void
      {
         this._medalData = ResultEventRewardVO(param1);
         this.icon.source = this._medalData.icon;
         invalidateData();
      }
      
      protected function getIsMin() : Boolean
      {
         return this._isMin;
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateSize();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._medalData == null)
         {
            return;
         }
         if(this._medalData.isTooltipWulf && this._medalData.specialArgs)
         {
            this._tooltipMgr.showWulfTooltip(this._medalData.specialAlias,this._medalData.specialArgs);
         }
         else if(StringUtils.isNotEmpty(this._medalData.tooltip))
         {
            this._tooltipMgr.showComplex(this._medalData.tooltip);
         }
         else
         {
            this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[this._medalData.specialAlias,null].concat(this._medalData.specialArgs));
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
