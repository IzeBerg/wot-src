package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.utils.IStyleSheetManager;
   import scaleform.clik.controls.Button;
   
   [InspectableList("visible")]
   public class HyperLink extends Button implements IUIComponentEx
   {
      
      private static const INVALID_SHOW_ICON:String = "invalidShowIcon";
      
      private static const INVALID_STYLE:String = "invalidStyle";
      
      private static const LINK_OPEN_TAG:String = "<a href=\'event:hyperLink\'>";
      
      private static const LINK_CLOSE_TAG:String = "</a>";
      
      private static const NORMAL_STYLE:String = "normal";
      
      private static const WHITE_STYLE:String = "while";
      
      private static const OUT_ALPHA:Number = 0.7;
      
      private static const GAP:Number = 3;
       
      
      public var externalLinkIco:Sprite = null;
      
      private var _forceFocusView:Boolean = false;
      
      private var _isShowLinkIco:Boolean = false;
      
      private var _styleType:String = "normal";
      
      private var _styleSheetManager:IStyleSheetManager;
      
      public function HyperLink()
      {
         this._styleSheetManager = App.utils.styleSheetManager;
         super();
         this.externalLinkIco.visible = false;
      }
      
      override protected function configUI() : void
      {
         constraintsDisabled = true;
         preventAutosizing = true;
         super.configUI();
         mouseChildren = true;
         mouseEnabled = true;
         alpha = OUT_ALPHA;
         invalidate(NORMAL_STYLE);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_SHOW_ICON))
         {
            this.updateIcoPosition();
            this.externalLinkIco.buttonMode = this.externalLinkIco.useHandCursor = enabled;
         }
         if(isInvalid(INVALID_STYLE))
         {
            switch(this._styleType)
            {
               case NORMAL_STYLE:
                  this._styleSheetManager.setLinkStyle(textField);
                  break;
               case WHITE_STYLE:
                  this._styleSheetManager.setWhiteLinkStyle(textField);
                  break;
               default:
                  this._styleSheetManager.setLinkStyle(textField);
            }
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
               _loc1_ = this._styleSheetManager.setForceFocusedStyle(_loc1_);
            }
            textField.htmlText = LINK_OPEN_TAG + _loc1_ + LINK_CLOSE_TAG;
            textField.width = textField.textWidth + GAP | 0;
            textField.autoSize = TextFieldAutoSize.LEFT;
            this.updatePosition();
         }
      }
      
      override protected function onDispose() : void
      {
         this.externalLinkIco = null;
         this._styleSheetManager = null;
         super.onDispose();
      }
      
      public function setWhiteLinkStyle() : void
      {
         this._styleType = WHITE_STYLE;
         invalidate(NORMAL_STYLE);
      }
      
      private function updateIcoPosition() : void
      {
         if(this._isShowLinkIco)
         {
            this.externalLinkIco.x = textField.x + textField.width;
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
      
      private function setUnderline(param1:Boolean) : void
      {
         var _loc2_:TextFormat = textField.getTextFormat();
         _loc2_.underline = param1;
         textField.setTextFormat(_loc2_);
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
         this.externalLinkIco.buttonMode = this.externalLinkIco.useHandCursor = enabled;
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
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         alpha = Values.DEFAULT_ALPHA;
         this.setUnderline(true);
         super.handleMouseRollOver(param1);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         alpha = OUT_ALPHA;
         this.setUnderline(false);
         super.handleMouseRollOver(param1);
      }
   }
}
