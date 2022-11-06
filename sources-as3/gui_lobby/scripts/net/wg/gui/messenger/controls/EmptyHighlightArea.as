package net.wg.gui.messenger.controls
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class EmptyHighlightArea extends UIComponentEx
   {
      
      private static var HIGHLIGHT_TEXT_COLOR:uint = 39168;
      
      private static const TEXT_COLOR_INV:String = "hlInv";
      
      private static const HIGHLIGHT_INV:String = "highInv";
      
      private static const TEXT_ALPHA_INV:String = "taInv";
      
      private static const DASH_AREA_COLOR_INV:String = "dacInv";
      
      private static const DASH_AREA_ALPHA_INV:String = "daAInv";
       
      
      public var title:TextField;
      
      public var dashedArea:DashedHighlightArea;
      
      private var _defaultTextColor:int = -1;
      
      private var _defaultTextAlpha:Number = 1;
      
      private var _isHighlight:Boolean;
      
      private var _dashedAreaColor:int = 5855312;
      
      private var _dashedAreaAlpha:Number = 1;
      
      private var _highlightTextAlpha:Number = 1;
      
      public function EmptyHighlightArea()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.title.text = App.utils.locale.makeString(MESSENGER.MESSENGER_CONTACTS_DROPCONTACTPROMPT);
         this.dashedArea.dashLength = 4;
         this.dashedArea.gap = 7;
         if(this._defaultTextColor == -1)
         {
            this._defaultTextColor = this.title.textColor;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = 1;
            _loc2_ = 2 * _loc1_;
            this.dashedArea.setSize(_width - _loc2_,_height - _loc2_);
            this.dashedArea.x = this.dashedArea.y = _loc1_;
            this.title.width = _width;
            this.title.y = _height - this.title.height >> 1;
         }
         if(isInvalid(HIGHLIGHT_INV))
         {
            if(this._isHighlight)
            {
               this.title.textColor = HIGHLIGHT_TEXT_COLOR;
               this.title.alpha = this._highlightTextAlpha;
            }
            else
            {
               this.title.textColor = this._defaultTextColor;
               this.title.alpha = this._defaultTextAlpha;
            }
         }
         if(isInvalid(DASH_AREA_COLOR_INV))
         {
            this.dashedArea.color = this._dashedAreaColor;
         }
         if(isInvalid(TEXT_ALPHA_INV))
         {
            this.title.alpha = this._defaultTextAlpha;
         }
         if(isInvalid(DASH_AREA_ALPHA_INV))
         {
            this.dashedArea.alpha = this._dashedAreaAlpha;
         }
      }
      
      public function highlightArea(param1:Boolean) : void
      {
         if(this._isHighlight != param1)
         {
            this._isHighlight = param1;
            invalidate(HIGHLIGHT_INV);
         }
      }
      
      public function set dashedAreaColor(param1:int) : void
      {
         if(this._dashedAreaColor != param1)
         {
            this._dashedAreaColor = param1;
            invalidate(DASH_AREA_COLOR_INV);
         }
      }
      
      public function set defaultTextColor(param1:int) : void
      {
         if(this._defaultTextColor != param1)
         {
            this._defaultTextColor = param1;
            invalidate(HIGHLIGHT_INV);
         }
      }
      
      public function set defaultTextAlpha(param1:int) : void
      {
         if(this._defaultTextAlpha != param1)
         {
            this._defaultTextAlpha = param1;
            invalidate(TEXT_ALPHA_INV);
         }
      }
      
      public function set highlightTextAlpha(param1:int) : void
      {
         if(this._highlightTextAlpha != param1)
         {
            this._highlightTextAlpha = param1;
            invalidate(HIGHLIGHT_INV);
         }
      }
      
      public function set dashedAreaAlpha(param1:Number) : void
      {
         if(this._dashedAreaAlpha != param1)
         {
            this._dashedAreaAlpha = param1;
            invalidate(DASH_AREA_ALPHA_INV);
         }
      }
   }
}
