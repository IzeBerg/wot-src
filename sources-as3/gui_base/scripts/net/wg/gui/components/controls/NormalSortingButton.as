package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.SortingInfo;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.ScalableIconButton;
   import net.wg.gui.components.advanced.SortingButtonVO;
   import net.wg.gui.events.SortingEvent;
   import net.wg.gui.events.UILoaderEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class NormalSortingButton extends ScalableIconButton
   {
      
      private static const SORT_DIRECTION_INVALID:String = "checkSortDirection";
      
      private static const SEPARATOR_PADDING:int = 3;
      
      private static const TEXT_PADDING:int = 13;
      
      private static const DESIGN_PADDING:int = 8;
      
      private static const PIXEL_PADDING:int = 1;
      
      private static const SEPARATOR:String = "separator";
      
      private static const EMPTY:String = "empty";
       
      
      public var labelField:TextField;
      
      public var defaultSortDirection:String = "none";
      
      public var bg:MovieClip;
      
      public var upperBg:MovieClip;
      
      public var sortingArrow:MovieClip;
      
      public var overBg:MovieClip;
      
      public var pressBg:MovieClip;
      
      public var arrowBg:MovieClip;
      
      private var _sortDirection:String;
      
      private var _textAlign:String = "center";
      
      private var _verticalTextAlign:String = "bottom";
      
      private var _id:String;
      
      private var _showSeparator:Boolean = true;
      
      private var _showDisabledState:Boolean = false;
      
      private var _previousSelectedSorDirection:String;
      
      private var _toolTipSpecialType:String = "";
      
      public function NormalSortingButton()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.labelField = null;
         this.bg = null;
         this.upperBg = null;
         this.sortingArrow = null;
         this.overBg = null;
         this.pressBg = null;
         this.arrowBg = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabledOnDisabled = true;
         this.sortingArrow.visible = false;
         this.tabEnabled = false;
         _toggle = true;
         allowDeselect = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               _newFrame = null;
            }
            if(_baseDisposed)
            {
               return;
            }
            if(focusIndicator && _newFocusIndicatorFrame)
            {
               focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
               _newFocusIndicatorFrame = null;
            }
            updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
         }
         if(isIconSourceChanged)
         {
            isIconSourceChanged = false;
            loader.source = iconSource;
            invalidate(InvalidationType.SIZE);
         }
         if(this.labelField && isInvalid(InvalidationType.DATA))
         {
            if(!iconSource && data.label)
            {
               this.labelField.visible = true;
               this.labelField.htmlText = data.label;
               this.updateTextSize(true);
            }
            else
            {
               this.labelField.visible = false;
            }
         }
         if(isInvalid(SORT_DIRECTION_INVALID))
         {
            this.applySortDirection();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            hitMc.width = _width;
            hitMc.height = _height;
            this.bg.gotoAndStop(!!this._showSeparator ? SEPARATOR : EMPTY);
            this.bg.width = _width;
            this.bg.height = _height;
            if(this.pressBg)
            {
               this.pressBg.gotoAndStop(!!this._showSeparator ? SEPARATOR : EMPTY);
               this.pressBg.width = _width - PIXEL_PADDING;
               this.pressBg.height = _height;
            }
            if(this.overBg)
            {
               this.overBg.y = _height;
               this.overBg.width = _width - PIXEL_PADDING;
            }
            _loc1_ = !!this._showSeparator ? int(SEPARATOR_PADDING) : int(0);
            this.sortingArrow.x = Math.round((_width - _loc1_) / 2);
            this.arrowBg.y = this.sortingArrow.y = Math.round(_height);
            this.arrowBg.width = _width - _loc1_;
            loader.x = Math.round((_width - loader.width - _loc1_) / 2);
            loader.y = Math.round((_height - loader.height) / 2);
            this.updateTextSize(true);
         }
         this.updateDisable();
      }
      
      override protected function updateDisable() : void
      {
         if(disableMc != null)
         {
            disableMc.visible = !enabled && this._showDisabledState;
            disableMc.x = disabledFillPadding.left;
            disableMc.y = disabledFillPadding.top;
            disableMc.width = _width;
            disableMc.height = _height;
            disableMc.widthFill = _width - disabledFillPadding.horizontal;
            disableMc.heightFill = _height - disabledFillPadding.vertical;
         }
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         if(selected)
         {
            if(this.sortDirection == SortingInfo.ASCENDING_SORT)
            {
               this.sortDirection = SortingInfo.DESCENDING_SORT;
            }
            else if(this.sortDirection == SortingInfo.DESCENDING_SORT)
            {
               this.sortDirection = SortingInfo.ASCENDING_SORT;
            }
         }
         else
         {
            super.handleClick(param1);
         }
      }
      
      override protected function showTooltip() : void
      {
         if(this._toolTipSpecialType != Values.EMPTY_STR)
         {
            App.toolTipMgr.showSpecial(this._toolTipSpecialType,null);
         }
         else
         {
            super.showTooltip();
         }
      }
      
      protected function applySortDirection() : void
      {
         var _loc1_:String = this._sortDirection;
         if(_loc1_ == SortingInfo.ASCENDING_SORT || _loc1_ == SortingInfo.DESCENDING_SORT)
         {
            if(data is SortingButtonVO && SortingButtonVO(data).inverted)
            {
               _loc1_ = SortingInfo.ASCENDING_SORT == _loc1_ ? SortingInfo.DESCENDING_SORT : SortingInfo.ASCENDING_SORT;
            }
            this.sortingArrow.gotoAndStop(_loc1_);
            this.arrowBg.visible = this.sortingArrow.visible = true;
         }
         else
         {
            this.arrowBg.visible = this.sortingArrow.visible = false;
         }
      }
      
      private function checkSortingBtnInfo(param1:Object) : void
      {
         var _loc2_:NormalSortingBtnVO = null;
         if(param1 is SortingButtonVO)
         {
            _loc2_ = NormalSortingBtnVO(param1);
            if(!isNaN(_loc2_.buttonWidth))
            {
               width = _loc2_.buttonWidth;
            }
            if(!isNaN(_loc2_.buttonHeight))
            {
               height = _loc2_.buttonHeight;
            }
            if(_loc2_.defaultSortDirection)
            {
               this.defaultSortDirection = _loc2_.defaultSortDirection;
            }
            if(_loc2_.toolTip)
            {
               App.utils.asserter.assert(!Boolean(_loc2_.toolTipSpecialType),"Can not show common tooltip and tooltip special at one time");
               tooltip = _loc2_.toolTip;
            }
            if(_loc2_.toolTipSpecialType)
            {
               App.utils.asserter.assert(!Boolean(_loc2_.toolTip),"Can not show common tooltip and tooltip special at one time");
               this._toolTipSpecialType = _loc2_.toolTipSpecialType;
            }
            enabled = _loc2_.enabled;
            this._id = _loc2_.id;
            this._showSeparator = _loc2_.showSeparator;
            this._showDisabledState = _loc2_.showDisabledState;
            this._textAlign = _loc2_.textAlign;
            this._verticalTextAlign = _loc2_.verticalTextAlign;
            iconSource = _loc2_.iconSource;
         }
      }
      
      private function updateTextSize(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TextFormat = null;
         if(this.labelField && this.labelField.visible)
         {
            this.labelField.x = 0;
            this.labelField.width = _width - SEPARATOR_PADDING;
            _loc2_ = _height;
            if(this._verticalTextAlign == TextFieldEx.VAUTOSIZE_BOTTOM)
            {
               _loc2_ -= DESIGN_PADDING;
            }
            this.labelField.height = _loc2_;
         }
         if(param1)
         {
            _loc3_ = this.labelField.getTextFormat();
            _loc3_.align = this._textAlign;
            if(this._textAlign == TextFieldAutoSize.RIGHT)
            {
               _loc3_.rightMargin = TEXT_PADDING;
            }
            else if(this._textAlign == TextFieldAutoSize.LEFT)
            {
               _loc3_.leftMargin = TEXT_PADDING;
            }
            this.labelField.setTextFormat(_loc3_);
            TextFieldEx.setVerticalAlign(this.labelField,this._verticalTextAlign);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         this.checkSortingBtnInfo(param1);
         invalidateData();
      }
      
      override public function set toggle(param1:Boolean) : void
      {
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(selected != param1)
         {
            if(param1 == false)
            {
               this.sortDirection = SortingInfo.WITHOUT_SORT;
            }
            else if(this._previousSelectedSorDirection != SortingInfo.ASCENDING_SORT && this._previousSelectedSorDirection != SortingInfo.DESCENDING_SORT)
            {
               this.sortDirection = this.defaultSortDirection == SortingInfo.WITHOUT_SORT ? SortingInfo.ASCENDING_SORT : this.defaultSortDirection;
            }
            else
            {
               this.sortDirection = this.defaultSortDirection == SortingInfo.WITHOUT_SORT ? this._previousSelectedSorDirection : this.defaultSortDirection;
            }
         }
         super.selected = param1;
      }
      
      [Inspectable(defaultValue="none",name="sortDirection",enumeration="none,ascending,descending")]
      public function get sortDirection() : String
      {
         return this._sortDirection;
      }
      
      public function set sortDirection(param1:String) : void
      {
         if(this._sortDirection != param1 && selected)
         {
            this._previousSelectedSorDirection = this._sortDirection;
         }
         if(param1 != SortingInfo.ASCENDING_SORT && param1 != SortingInfo.DESCENDING_SORT && param1 != SortingInfo.WITHOUT_SORT)
         {
            param1 = SortingInfo.WITHOUT_SORT;
         }
         if(this._sortDirection != param1)
         {
            this._sortDirection = param1;
            dispatchEvent(new SortingEvent(SortingEvent.SORT_DIRECTION_CHANGED,true));
            invalidate(SORT_DIRECTION_INVALID);
         }
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      override protected function iconLoadingCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateSize();
      }
   }
}
