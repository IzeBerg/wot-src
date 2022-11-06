package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.constants.ToolTipShowType;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Label;
   import scaleform.clik.core.UIComponent;
   
   public class LabelControl extends Label
   {
      
      private static const INFO_INV:String = "infoInv";
       
      
      public var hitMc:Sprite = null;
      
      private var _textAlign:String = "none";
      
      private var _owner:UIComponent = null;
      
      private var _tooltip:String = "";
      
      private var _tooltipType:ToolTipShowType;
      
      private var _infoIcoType:String = "";
      
      private var _infoIco:InfoIcon = null;
      
      public function LabelControl()
      {
         this._tooltipType = ToolTipShowType.COMPLEX;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hitArea = this.hitMc;
         textField.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         if(this._infoIco)
         {
            this.removeInfoIco();
         }
         this.hitMc = null;
         this._owner = null;
         this._tooltipType = null;
         super.onDispose();
      }
      
      override protected function updateText() : void
      {
         var _loc1_:TextFormat = null;
         super.updateText();
         if(_text != null && textField != null)
         {
            _loc1_ = textField.getTextFormat();
            _loc1_.align = this._textAlign;
            textField.setTextFormat(_loc1_);
            textField.alpha = state == ComponentState.DISABLED ? Number(0.5) : Number(1);
         }
         invalidateSize();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INFO_INV))
         {
            if(this._infoIcoType != Values.EMPTY_STR && this._tooltip != Values.EMPTY_STR)
            {
               if(!this._infoIco)
               {
                  this.createInfoIco();
               }
               this._infoIco.tooltip = this._tooltip;
               this._infoIco.icoType = this._infoIcoType;
               this._infoIco.tooltipType = this._tooltipType;
               this.repositionInfoIcon();
            }
            else
            {
               this.removeInfoIco();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            setActualSize(_width,_height);
            if(!constraintsDisabled)
            {
               constraints.update(_width,_height);
            }
            this.updateHitArea();
         }
      }
      
      private function updateHitArea() : void
      {
         var _loc1_:Number = NaN;
         if(this.hitMc && textField)
         {
            _loc1_ = textField.textWidth * textField.scaleX;
            this.hitMc.x = this.textAlign == TextFieldAutoSize.LEFT || this.textAlign == TextFieldAutoSize.NONE ? Number(textField.x) : Number(textField.x + textField.width - _loc1_);
            this.hitMc.width = _loc1_;
         }
      }
      
      private function createInfoIco() : void
      {
         if(!this.owner && parent)
         {
            this.owner = parent as UIComponent;
            App.utils.asserter.assertNotNull(this.owner,"owner" + Errors.CANT_NULL);
         }
         this._infoIco = InfoIcon(App.utils.classFactory.getComponent(Linkages.INFO_ICON_UI,InfoIcon));
         this.owner.addChild(this._infoIco);
      }
      
      private function removeInfoIco() : void
      {
         if(this._infoIco)
         {
            this._infoIco.dispose();
            this.owner.removeChild(this._infoIco);
            this._infoIco = null;
         }
      }
      
      private function repositionInfoIcon() : void
      {
         if(this._infoIco)
         {
            this._infoIco.x = this.x + textField.x + textField.textWidth + InfoIcon.LABEL_MARGIN | 0;
            this._infoIco.y = this.y + (textField.y + textField.height >> 1) - 1;
         }
      }
      
      public function get textAlign() : String
      {
         return this._textAlign;
      }
      
      [Inspectable(defaultValue="none",enumeration="none,left,right,center")]
      public function set textAlign(param1:String) : void
      {
         if(this._textAlign == param1)
         {
            return;
         }
         this._textAlign = param1;
         invalidateData();
      }
      
      public function get toolTip() : String
      {
         return this._tooltip;
      }
      
      public function set toolTip(param1:String) : void
      {
         if(param1 && param1 != this._tooltip)
         {
            this._tooltip = param1;
            invalidate(INFO_INV);
         }
      }
      
      public function set tooltipType(param1:ToolTipShowType) : void
      {
         if(param1 && param1 != this._tooltipType)
         {
            this._tooltipType = param1;
            invalidate(INFO_INV);
         }
      }
      
      public function get infoIcoType() : String
      {
         return this._infoIcoType;
      }
      
      [Inspectable(defaultValue="",type="String")]
      public function set infoIcoType(param1:String) : void
      {
         if(param1 == this._infoIcoType)
         {
            return;
         }
         this._infoIcoType = param1;
         invalidate(INFO_INV);
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
   }
}
