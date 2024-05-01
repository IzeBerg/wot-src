package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.gui.lobby.components.TextWrapper;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class TextFieldAnimated extends UIComponentEx
   {
      
      private static const LAYOUT_LEFT:int = 1;
      
      private static const IDLE_STATE:String = "Idle";
      
      private static const SWITCH_STATE:String = "Switch";
       
      
      private var _currentText:String = "";
      
      private var _layoutId:int = -1;
      
      private var _textFormat:TextFormat;
      
      public var tfWrapper:TextWrapper = null;
      
      public var tfWrapperOut:TextWrapper = null;
      
      public function TextFieldAnimated()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tfWrapper.mouseEnabled = this.tfWrapper.mouseChildren = false;
         this.tfWrapperOut.mouseEnabled = this.tfWrapperOut.mouseChildren = false;
      }
      
      public function setText(param1:String, param2:Boolean, param3:Boolean) : void
      {
         if(this._currentText != param1)
         {
            this._currentText = param1;
            this.tfWrapperOut.tf.text = this.tfWrapper.tf.text;
            this.tfWrapper.tf.text = App.utils.locale.makeString(param1).toUpperCase();
            if(param3 && param2)
            {
               gotoAndPlay(SWITCH_STATE);
            }
            else
            {
               gotoAndPlay(IDLE_STATE);
            }
            this.applyTextFormat();
         }
      }
      
      public function set layoutId(param1:int) : void
      {
         var _loc2_:TextFormat = null;
         var _loc3_:String = null;
         if(this._layoutId != param1)
         {
            this._layoutId = param1;
            _loc2_ = this.tfWrapper.tf.getTextFormat();
            _loc3_ = param1 == LAYOUT_LEFT ? TextFieldAutoSize.LEFT : TextFieldAutoSize.CENTER;
            _loc2_.align = _loc3_;
            this._textFormat = _loc2_;
            this.applyTextFormat();
         }
      }
      
      override protected function onDispose() : void
      {
         this.tfWrapper.dispose();
         this.tfWrapper = null;
         this.tfWrapperOut.dispose();
         this.tfWrapperOut = null;
         this._textFormat = null;
         super.onDispose();
      }
      
      private function applyTextFormat() : void
      {
         if(this._textFormat)
         {
            this.tfWrapper.tf.setTextFormat(this._textFormat);
            this.tfWrapper.tf.defaultTextFormat = this._textFormat;
            this.tfWrapperOut.tf.setTextFormat(this._textFormat);
            this.tfWrapperOut.tf.defaultTextFormat = this._textFormat;
         }
      }
   }
}
