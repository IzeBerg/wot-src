package net.wg.gui.lobby.vehicleCustomization.controls.bottomPanel
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationCarouselInfoLabel extends UIComponentEx
   {
       
      
      public var defaultStyleLabel:TextField = null;
      
      private var _text:String = "";
      
      private var _tooltip:String = "";
      
      public function CustomizationCarouselInfoLabel()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.defaultStyleLabel.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.defaultStyleLabel = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.defaultStyleLabel.htmlText = Boolean(this._text) ? this._text : Values.EMPTY_STR;
            this.defaultStyleLabel.x = -(this.defaultStyleLabel.width >> 1);
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._tooltip) && App.toolTipMgr)
         {
            App.toolTipMgr.showComplex(this._tooltip);
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         if(App.toolTipMgr)
         {
            App.toolTipMgr.hide();
         }
      }
      
      public function set text(param1:String) : void
      {
         if(this._text != param1)
         {
            this._text = param1;
            invalidateData();
         }
      }
      
      public function get text() : String
      {
         return this.defaultStyleLabel.text;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      override public function get height() : Number
      {
         return this.defaultStyleLabel.height;
      }
   }
}
