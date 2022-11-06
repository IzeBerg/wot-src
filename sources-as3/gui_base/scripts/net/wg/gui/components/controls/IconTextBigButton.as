package net.wg.gui.components.controls
{
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   
   public class IconTextBigButton extends SoundButtonEx
   {
       
      
      public var textFieldWithoutIcon:TextField = null;
      
      private var _htmlIconStr:String = "";
      
      public function IconTextBigButton()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.textFieldWithoutIcon = null;
         super.onDispose();
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         if(!initialized)
         {
            return;
         }
         if(constraints != null && !constraintsDisabled && this.textFieldWithoutIcon != null)
         {
            constraints.updateElement("textFieldWithoutIcon",this.textFieldWithoutIcon);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!constraintsDisabled)
         {
            if(this.textFieldWithoutIcon != null)
            {
               constraints.addElement("textFieldWithoutIcon",this.textFieldWithoutIcon,Constraints.ALL);
            }
         }
         if(this.textFieldWithoutIcon)
         {
            this.textFieldWithoutIcon.mouseEnabled = false;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(usePreventUpdateTextScale)
            {
               this.updateTextScale();
            }
         }
      }
      
      override protected function updateText() : void
      {
         this.textFieldWithoutIcon.visible = this.htmlIconStr == Values.EMPTY_STR;
         textField.visible = !this.textFieldWithoutIcon.visible;
         if(textField.visible)
         {
            textField.htmlText = this.htmlIconStr + _label;
         }
         else
         {
            this.textFieldWithoutIcon.htmlText = _label;
         }
      }
      
      override protected function calculateWidth() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:TextField = null;
         var _loc1_:Number = actualWidth;
         if(!constraintsDisabled)
         {
            _loc2_ = 0;
            if(autoSize != "none")
            {
               _loc2_ = _paddingHorizontal;
            }
            _loc3_ = !!textField.visible ? textField : this.textFieldWithoutIcon;
            _loc1_ = Math.ceil(_loc3_.textWidth + (_loc2_ + textFieldPaddingHorizontal << 1) + 5);
         }
         if(!isNaN(minWidth))
         {
            _loc1_ = Math.max(_loc1_,minWidth);
         }
         return _loc1_;
      }
      
      private function updateTextScale() : void
      {
         if(this.textFieldWithoutIcon != null)
         {
            this.textFieldWithoutIcon.scaleX = 1 / this.scaleX;
            this.textFieldWithoutIcon.scaleY = 1 / this.scaleY;
            this.textFieldWithoutIcon.y = this.height - this.textFieldWithoutIcon.height >> 1;
         }
      }
      
      override public function set label(param1:String) : void
      {
         param1 = App.utils.locale.makeString(param1);
         super.label = param1;
      }
      
      public function get htmlIconStr() : String
      {
         return this._htmlIconStr;
      }
      
      public function set htmlIconStr(param1:String) : void
      {
         this._htmlIconStr = param1;
         invalidateData();
      }
   }
}
