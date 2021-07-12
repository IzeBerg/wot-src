package net.wg.gui.lobby.badges
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.BackButton;
   import net.wg.gui.components.assets.SpottedBackground;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.badges.data.BadgeSuffixItemVO;
   import net.wg.gui.lobby.badges.data.BadgeSuffixVO;
   import net.wg.gui.lobby.badges.data.BadgesHeaderVO;
   import net.wg.gui.lobby.badges.events.BadgesEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class BadgesHeader extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const INV_BADGE_VISUAL:String = "inv_badge_img";
      
      private static const INV_SUFFIX_DATA:String = "inv_suffix_data";
      
      private static const INV_SUFFIX_IMG:String = "inv_suffix_img";
      
      private static const INV_SUFFIX_SELECTED:String = "inv_suffix_selected";
      
      private static const MAX_PLAYER_NAME_WIDTH:int = 433;
      
      private static const BADGE_IMG_GAP:int = 10;
      
      private static const BADGE_IMG_WIDTH:int = 48;
      
      private static const SUFFIX_SELECTED_ALPHA:Number = Values.DEFAULT_ALPHA;
      
      private static const SUFFIX_DESELECTED_ALPHA:Number = 0.3;
      
      private static const SUFFIX_BADGE_IMG_GAP:int = 12;
      
      private static const SUFFIX_BADGE_STRIP_OFFSET_X:int = -50;
      
      private static const PLAYER_TF_DEFAULT_Y:int = 55;
      
      private static const SLOT_CLOSE_BTN_GAP:int = -17;
       
      
      public var backButton:BackButton = null;
      
      public var badgeComponent:BadgeComponent = null;
      
      public var badgeBg:UILoaderAlt = null;
      
      public var suffixBadgeImg:UILoaderAlt = null;
      
      public var suffixBadgeStrip:UILoaderAlt = null;
      
      public var separator:MovieClip = null;
      
      public var bottomShadow:SpottedBackground = null;
      
      public var bg:Sprite = null;
      
      public var backlight:Sprite = null;
      
      public var descrTf:TextField = null;
      
      public var playerTf:TextField = null;
      
      public var slotCloseBtn:ISoundButtonEx = null;
      
      public var suffixSetting:BadgesSuffixSettings = null;
      
      private var _data:BadgesHeaderVO = null;
      
      private var _badgeVisualVO:BadgeVisualVO = null;
      
      private var _hasSelectedBadge:Boolean = false;
      
      private var _suffixData:BadgeSuffixVO = null;
      
      private var _hasSuffixBadgeImg:Boolean = false;
      
      private var _suffixBadgeImg:String = "";
      
      private var _suffixBadgeStrip:String = "";
      
      private var _suffixSelected:Boolean = false;
      
      public function BadgesHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = this.separator.mouseEnabled = this.playerTf.mouseEnabled = this.separator.mouseChildren = this.bottomShadow.mouseEnabled = this.bottomShadow.mouseChildren = false;
         this.badgeBg.source = RES_ICONS.MAPS_ICONS_LIBRARY_BADGES_48X48_BADGE_BG;
         this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
         this.slotCloseBtn.addEventListener(ButtonEvent.CLICK,this.onSlotCloseBtnClickHandler);
         this.suffixSetting.addEventListener(Event.RESIZE,this.onSuffixSettingResizeHandler);
         this.suffixSetting.addEventListener(BadgesEvent.SUFFIX_BADGE_SELECT,this.onSuffixBadgeSelectHandler);
         this.suffixSetting.addEventListener(BadgesEvent.SUFFIX_BADGE_DESELECT,this.onSuffixBadgeDeselectHandler);
         this.suffixBadgeImg.visible = this.suffixBadgeStrip.visible = this.suffixSetting.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:BadgeSuffixItemVO = null;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.backButton.label = this._data.backBtnLabel;
            this.backButton.descrLabel = this._data.backBtnDescrLabel;
            this.descrTf.htmlText = this._data.descrTf;
            this.playerTf.htmlText = this._data.playerText;
            invalidateLayout();
         }
         if(this._badgeVisualVO != null && isInvalid(INV_BADGE_VISUAL))
         {
            this.badgeComponent.setData(this._badgeVisualVO);
            this.slotCloseBtn.visible = this._hasSelectedBadge;
            invalidateLayout();
         }
         if(this._suffixData != null && isInvalid(INV_SUFFIX_DATA))
         {
            _loc1_ = this._suffixData.items[this._suffixData.selectedItemIdx];
            this._suffixBadgeImg = _loc1_.img;
            this._suffixBadgeStrip = _loc1_.stripImg;
            this._hasSuffixBadgeImg = StringUtils.isNotEmpty(this._suffixBadgeImg);
            this._suffixSelected = this._suffixData.checkboxSelected;
            if(this._hasSuffixBadgeImg)
            {
               this.suffixBadgeImg.visible = true;
               this.descrTf.visible = false;
               this.suffixSetting.visible = true;
            }
            else
            {
               this.suffixBadgeStrip.visible = false;
               this.suffixBadgeImg.visible = false;
               this.descrTf.visible = true;
               this.suffixSetting.visible = false;
            }
            invalidate(INV_SUFFIX_SELECTED);
            invalidate(INV_SUFFIX_IMG);
         }
         if(this._hasSuffixBadgeImg && isInvalid(INV_SUFFIX_SELECTED))
         {
            this.suffixBadgeStrip.visible = this._suffixSelected;
            this.suffixBadgeImg.alpha = !!this._suffixSelected ? Number(SUFFIX_SELECTED_ALPHA) : Number(SUFFIX_DESELECTED_ALPHA);
            invalidateLayout();
         }
         if(this._hasSuffixBadgeImg && isInvalid(INV_SUFFIX_IMG))
         {
            this.suffixBadgeImg.source = this._suffixBadgeImg;
            this.suffixBadgeStrip.source = this._suffixBadgeStrip;
            invalidateLayout();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.separator.width = this.bg.width = _width;
            this.bottomShadow.setWidth(_width);
            this.backlight.x = _width - this.backlight.width >> 1;
            this.descrTf.x = _width - this.descrTf.width >> 1;
            invalidateLayout();
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.updateBadgeRelatedLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
         this.backButton.dispose();
         this.backButton = null;
         this.suffixSetting.removeEventListener(Event.RESIZE,this.onSuffixSettingResizeHandler);
         this.suffixSetting.removeEventListener(BadgesEvent.SUFFIX_BADGE_SELECT,this.onSuffixBadgeSelectHandler);
         this.suffixSetting.removeEventListener(BadgesEvent.SUFFIX_BADGE_DESELECT,this.onSuffixBadgeDeselectHandler);
         this.suffixSetting.dispose();
         this.suffixSetting = null;
         this.suffixBadgeImg.dispose();
         this.suffixBadgeImg = null;
         this.suffixBadgeStrip.dispose();
         this.suffixBadgeStrip = null;
         this.badgeComponent.dispose();
         this.badgeComponent = null;
         this.badgeBg.dispose();
         this.badgeBg = null;
         this.bottomShadow.dispose();
         this.bottomShadow = null;
         this.slotCloseBtn.removeEventListener(ButtonEvent.CLICK,this.onSlotCloseBtnClickHandler);
         this.slotCloseBtn.dispose();
         this.slotCloseBtn = null;
         this._badgeVisualVO = null;
         this.descrTf = null;
         this.playerTf = null;
         this.separator = null;
         this.bg = null;
         this.backlight = null;
         this._data = null;
         this._suffixData = null;
         super.onDispose();
      }
      
      public function setBadgeData(param1:BadgeVisualVO, param2:Boolean) : void
      {
         this._badgeVisualVO = param1;
         this._hasSelectedBadge = param2;
         invalidate(INV_BADGE_VISUAL);
      }
      
      public function setBadgeSuffix(param1:BadgeSuffixVO) : void
      {
         if(this._suffixData != param1 && param1 != null)
         {
            this._suffixData = param1;
            this.suffixSetting.update(this._suffixData);
            invalidate(INV_SUFFIX_DATA);
         }
      }
      
      public function update(param1:Object) : void
      {
         this._data = BadgesHeaderVO(param1);
         invalidateData();
      }
      
      private function updateBadgeRelatedLayout() : void
      {
         if(this.playerTf.textWidth > MAX_PLAYER_NAME_WIDTH)
         {
            this.playerTf.autoSize = TextFieldAutoSize.NONE;
            this.playerTf.width = MAX_PLAYER_NAME_WIDTH;
            App.utils.commons.truncateTextFieldText(this.playerTf,this.playerTf.htmlText,true,true);
         }
         else
         {
            this.playerTf.autoSize = TextFieldAutoSize.LEFT;
         }
         this.playerTf.x = _width - this.playerTf.width >> 1;
         this.badgeComponent.x = this.playerTf.x - BADGE_IMG_WIDTH - BADGE_IMG_GAP | 0;
         this.badgeBg.x = this.badgeComponent.x - 1;
         this.playerTf.y = PLAYER_TF_DEFAULT_Y;
         if(this._hasSelectedBadge)
         {
            this.slotCloseBtn.x = this.badgeComponent.x + BADGE_IMG_WIDTH + SLOT_CLOSE_BTN_GAP | 0;
         }
         if(this._hasSuffixBadgeImg)
         {
            this.suffixBadgeImg.x = this.playerTf.x + this.playerTf.width + SUFFIX_BADGE_IMG_GAP | 0;
            this.suffixBadgeStrip.x = this.suffixBadgeImg.x + SUFFIX_BADGE_STRIP_OFFSET_X;
            this.suffixSetting.x = this.playerTf.x - (this.suffixSetting.width - this.playerTf.width >> 1);
         }
      }
      
      private function onSuffixSettingResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onSuffixBadgeSelectHandler(param1:BadgesEvent) : void
      {
         var _loc2_:BadgeSuffixItemVO = null;
         if(!this._suffixSelected)
         {
            this._suffixSelected = true;
            invalidate(INV_SUFFIX_SELECTED);
         }
         for each(_loc2_ in this._suffixData.items)
         {
            if(_loc2_.id == param1.badgeID)
            {
               this._suffixBadgeImg = _loc2_.img;
               this._hasSuffixBadgeImg = StringUtils.isNotEmpty(this._suffixBadgeImg);
               this._suffixBadgeStrip = _loc2_.stripImg;
               invalidate(INV_SUFFIX_IMG);
               break;
            }
         }
         dispatchEvent(param1.clone());
      }
      
      private function onSuffixBadgeDeselectHandler(param1:BadgesEvent) : void
      {
         this._suffixSelected = false;
         invalidate(INV_SUFFIX_SELECTED);
         dispatchEvent(param1.clone());
      }
      
      private function onBackButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new BadgesEvent(BadgesEvent.BACK_BUTTON_CLICK));
      }
      
      private function onSlotCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new BadgesEvent(BadgesEvent.BADGE_DESELECT));
      }
   }
}
