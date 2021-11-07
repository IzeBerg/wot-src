package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TradeIco extends Sprite implements IDisposable
   {
      
      private static const HIT_MIN_WIDTH:Number = 15;
      
      private static const TEXT_FIELD_POS_X:Number = 15;
      
      private static const TEXT_FIELD_POS_Y:Number = -10;
      
      private static const SHADOW_BLUR:Number = 12;
      
      private static const TF_V_SPACE:Number = 4 + SHADOW_BLUR;
      
      private static const TF_H_SPACE:Number = 3 + SHADOW_BLUR;
      
      private static const FONT_COLOR:Number = 16754521;
      
      private static const FONT_SIZE:Number = 14;
      
      private static const FONT_FAMILY:String = "$FieldFont";
       
      
      public var hit:Sprite = null;
      
      private var _textField:TextField = null;
      
      private var _vehicleId:Number = -1;
      
      private var _textFormat:TextFormat = null;
      
      public function TradeIco()
      {
         super();
         this.mouseEnabled = true;
         this.hitArea = this.hit;
      }
      
      public final function dispose() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler,false);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler,false);
         this.removeEventListener(MouseEvent.CLICK,this.onHitClickHandler,false);
         this.clearText();
         this.hit = null;
         if(this._textFormat)
         {
            this._textFormat = null;
         }
      }
      
      public function setData(param1:Number, param2:String) : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler,false);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler,false);
         this.removeEventListener(MouseEvent.CLICK,this.onHitClickHandler,false);
         this._vehicleId = param1;
         if(param1 >= 0)
         {
            this.addEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler,false);
            this.addEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler,false);
            this.addEventListener(MouseEvent.CLICK,this.onHitClickHandler,false);
         }
         if(param2 != Values.EMPTY_STR)
         {
            if(this._textField == null)
            {
               this._textField = App.textMgr.createTextField();
               if(!this._textFormat)
               {
                  this._textFormat = this._textField.getTextFormat();
                  this._textFormat.size = FONT_SIZE;
                  this._textFormat.font = FONT_FAMILY;
                  this._textFormat.color = FONT_COLOR;
               }
               this._textField.mouseEnabled = false;
               this._textField.x = TEXT_FIELD_POS_X;
               this._textField.y = TEXT_FIELD_POS_Y;
               App.utils.commons.setShadowFilterWithParams(this._textField,0,90,16723968,1,SHADOW_BLUR,SHADOW_BLUR,2,2);
               this.addChildAt(this._textField,this.getChildIndex(this.hit));
            }
            this._textField.htmlText = param2;
            this._textField.textColor = FONT_COLOR;
            this._textField.setTextFormat(this._textFormat);
            this._textField.width = this._textField.textWidth + TF_H_SPACE;
            this._textField.height = this._textField.textHeight + TF_V_SPACE;
            this.hit.width = (HIT_MIN_WIDTH >> 1) + this._textField.x + this._textField.width - SHADOW_BLUR;
         }
         else
         {
            this.clearText();
         }
      }
      
      private function clearText() : void
      {
         if(this._textField)
         {
            this.removeChild(this._textField);
            this._textField = null;
            this.hit.width = HIT_MIN_WIDTH;
         }
      }
      
      private function onHitMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TRADE_IN,null,this._vehicleId);
      }
      
      private function onHitClickHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onHitMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
