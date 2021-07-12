package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Fonts;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareVehicleVO;
   import net.wg.gui.lobby.vehicleCompare.data.VehParamsDataVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehicleRendererEvent;
   import net.wg.gui.lobby.vehicleCompare.interfaces.IVehParamRenderer;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ITextManager;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehCompareVehParamRenderer extends ListItemRenderer implements IVehParamRenderer
   {
      
      public static const LINE_WIDTH:int = 162;
      
      public static const LINE_HEIGHT:int = 30;
      
      public static const BOTTOM_LINE_HEIGHT:int = 39;
      
      private static const LINE_GAP:int = 0;
      
      private static const SEPARATOR_X:Number = 162;
      
      private static const TEXT_OFFSET_Y:int = 4;
      
      private static const HEIGHT_INV:String = "HeightInv";
      
      private static const BOTTOM_INV:String = "BottomInv";
      
      private static const BTN_OFFSET:int = 1;
      
      private static const EMPTY_STR:String = "";
      
      private static const FONT_COLOR:int = 9211004;
      
      private static const TEXT_SIZE:int = 14;
       
      
      public var separator:Sprite = null;
      
      public var toPreviewBtn:ISoundButtonEx = null;
      
      public var hangarBtn:ISoundButtonEx = null;
      
      public var bottomShadow:Sprite = null;
      
      public var bottomHitArea:Sprite = null;
      
      private var _backHitArea:Sprite;
      
      private var _textMgr:ITextManager = null;
      
      private var _textFields:Vector.<TextField>;
      
      private var _rendererData:VehCompareVehicleVO = null;
      
      private var _containerHeight:int = 0;
      
      private var _bottomLinePosition:int = -1;
      
      private var _shadowAlpha:Number = 1;
      
      private var _alpha:Number = 1;
      
      public function VehCompareVehParamRenderer()
      {
         var _loc2_:DisplayObject = null;
         this._textFields = new Vector.<TextField>(0);
         super();
         this._backHitArea = new Sprite();
         addChild(this._backHitArea);
         var _loc1_:int = 0;
         while(_loc1_ > numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            if(!(_loc2_ is Button))
            {
               _loc2_.cacheAsBitmap = true;
            }
            _loc1_++;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Vector.<VehParamsDataVO> = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:VehParamsDataVO = null;
         var _loc7_:TextField = null;
         var _loc8_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.hideAllTextFields();
            _loc1_ = this._rendererData != null;
            this.toPreviewBtn.visible = _loc1_ && !this._rendererData.isInHangar && !this._rendererData.isFirstEmptySlot;
            this.hangarBtn.visible = _loc1_ && this._rendererData.isInHangar && !this._rendererData.isFirstEmptySlot;
            this.bottomHitArea.visible = this.toPreviewBtn.visible || this.hangarBtn.visible;
            if(_loc1_)
            {
               _loc2_ = this._rendererData.params;
               if(_loc2_)
               {
                  _loc3_ = _loc2_.length;
                  _loc4_ = 0;
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_)
                  {
                     _loc6_ = _loc2_[_loc5_];
                     if(_loc6_.isVisible)
                     {
                        if(this._textFields.length <= _loc4_)
                        {
                           _loc7_ = this.createTextField();
                        }
                        else
                        {
                           _loc7_ = this._textFields[_loc4_];
                        }
                        _loc4_++;
                        _loc7_.visible = true;
                        _loc7_.htmlText = _loc6_.text;
                        _loc7_.name = _loc6_.paramID;
                     }
                     _loc5_++;
                  }
               }
            }
         }
         if(isInvalid(HEIGHT_INV))
         {
            this.separator.height = this._containerHeight;
         }
         if(isInvalid(BOTTOM_INV))
         {
            _loc8_ = this._bottomLinePosition - BOTTOM_LINE_HEIGHT + (BOTTOM_LINE_HEIGHT - this.toPreviewBtn.height >> 1) + BTN_OFFSET;
            this.hangarBtn.y = _loc8_;
            this.toPreviewBtn.y = _loc8_;
            this.bottomHitArea.y = _loc8_;
            this.bottomShadow.y = _loc8_ - this.bottomShadow.height + BOTTOM_LINE_HEIGHT;
            this.bottomShadow.alpha = this._shadowAlpha;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DisplayObject = null;
         for each(_loc1_ in this._textFields)
         {
            removeChild(_loc1_);
         }
         this._textFields.splice(0,this._textFields.length);
         this._textFields = null;
         if(this._rendererData)
         {
            this._rendererData.removeEventListener(Event.CHANGE,this.onRendererDataChangeHandler);
            this._rendererData.dispose();
            this._rendererData = null;
         }
         this.separator = null;
         this._textMgr = null;
         this.bottomHitArea = null;
         this.hangarBtn.removeEventListener(ButtonEvent.CLICK,this.onToHangarBtnClickHandler);
         this.hangarBtn.dispose();
         this.hangarBtn = null;
         this.toPreviewBtn.removeEventListener(ButtonEvent.CLICK,this.onToPreviewBtnClickHandler);
         this.toPreviewBtn.dispose();
         this.toPreviewBtn = null;
         removeChild(this._backHitArea);
         this._backHitArea = null;
         this.bottomShadow.hitArea = null;
         this.bottomShadow = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.separator.mouseEnabled = this.separator.mouseChildren = false;
         this.separator.x = SEPARATOR_X;
         this.bottomShadow.width = SEPARATOR_X;
         this.bottomShadow.x = 0;
         this.bottomShadow.hitArea = this._backHitArea;
         this.bottomShadow.mouseChildren = this.separator.mouseEnabled = false;
         this._textMgr = App.textMgr;
         this.toPreviewBtn.tooltip = VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_TOPREVIEW;
         this.toPreviewBtn.label = VEH_COMPARE.VEHICLECOMPAREVIEW_TOPREVIEW;
         this.toPreviewBtn.addEventListener(ButtonEvent.CLICK,this.onToPreviewBtnClickHandler);
         this.hangarBtn.label = VEH_COMPARE.VEHICLECOMPAREVIEW_TOHANGAR;
         this.hangarBtn.tooltip = VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_TOHANGAR;
         this.hangarBtn.addEventListener(ButtonEvent.CLICK,this.onToHangarBtnClickHandler);
         buttonMode = false;
         mouseChildren = true;
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      public function updateBottomLineState(param1:int, param2:Number) : void
      {
         this._bottomLinePosition = param1;
         this._shadowAlpha = param2;
         if(param1 > this._containerHeight && this._containerHeight > 0)
         {
            this._bottomLinePosition = this._containerHeight;
         }
         invalidate(BOTTOM_INV);
      }
      
      public function updateHeight(param1:int) : void
      {
         this._containerHeight = param1;
         invalidate(HEIGHT_INV);
      }
      
      private function hideAllTextFields() : void
      {
         var _loc1_:TextField = null;
         for each(_loc1_ in this._textFields)
         {
            _loc1_.text = EMPTY_STR;
            _loc1_.visible = false;
         }
      }
      
      private function createTextField() : TextField
      {
         var _loc1_:TextField = this._textMgr.createTextField();
         _loc1_.width = LINE_WIDTH;
         _loc1_.height = LINE_HEIGHT;
         _loc1_.x = 0;
         _loc1_.y = this._textFields.length * (LINE_HEIGHT + LINE_GAP) + TEXT_OFFSET_Y;
         var _loc2_:TextFormat = _loc1_.defaultTextFormat;
         _loc2_.align = TextFormatAlign.CENTER;
         _loc2_.font = Fonts.FIELD_FONT;
         _loc2_.size = TEXT_SIZE;
         _loc2_.color = FONT_COLOR;
         _loc1_.autoSize = TextFieldAutoSize.CENTER;
         _loc1_.selectable = false;
         _loc1_.defaultTextFormat = _loc2_;
         _loc1_.cacheAsBitmap = true;
         addChildAt(_loc1_,0);
         this._textFields.push(_loc1_);
         return _loc1_;
      }
      
      override public function set alpha(param1:Number) : void
      {
         var _loc2_:DisplayObject = null;
         if(this._alpha == param1)
         {
            return;
         }
         this._alpha = param1;
         for each(_loc2_ in this._textFields)
         {
            _loc2_.alpha = this._alpha;
         }
         this.toPreviewBtn.alpha = this._alpha;
         this.hangarBtn.alpha = this._alpha;
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         if(this._rendererData)
         {
            this._rendererData.removeEventListener(Event.CHANGE,this.onRendererDataChangeHandler);
         }
         if(param1)
         {
            this._rendererData = VehCompareVehicleVO(param1);
            this._rendererData.addEventListener(Event.CHANGE,this.onRendererDataChangeHandler,false,0,true);
         }
         else
         {
            this._rendererData = null;
         }
         invalidateData();
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
      }
      
      private function onRendererDataChangeHandler(param1:Event) : void
      {
         invalidateData();
      }
      
      private function onToHangarBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new VehCompareVehicleRendererEvent(this._rendererData.id,VehCompareVehicleRendererEvent.GO_TO_HANGAR_CLICK,true));
      }
      
      private function onToPreviewBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:VehCompareVehicleRendererEvent = new VehCompareVehicleRendererEvent(this._rendererData.id,VehCompareVehicleRendererEvent.GO_TO_PREVIEW_CLICK,true);
         _loc2_.index = this._rendererData.index;
         dispatchEvent(_loc2_);
      }
   }
}
