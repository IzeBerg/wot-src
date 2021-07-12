package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ITextManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class InscriptionItemRenderer extends UIComponentEx
   {
      
      private static const VALUE_TEXT_X_SHIFT:uint = 2;
      
      private static const VALUE_TEXT_SIZE_SHIFT:uint = 4;
       
      
      public var loader:UILoaderAlt;
      
      private var _data:Object;
      
      private var _valueText:TextField;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _textMgr:ITextManager;
      
      public function InscriptionItemRenderer()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._toolTipMgr = App.toolTipMgr;
         this._textMgr = App.textMgr;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.loader.autoSize = true;
         this.loader.maintainAspectRatio = true;
         this.loader.addEventListener(MouseEvent.ROLL_OVER,this.onLoaderRollOverHandler);
         this.loader.addEventListener(MouseEvent.ROLL_OUT,this.onLoaderRollOutHandler);
         this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            if(StringUtils.isNotEmpty(this._data.valueStr))
            {
               this._valueText = this._textMgr.createTextField();
               this._valueText.selectable = false;
               this._valueText.htmlText = this._data.valueStr;
               addChild(this._valueText);
            }
            this.loader.source = this._data.texture;
         }
      }
      
      override protected function onDispose() : void
      {
         this.loader.removeEventListener(MouseEvent.ROLL_OVER,this.onLoaderRollOverHandler);
         this.loader.removeEventListener(MouseEvent.ROLL_OUT,this.onLoaderRollOutHandler);
         this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
         this.loader.dispose();
         this.loader = null;
         if(this._valueText != null)
         {
            removeChild(this._valueText);
            this._valueText = null;
         }
         this._data = null;
         this._toolTipMgr = null;
         this._textMgr = null;
         super.onDispose();
      }
      
      override public function get height() : Number
      {
         return this.loader.originalHeight;
      }
      
      public function set data(param1:Object) : void
      {
         if(this._data != param1)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      private function onLoaderRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM,null,this._data.intCD,-1);
      }
      
      private function onLoaderRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         this.loader.updateLoaderSize();
         if(this._valueText != null)
         {
            this._valueText.x = this.loader.originalWidth + VALUE_TEXT_X_SHIFT | 0;
            this._valueText.y = this.loader.originalHeight - this._valueText.textHeight | 0;
            this._valueText.width = this._valueText.textWidth + VALUE_TEXT_SIZE_SHIFT | 0;
            this._valueText.height = this._valueText.textHeight + VALUE_TEXT_SIZE_SHIFT | 0;
         }
         this.loader.y = this.height - this.loader.height >> 1;
         dispatchEvent(new Event(Event.RESIZE));
      }
   }
}
