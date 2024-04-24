package net.wg.gui.lobby.quests.components.renderers
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.AwardsItemVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.components.BoosterSlot;
   import net.wg.gui.lobby.quests.components.interfaces.ITaskAwardItemRenderer;
   import net.wg.gui.lobby.quests.events.AwardWindowEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class TaskAwardItemRenderer extends UIComponentEx implements ITaskAwardItemRenderer
   {
      
      private static const DEFAULT_ICON_PADDING:int = 9;
      
      private static const INVALIDATE_IMAGE_SIZE:String = "invalidateImageSize";
      
      private static const INVALIDATE_TEXT:String = "invalidateText";
       
      
      public var valueTF:TextField = null;
      
      public var itemLoader:UILoaderAlt = null;
      
      private var _boosterSlot:BoosterSlot = null;
      
      private var _targetForReposition:MovieClip = null;
      
      private var _tooltip:String = "";
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _textValue:String;
      
      private var _isNotInitialized:Boolean;
      
      public function TaskAwardItemRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.itemLoader.x = this.itemLoader.y = 0;
         this.itemLoader.autoSize = false;
         this.valueTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this._targetForReposition.removeEventListener(MouseEvent.MOUSE_OVER,this.onTargetForRepositionMouseOverHandler);
         this._targetForReposition.removeEventListener(MouseEvent.MOUSE_OUT,this.onTargetForRepositionMouseOutHandler);
         if(this._boosterSlot != null)
         {
            this._boosterSlot.iconLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onItemLoadCompleteHandler);
            removeChild(this._boosterSlot);
            this._boosterSlot.dispose();
            this._boosterSlot = null;
         }
         else
         {
            this.itemLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onItemLoadCompleteHandler);
         }
         this.valueTF = null;
         this.itemLoader.dispose();
         this.itemLoader = null;
         this._targetForReposition = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function setData(param1:AwardsItemVO) : void
      {
         this._textValue = param1.value;
         if(param1.boosterVO == null)
         {
            this._targetForReposition = this.itemLoader;
            this.itemLoader.source = param1.itemSource;
            this.itemLoader.addEventListener(UILoaderEvent.COMPLETE,this.onItemLoadCompleteHandler);
         }
         else
         {
            this._boosterSlot = App.utils.classFactory.getComponent(param1.boosterVO.slotLinkage,BoosterSlot);
            this._targetForReposition = this._boosterSlot;
            this._boosterSlot.iconLoader.addEventListener(UILoaderEvent.COMPLETE,this.onItemLoadCompleteHandler);
            this._boosterSlot.icon = param1.boosterVO.icon;
            this._boosterSlot.update(param1.boosterVO);
            this._boosterSlot.enabled = false;
            addChild(this._boosterSlot);
         }
         this._tooltip = param1.tooltip;
         this._targetForReposition.addEventListener(MouseEvent.MOUSE_OVER,this.onTargetForRepositionMouseOverHandler);
         this._targetForReposition.addEventListener(MouseEvent.MOUSE_OUT,this.onTargetForRepositionMouseOutHandler);
         param1.dispose();
         invalidate(INVALIDATE_TEXT);
      }
      
      private function onItemLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         param1.target.removeEventListener(UILoaderEvent.COMPLETE,this.onItemLoadCompleteHandler);
         this._isNotInitialized = true;
         invalidate(INVALIDATE_IMAGE_SIZE);
      }
      
      private function repositionTarget() : void
      {
         var _loc1_:Number = this._targetForReposition is BoosterSlot ? Number(this._boosterSlot.hitMc.height) : Number(this.itemLoader.height);
         this._targetForReposition.x = this.valueTF.textWidth + DEFAULT_ICON_PADDING ^ 0;
         this._targetForReposition.y = Boolean(this.valueTF.text) ? Number(Math.round((this.valueTF.height - _loc1_) / 2)) : Number(0);
         dispatchEvent(new AwardWindowEvent(AwardWindowEvent.AWARD_RENDERER_READY));
      }
      
      private function onTargetForRepositionMouseOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._tooltip))
         {
            if(this._boosterSlot != null)
            {
               this._toolTipMgr.showSpecial(this._tooltip,null,this._boosterSlot.boosterId);
            }
            else
            {
               this._toolTipMgr.showComplex(this._tooltip);
            }
         }
      }
      
      private function onTargetForRepositionMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_TEXT))
         {
            this.valueTF.htmlText = this._textValue;
         }
         if(this._isNotInitialized && isInvalid(INVALIDATE_IMAGE_SIZE))
         {
            this._isNotInitialized = false;
            this.itemLoader.updateLoaderSize();
            this.repositionTarget();
         }
      }
   }
}
