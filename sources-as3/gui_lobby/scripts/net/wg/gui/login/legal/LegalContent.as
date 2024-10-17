package net.wg.gui.login.legal
{
   import flash.events.Event;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.Fonts;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class LegalContent extends UIComponentEx
   {
      
      private static var LOGOS_TOP_MARGIN:Number = 15;
      
      private static var LOGOS_LEFT_MARGIN:Number = 20;
      
      private static var FRAME_MARGIN:Number = 0;
      
      private static const DELIM:String = "\n";
      
      private static const PART_LINES:int = 500;
      
      private static const TF_X:int = 20;
      
      private static const TF_Y:int = 14;
      
      private static const TF_WIDTH:int = 392;
      
      private static const TF_COLOR:int = 9211004;
      
      private static const FONT_SIZE:int = 14;
       
      
      private var _tfsHeight:int = 0;
      
      public var logos:UILoaderAlt = null;
      
      private var _textFields:Vector.<TextField> = null;
      
      private var _textInfo:String = "";
      
      public function LegalContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.logos.addEventListener(UILoaderEvent.COMPLETE,this.onLoadComplete);
         this.logos.addEventListener(UILoaderEvent.IOERROR,this.onLoadError);
         this.logos.source = RES_COMMON.MAPS_LEGAL_BRANDS;
         this.logos.x = TF_X - LOGOS_LEFT_MARGIN;
         this._textFields = new Vector.<TextField>();
      }
      
      private function onLoadError(param1:UILoaderEvent) : void
      {
         this.logos.visible = false;
         invalidateSize();
      }
      
      private function onLoadComplete(param1:UILoaderEvent) : void
      {
         invalidateSize();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.removeFields();
            this.addFields();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.logos.visible)
            {
               this.logos.y = this._tfsHeight + LOGOS_TOP_MARGIN ^ 0;
               _height = this.logos.y + this.logos.height;
            }
            else
            {
               this.logos.y = 0;
               _height = this._tfsHeight;
            }
            _height += FRAME_MARGIN;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         this.logos.removeEventListener(UILoaderEvent.COMPLETE,this.onLoadComplete);
         this.logos.removeEventListener(UILoaderEvent.IOERROR,this.onLoadError);
         this.removeFields();
         super.onDispose();
      }
      
      public function updateData(param1:String) : void
      {
         this._textInfo = param1;
         invalidateData();
      }
      
      private function addFields() : void
      {
         var _loc1_:Array = this._textInfo.split(DELIM);
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = _loc2_ / PART_LINES >> Values.ZERO;
         var _loc4_:TextField = null;
         var _loc5_:int = TF_Y;
         var _loc6_:TextFormat = null;
         var _loc7_:int = 0;
         while(_loc7_ <= _loc3_)
         {
            _loc4_ = new TextField();
            _loc4_.width = TF_WIDTH;
            _loc4_.textColor = TF_COLOR;
            _loc4_.antiAliasType = AntiAliasType.ADVANCED;
            _loc4_.autoSize = TextFieldAutoSize.LEFT;
            _loc4_.multiline = true;
            _loc4_.selectable = false;
            _loc4_.wordWrap = true;
            _loc6_ = _loc4_.defaultTextFormat;
            _loc6_.font = Fonts.FIELD_FONT;
            _loc6_.size = FONT_SIZE;
            _loc6_.color = TF_COLOR;
            _loc4_.defaultTextFormat = _loc6_;
            _loc4_.text = this.getTextPart(_loc1_,_loc7_,_loc2_);
            _loc4_.x = TF_X;
            _loc4_.y = _loc5_ ^ Values.ZERO;
            _loc4_.height = _loc4_.textHeight ^ 4;
            _loc5_ += _loc4_.textHeight;
            this.addChild(_loc4_);
            this._textFields[_loc7_] = _loc4_;
            _loc7_++;
         }
         this._tfsHeight = _loc5_;
      }
      
      private function getTextPart(param1:Array, param2:int, param3:int) : String
      {
         var _loc4_:int = Math.min(param2 * PART_LINES,param3);
         var _loc5_:int = Math.min((param2 + 1) * PART_LINES,param3) - 1;
         var _loc6_:String = "";
         var _loc7_:int = _loc4_;
         while(_loc7_ <= _loc5_)
         {
            _loc6_ += param1[_loc7_] + DELIM;
            _loc7_++;
         }
         return _loc6_;
      }
      
      private function removeFields() : void
      {
         var _loc1_:TextField = null;
         if(this._textFields.length > Values.ZERO)
         {
            for each(_loc1_ in this._textFields)
            {
               this.removeChild(_loc1_);
               _loc1_ = null;
            }
            this._textFields.length = Values.ZERO;
         }
      }
   }
}
