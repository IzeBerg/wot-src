package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.lobby.vehicleCustomization.data.BottomPanelBillVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationBillLineRendererEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationBill extends UIComponentEx
   {
      
      private static const CUSTOMIZATION_BILL_LINE_RENDERER_UI:String = "CustomizationBillLineRendererUI";
      
      private static const CUSTOMIZATION_BILL_BUTTON_UI:String = "CustomizationBillButtonUI";
      
      private static const LINES_GROUP_X:int = 15;
      
      private static const LINES_GROUP_Y:int = 38;
      
      private static const BASE_WIDTH:int = 214;
      
      private static const BUTTONS_OFFSET_Y:int = 10;
      
      private static const BG_HEIGHT_MARGIN:int = 35;
      
      private static const BUTTONS_GAP:int = 7;
      
      private static const LINES_GAP:int = 4;
      
      private static const LINED_GROUP_RIGHT_MARGIN:int = 8;
       
      
      public var title:TextField = null;
      
      public var background:Sprite = null;
      
      private var _data:BottomPanelBillVO;
      
      private var _linesGroup:GroupEx;
      
      private var _buttonsGroup:GroupEx;
      
      private var _positionDiffX:int = 0;
      
      public function CustomizationBill()
      {
         this._linesGroup = new GroupEx();
         this._buttonsGroup = new GroupEx();
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.title.htmlText = this._data.title;
            this._linesGroup.dataProvider = this._data.lines;
            this._linesGroup.validateNow();
            this._buttonsGroup.dataProvider = this._data.buttons;
            this._buttonsGroup.validateNow();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            width = BASE_WIDTH + this._positionDiffX;
            this._linesGroup.width = width - this._linesGroup.x - LINED_GROUP_RIGHT_MARGIN;
            this._linesGroup.invalidateLayout();
            this._linesGroup.validateNow();
            this._buttonsGroup.x = width - this._buttonsGroup.width >> 1;
            this._buttonsGroup.y = this._linesGroup.y + this._linesGroup.height + BUTTONS_OFFSET_Y ^ 0;
            height = this._buttonsGroup.y + this._buttonsGroup.height;
            this.background.width = width;
            this.background.height = height + BG_HEIGHT_MARGIN;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.background.mouseEnabled = false;
         this._linesGroup.x = LINES_GROUP_X;
         this._linesGroup.y = LINES_GROUP_Y;
         this._linesGroup.width = width - this._linesGroup.x;
         this._linesGroup.layout = new Vertical100PercWidthLayout();
         (this._linesGroup.layout as Vertical100PercWidthLayout).gap = LINES_GAP;
         this._linesGroup.itemRendererLinkage = CUSTOMIZATION_BILL_LINE_RENDERER_UI;
         this._linesGroup.addEventListener(CustomizationBillLineRendererEvent.UPDATE_MIN_WIDTH,this.onLinesGroupUpdateMinWidthHandler);
         this._buttonsGroup.layout = new VerticalGroupLayout();
         (this._buttonsGroup.layout as VerticalGroupLayout).gap = BUTTONS_GAP;
         this._buttonsGroup.itemRendererLinkage = CUSTOMIZATION_BILL_BUTTON_UI;
         addChild(this._linesGroup);
         addChild(this._buttonsGroup);
         this.title.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      override protected function onDispose() : void
      {
         this._linesGroup.removeEventListener(CustomizationBillLineRendererEvent.UPDATE_MIN_WIDTH,this.onLinesGroupUpdateMinWidthHandler);
         this._linesGroup.dispose();
         this._linesGroup = null;
         this._buttonsGroup.dispose();
         this._buttonsGroup = null;
         this.background = null;
         this.title = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:BottomPanelBillVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onLinesGroupUpdateMinWidthHandler(param1:CustomizationBillLineRendererEvent) : void
      {
         this._positionDiffX = param1.widthDiff;
         invalidateSize();
      }
   }
}
