package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import scaleform.clik.controls.Button;
   
   [InspectableList("visible")]
   public class HyperLink extends Button implements IUIComponentEx
   {
      
      private static const INVALID_SHOW_ICON:String = "invalidShowIcon";
      
      private static const EXTERNAL_ICO_LEFT_SHIFT:Number = 7;
      
      private static const LINK_OPEN_TAG:String = "<a href=\'event:hyperLink\'>";
      
      private static const LINK_CLOSE_TAG:String = "</a>";
       
      
      public var externalLinkIco:Sprite = null;
      
      private var _forceFocusView:Boolean = false;
      
      private var _isShowLinkIco:Boolean = false;
      
      public function HyperLink()
      {
         super();
         this.externalLinkIco.visible = false;
      }
      
      override protected function configUI() : void
      {
         constraintsDisabled = true;
         preventAutosizing = true;
         super.configUI();
         mouseChildren = true;
         textField.mouseEnabled = true;
         App.utils.styleSheetManager.setLinkStyle(textField);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_SHOW_ICON))
         {
            this.updateIcoPosition();
         }
      }
      
      override protected function changeFocus() : void
      {
         if(!enabled)
         {
            return;
         }
         this.forceFocusView = _focused > 0;
         if(_pressedByKeyboard && !_focused)
         {
            _pressedByKeyboard = false;
         }
      }
      
      override protected function updateText() : void
      {
         var _loc1_:String = null;
         if(label != null && textField != null)
         {
            textField.text = label;
            _loc1_ = textField.text;
            if(this._forceFocusView)
            {
               _loc1_ = App.utils.styleSheetManager.setForceFocusedStyle(_loc1_);
            }
            textField.htmlText = LINK_OPEN_TAG + _loc1_ + LINK_CLOSE_TAG;
            textField.width = textField.textWidth + 4 | 0;
            textField.autoSize = TextFieldAutoSize.LEFT;
            this.updatePosition();
         }
      }
      
      override protected function onDispose() : void
      {
         this.externalLinkIco = null;
         super.onDispose();
      }
      
      private function updateIcoPosition() : void
      {
         if(this._isShowLinkIco)
         {
            this.externalLinkIco.x = textField.x + textField.width + EXTERNAL_ICO_LEFT_SHIFT;
         }
         this.externalLinkIco.visible = this._isShowLinkIco;
      }
      
      private function updatePosition() : void
      {
         if(autoSize == TextFieldAutoSize.CENTER)
         {
            textField.x = -textField.width >> 1;
         }
         else if(autoSize == TextFieldAutoSize.RIGHT)
         {
            textField.x = -textField.width;
         }
         this.updateIcoPosition();
      }
      
      override public function set autoSize(param1:String) : void
      {
         super.autoSize = param1;
         this.updatePosition();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == enabled)
         {
            return;
         }
         super.enabled = param1;
         buttonMode = useHandCursor = enabled;
      }
      
      public function get forceFocusView() : Boolean
      {
         return this._forceFocusView;
      }
      
      public function set forceFocusView(param1:Boolean) : void
      {
         this._forceFocusView = param1;
         this.updateText();
      }
      
      public function get isShowLinkIco() : Boolean
      {
         return this._isShowLinkIco;
      }
      
      public function set isShowLinkIco(param1:Boolean) : void
      {
         this._isShowLinkIco = param1;
         invalidate(INVALID_SHOW_ICON);
      }
   }
}
