package net.wg.gui.battle.views.HWBattleLoading.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.HWBattleLoading.data.BattleLoadingHintVO;
   import net.wg.utils.StageSizeBoundaries;
   
   public class TextContainer extends BattleUIComponent
   {
      
      private static const TITLE_SIZE_SMALL:int = 24;
      
      private static const TITLE_SIZE:int = 36;
      
      private static const DESCRIPTION_SIZE_SMALL:int = 16;
      
      private static const DESCRIPTION_SIZE:int = 20;
      
      private static const TITLE_SHIFT:int = 70;
      
      private static const TITLE_SHIFT_SMALL:int = 50;
      
      private static const DESCRIPTION_SPACING:int = 11;
      
      private static const DESCRIPTION_SPACING_SMALL:int = 5;
      
      private static const DESCRIPTION_Y:int = 57;
      
      private static const DESCRIPTION_Y_SMALL:int = 38;
      
      private static const PUMPKIN_PADDING_SMALL:int = 7;
      
      private static const SELECTED_COLOR:int = 13434726;
      
      private static const OTHER_COLOR:int = 9211006;
      
      private static const ACTIVE_FRAME:int = 1;
      
      private static const DISABLED_FRAME:int = 2;
      
      private static const ICON_PADDING:int = 7;
      
      private static const TEXT_LEADING:int = -2;
      
      private static const SMALL_DESCIRPTION_PADDING:int = 3;
      
      private static const DESCIRPTION_PADDING:int = 1;
       
      
      public var title1:TextField = null;
      
      public var title2:TextField = null;
      
      public var title3:TextField = null;
      
      public var title4a:TextField = null;
      
      public var title4b:TextField = null;
      
      public var title4Icon:MovieClip = null;
      
      public var description:TextField = null;
      
      private var _pages:Vector.<BattleLoadingHintVO> = null;
      
      private var _hintData:BattleLoadingHintVO = null;
      
      private var _activeIndex:int = -1;
      
      private var _isSmall:Boolean = false;
      
      private var _titles:Vector.<TextField> = null;
      
      public function TextContainer()
      {
         super();
         this._titles = new <TextField>[this.title1,this.title2,this.title3,this.title4a];
      }
      
      override protected function onDispose() : void
      {
         this.title1 = null;
         this.title2 = null;
         this.title3 = null;
         this.title4a = null;
         this.title4b = null;
         this.title4Icon = null;
         this.description = null;
         this._titles.splice(0,this._titles.length - 1);
         this._titles = null;
         this._hintData = null;
         this._pages = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         if(this._activeIndex != Values.DEFAULT_INT && this._pages != null && (isInvalid(InvalidationType.DATA) || isInvalid(InvalidationType.SIZE)))
         {
            this.updateTextFormat();
            this._hintData = this._pages[this._activeIndex];
            _loc1_ = null;
            this.description.text = this._hintData.description;
            App.utils.commons.updateTextFieldSize(this.description,false,true);
            _loc2_ = this._titles.length;
            _loc3_ = 0;
            _loc4_ = !!this._isSmall ? int(DESCRIPTION_SPACING_SMALL) : int(DESCRIPTION_SPACING);
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc1_ = this._titles[_loc5_];
               this._hintData = this._pages[_loc5_];
               _loc1_.y = _loc5_ * (!!this._isSmall ? TITLE_SHIFT_SMALL : TITLE_SHIFT) + _loc3_;
               _loc1_.text = this._hintData.title;
               _loc1_.textColor = this._activeIndex == _loc5_ ? uint(SELECTED_COLOR) : uint(OTHER_COLOR);
               if(_loc5_ == this._activeIndex)
               {
                  _loc3_ += _loc4_ + this.description.height;
               }
               if(_loc1_ === this.title4a)
               {
                  this.title4b.text = this._hintData.titlePart;
               }
               _loc5_++;
            }
            this.title4Icon.gotoAndStop(this._titles.length - 1 == this._activeIndex ? ACTIVE_FRAME : DISABLED_FRAME);
            this.title4Icon.x = this.title4a.x + this.title4a.textWidth + ICON_PADDING | 0;
            this.title4b.x = this.title4Icon.x + this.title4Icon.width;
            this.title4b.y = this.title4a.y;
            this.title4b.textColor = this.title4a.textColor;
            this.title4Icon.y = this.title4a.y - (!!this._isSmall ? PUMPKIN_PADDING_SMALL : 0);
            this.description.y = this._titles[this._activeIndex].y + (!!this._isSmall ? DESCRIPTION_Y_SMALL : DESCRIPTION_Y);
         }
      }
      
      public function getComponentHeight() : int
      {
         var _loc1_:Boolean = this._titles.length - 1 == this._activeIndex;
         return !!_loc1_ ? int(this.description.y + this.description.height - (!!this._isSmall ? SMALL_DESCIRPTION_PADDING : DESCIRPTION_PADDING)) : int(this.title4a.y + this.title4a.textHeight);
      }
      
      public function setActiveTitle(param1:int) : void
      {
         this._activeIndex = param1;
         invalidateData();
      }
      
      public function setPages(param1:Vector.<BattleLoadingHintVO>) : void
      {
         this._pages = param1;
         invalidateData();
      }
      
      public function updateTextLayout(param1:int) : void
      {
         var _loc2_:Boolean = param1 < StageSizeBoundaries.WIDTH_1600;
         if(_loc2_ != this._isSmall)
         {
            this._isSmall = _loc2_;
            invalidateSize();
         }
      }
      
      private function updateTextFormat() : void
      {
         var _loc1_:TextFormat = this.title1.getTextFormat();
         var _loc2_:TextFormat = this.description.getTextFormat();
         if(this._isSmall)
         {
            _loc1_.size = TITLE_SIZE_SMALL;
            _loc2_.size = DESCRIPTION_SIZE_SMALL;
            _loc2_.leading = 0;
         }
         else
         {
            _loc1_.size = TITLE_SIZE;
            _loc2_.size = DESCRIPTION_SIZE;
            _loc2_.leading = TEXT_LEADING;
         }
         var _loc3_:TextField = null;
         var _loc4_:int = this._titles.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = this._titles[_loc5_];
            _loc3_.setTextFormat(_loc1_);
            _loc3_.defaultTextFormat = _loc1_;
            _loc5_++;
         }
         this.description.setTextFormat(_loc2_);
         this.description.defaultTextFormat = _loc2_;
         this.title4b.setTextFormat(_loc1_);
         this.title4b.defaultTextFormat = _loc1_;
      }
   }
}
