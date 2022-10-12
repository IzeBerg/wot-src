package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.data.constants.generated.CUSTOMIZATION_CONSTS;
   import net.wg.data.constants.generated.GUI_ITEM_TYPES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.common.CounterView;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.ButtonIconNormal;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   import net.wg.gui.lobby.vehicleCustomization.CustomizationShared;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.MouseEventEx;
   import scaleform.gfx.TextFieldEx;
   
   public class CarouselItemRenderer extends UIComponentEx implements IScrollerItemRenderer, IDropItem
   {
      
      private static const LIMITED_TEXT_ICON_SIZE:int = 32;
      
      private static const IMAGE_MARGIN:int = 1;
      
      private static const LOCKED_LOCK_AND_BONUS_ALPHA:Number = 1;
      
      private static const LOCKED_IMG_ALPHA:Number = 0.6;
      
      private static const ICON_PADDING_RIGHT:int = 5;
      
      private static const ACTION_ICON_PADDING_RIGHT:int = 6;
      
      private static const ACTION_MIN_RES_OFFSET:int = -4;
      
      private static const SELECTED_WIDTH_OFFSET:int = 20;
      
      private static const SELECTED_HEIGHT_OFFSET:int = 18;
      
      private static const SELECTED_SMALL_X:int = 1;
      
      private static const SELECTED_WIDE_X:int = 11;
      
      private static const SELECTED_MIN_RES_SMALL_X:int = -1;
      
      private static const SELECTED_MIN_RES_WIDE_X:int = 8;
      
      private static const SELECTED_Y:int = 1;
      
      private static const SELECTED_MIN_RES_Y:int = -1;
      
      private static const NON_HISTORIC_OFFSET:int = 1;
      
      private static const PRICE_ICON_OFFSET:Point = new Point(-2,1);
      
      private static const PRICE_BG_OFFSET:Point = new Point(-2,0);
      
      private static const STYLE_NAME_TF_WIDE_WIDTH:int = 205;
      
      private static const STYLE_NAME_TF_WIDE_SMALL_WIDTH:int = 157;
      
      private static const PLACEHOLDER_ALPHA:Number = 0.2;
      
      private static const ALREADY_USED_STYLE_NAME_ALPHA:Number = 0.3;
      
      private static const TEXTFIELD_PADDING:int = 8;
      
      private static const MIN_WIDTH_RESOLUTION:int = 1280;
      
      private static const MIN_HEIGHT_RESOLUTION:int = 900;
      
      private static const SHADOW_SCALE:Number = 0.6;
      
      private static const STORAGE_OFFSET:int = 3;
      
      private static const STYLE_NAME_TF_V_POS:int = 23;
      
      private static const STYLE_NAME_TF_V_OFFSET:int = -10;
      
      private static const RENTAL_TF_PADDING_RIGHT:int = 8;
      
      private static const RENTAL_ICON_OFFSET_X:int = 10;
      
      private static const RENTAL_ICON_OFFSET_Y:int = 8;
      
      private static const RENTAL_ICON_SIZE:int = 38;
      
      private static const RESET_COUNTER_DELAY:int = 300;
      
      private static const COUNTER_OFFSET:int = -20;
      
      private static const EDIT_BTN_COUNTER_OFFSET_X:int = -22;
      
      private static const EDIT_BTN_COUNTER_OFFSET_Y:int = -18;
      
      private static const FORM_ICON_OFFSET_Y:int = 88;
      
      private static const FORM_ICON_OFFSET_SMALL_Y:int = 66;
      
      private static const PROGRESSION_LEVEL_GAP_SMALL:int = -2;
      
      private static const PROGRESSION_LEVEL_GAP:int = 2;
      
      private static const EDITABLE_IMG_WIDTH:int = 18;
      
      private static const EDITABLE_IMG_X:int = 5;
      
      private static const EDITABLE_IMG_GAP:int = -1;
      
      private static const EDITABLE_BG_X:int = -26;
      
      private static const LIMITED_ICON_GAP:int = -7;
      
      private static const ALERT_ICON_X:int = 5;
      
      private static const PROGRESSION_ICON_SMALL_LABEL_POSTFIX:String = "_small";
      
      private static const PROGRESSION_ICON_BIG_LABEL_POSTFIX:String = "_big";
      
      private static const LIMITED_TEXT_SIZE_LOCKED:int = 15;
      
      private static const LIMITED_TEXT_SIZE_UNSUITABLE:int = 13;
      
      private static const LIMITED_ICON_OFFSET_Y:int = -6;
      
      private static const LIMITED_TEXT_OFFSET_Y:int = 26;
      
      private static const PROGRESSION_REWIND_SMALL_LABEL:String = "small";
      
      private static const PROGRESSION_REWIND_BIG_LABEL:String = "big";
      
      private static const SERIAL_NUMBER_GAP:int = -1;
      
      private static const ICON_LOCK_GREY_BOTTOM_OFFSET:int = -2;
      
      private static const BORDER_NEW_UI:String = "BorderNewUI";
      
      private static const BORDER_NEW_WIDE_UI:String = "BorderNewWideUI";
      
      private static const NEW_MC_MIN_SCALE:Number = 0.79;
      
      private static const NEW_MC_NORMAL_SCALE:Number = 1;
       
      
      public var imgIcon:Image = null;
      
      public var hitMc:MovieClip = null;
      
      public var rareIcon:Image = null;
      
      public var rareBg:Sprite = null;
      
      public var iconInProgress:Sprite = null;
      
      public var iconLockGrey:Sprite = null;
      
      public var frontground:Sprite = null;
      
      public var equippedImg:ImageHitAreaWrapper = null;
      
      public var alertIcon:Image = null;
      
      public var lockedIcon:MovieClip = null;
      
      public var compoundPrice:CompoundPrice = null;
      
      public var counter:CounterView = null;
      
      public var editableSlotHint:MovieClip = null;
      
      public var shadow:MovieClip = null;
      
      public var nonHistoricImg:Image = null;
      
      public var editableImg:Image = null;
      
      public var disabledFill:BitmapFill = null;
      
      public var bg:MovieClip = null;
      
      public var selectedMC:MovieClip = null;
      
      public var newMC:MovieClip = null;
      
      public var hover:MovieClip = null;
      
      public var imgBg:MovieClip = null;
      
      public var rentalIcon:Image = null;
      
      public var rentalTF:TextField = null;
      
      public var storageIcon:Image = null;
      
      public var progressionLevelIcon:MovieClip = null;
      
      public var progressionStylesLevelIcon:MovieClip = null;
      
      public var progressionRewindIcon:MovieClip = null;
      
      public var limitedIcon:Image = null;
      
      public var storageTF:TextField = null;
      
      public var styleNameTF:TextField = null;
      
      public var limitedText:TextField = null;
      
      public var limitedTextIcon:Image = null;
      
      public var isResponsive:Boolean = true;
      
      public var considerWidth:Boolean = false;
      
      public var formIcon:Image = null;
      
      public var btnBackground:MovieClip = null;
      
      public var editBtn:SoundButtonEx = null;
      
      public var editBtnHint:MovieClip = null;
      
      public var editBtnSmall:ButtonIconNormal = null;
      
      public var editBtnCounter:CounterView = null;
      
      public var serialNumberIcon:Image = null;
      
      private var _isWideNewMC:Boolean = false;
      
      private var _data:CustomizationCarouselRendererVO = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _selected:Boolean = false;
      
      private var _index:uint = 0;
      
      private var _owner:UIComponent = null;
      
      private var _buyOperationAllowed:Boolean = true;
      
      private var _styleTfFiltersPreset:Array;
      
      private var _customWidth:int = 0;
      
      private var _customHeight:int = 0;
      
      private var _tweens:Vector.<Tween>;
      
      private var _inventoryFadeTween:Tween = null;
      
      private var _handlersRegistered:Boolean = false;
      
      private var _originalImgWidth:int = 0;
      
      private var _originalImgHeight:int = 0;
      
      private var _scheduler:IScheduler;
      
      private var _soundMgr:ISoundManager;
      
      public function CarouselItemRenderer()
      {
         this._styleTfFiltersPreset = [];
         this._tweens = new Vector.<Tween>();
         this._scheduler = App.utils.scheduler;
         this._soundMgr = App.soundMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hitMc.mouseChildren = this.hitMc.buttonMode = true;
         this.registerHandlers();
         this.bg.mouseChildren = this.bg.mouseEnabled = false;
         this.disabledFill.mouseChildren = this.disabledFill.mouseEnabled = false;
         this.selectedMC.mouseChildren = this.selectedMC.mouseEnabled = false;
         this.hover.mouseChildren = this.hover.mouseEnabled = false;
         this.hover.visible = false;
         this.imgBg.visible = false;
         this.nonHistoricImg.addEventListener(Event.CHANGE,this.onNonHistoricImgChangeHandler);
         this.nonHistoricImg.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_NON_HISTORICAL;
         this.nonHistoricImg.mouseChildren = this.nonHistoricImg.mouseEnabled = true;
         this.nonHistoricImg.buttonMode = true;
         this.nonHistoricImg.addEventListener(MouseEvent.ROLL_OVER,this.onNonHistoricImgRollOverHandler);
         this.nonHistoricImg.addEventListener(MouseEvent.ROLL_OUT,this.onNonHistoricImgRollOutHandler);
         this.nonHistoricImg.visible = false;
         this.editableImg.buttonMode = true;
         this.editableImg.visible = false;
         this.editBtn.addEventListener(MouseEvent.ROLL_OVER,this.onEditBtnRollOverHandler);
         this.editBtn.addEventListener(MouseEvent.ROLL_OUT,this.onEditBtnRollOutHandler);
         this.editBtn.addEventListener(MouseEvent.CLICK,this.onEditBtnClickHandler);
         this.editBtnSmall.addEventListener(MouseEvent.ROLL_OVER,this.onEditBtnRollOverHandler);
         this.editBtnSmall.addEventListener(MouseEvent.ROLL_OUT,this.onEditBtnRollOutHandler);
         this.editBtnSmall.addEventListener(MouseEvent.CLICK,this.onEditBtnClickHandler);
         this.editBtn.mouseEnabledOnDisabled = this.editBtnSmall.mouseEnabledOnDisabled = true;
         this.editBtn.visible = this.editBtnSmall.visible = this.btnBackground.visible = this.editBtnHint.visible = this.editBtnCounter.visible = this.editableSlotHint.visible = false;
         this.editableSlotHint.mouseChildren = this.editBtnCounter.mouseChildren = this.editBtnHint.mouseChildren = this.editableSlotHint.mouseEnabled = this.editBtnCounter.mouseEnabled = this.editBtnHint.mouseEnabled = false;
         this.storageIcon.visible = this.storageTF.visible = false;
         this.storageIcon.addEventListener(Event.CHANGE,this.onStorageIconChangeHandler);
         this.storageIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_STORAGE_ICON;
         this.limitedIcon.mouseEnabled = false;
         this.limitedIcon.visible = false;
         this.limitedIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_STAR;
         this.imgIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.lockedIcon.alpha = LOCKED_LOCK_AND_BONUS_ALPHA;
         this.lockedIcon.mouseEnabled = false;
         this.rentalIcon.mouseEnabled = false;
         this.rentalTF.mouseEnabled = false;
         this.rentalTF.visible = this.rentalIcon.visible = false;
         this.rentalTF.autoSize = TextFieldAutoSize.LEFT;
         this.iconInProgress.visible = false;
         this.iconLockGrey.visible = false;
         this.alertIcon.visible = false;
         this.alertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTICON;
         this.limitedTextIcon.mouseChildren = this.limitedTextIcon.mouseEnabled = false;
         this.limitedTextIcon.visible = false;
         this.limitedTextIcon.source = RES_ICONS.MAPS_ICONS_VEHICLESTATES_UNSUITABLETOUNIT;
         this.equippedImg.visible = false;
         this.equippedImg.mouseEnabled = this.equippedImg.mouseChildren = false;
         this.equippedImg.image.addEventListener(Event.CHANGE,this.onEquippedImgChangeHandler);
         this.rentalIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_CLOCKICON_1;
         TextFieldEx.setVerticalAlign(this.styleNameTF,TextFieldEx.VALIGN_CENTER);
         this.storageTF.autoSize = TextFieldAutoSize.LEFT;
         TextFieldEx.setVerticalAlign(this.limitedText,TextFieldEx.VALIGN_CENTER);
         this.limitedText.autoSize = TextFieldAutoSize.LEFT;
         this.limitedText.mouseEnabled = false;
         this.limitedText.visible = false;
         this.rareIcon.visible = false;
         this.rareIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_BRUSH_RARE;
         this.rareIcon.mouseEnabled = this.rareIcon.mouseChildren = false;
         this.rareBg.mouseEnabled = this.rareBg.mouseChildren = false;
         this.formIcon.mouseEnabled = this.formIcon.mouseChildren = false;
         this._styleTfFiltersPreset = this.styleNameTF.filters;
         this.serialNumberIcon.mouseEnabled = false;
         this.serialNumberIcon.visible = false;
         this.serialNumberIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_SERIAL_NUMBER;
      }
      
      override protected function onBeforeDispose() : void
      {
         this._scheduler.cancelTask(this.resetCounter);
         this.unregisterHandlers();
         this.nonHistoricImg.removeEventListener(MouseEvent.ROLL_OVER,this.onNonHistoricImgRollOverHandler);
         this.nonHistoricImg.removeEventListener(MouseEvent.ROLL_OUT,this.onNonHistoricImgRollOutHandler);
         this.nonHistoricImg.removeEventListener(Event.CHANGE,this.onNonHistoricImgChangeHandler);
         this.imgIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.equippedImg.removeEventListener(MouseEvent.ROLL_OVER,this.onEquippedImgRollOverHandler);
         this.equippedImg.removeEventListener(MouseEvent.ROLL_OUT,this.onEquippedImgRollOutHandler);
         this.equippedImg.image.removeEventListener(Event.CHANGE,this.onEquippedImgChangeHandler);
         this.editBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onEditBtnRollOverHandler);
         this.editBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onEditBtnRollOutHandler);
         this.editBtn.removeEventListener(MouseEvent.CLICK,this.onEditBtnClickHandler);
         this.editBtnSmall.removeEventListener(MouseEvent.ROLL_OVER,this.onEditBtnRollOverHandler);
         this.editBtnSmall.removeEventListener(MouseEvent.ROLL_OUT,this.onEditBtnRollOutHandler);
         this.editBtnSmall.removeEventListener(MouseEvent.CLICK,this.onEditBtnClickHandler);
         this.storageIcon.removeEventListener(Event.CHANGE,this.onStorageIconChangeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Tween = null;
         this._toolTipMgr = null;
         this.clearNewMC();
         this.imgIcon.dispose();
         this.imgIcon = null;
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.equippedImg.dispose();
         this.equippedImg = null;
         this.frontground = null;
         this.imgBg = null;
         this.lockedIcon = null;
         this.iconInProgress = null;
         this.iconLockGrey = null;
         this.compoundPrice.dispose();
         this.compoundPrice = null;
         this.counter.dispose();
         this.counter = null;
         this.shadow = null;
         this.hover = null;
         this.disabledFill.dispose();
         this.disabledFill = null;
         this.editableSlotHint = null;
         this.bg = null;
         this.selectedMC = null;
         this.nonHistoricImg.dispose();
         this.nonHistoricImg = null;
         this.editableImg.dispose();
         this.editableImg = null;
         this.editBtn.dispose();
         this.editBtn = null;
         this.editBtnSmall.dispose();
         this.editBtnSmall = null;
         this.editBtnCounter.dispose();
         this.editBtnCounter = null;
         this.btnBackground = null;
         this.editBtnHint = null;
         this.limitedIcon.dispose();
         this.limitedIcon = null;
         this.rentalIcon.dispose();
         this.limitedTextIcon.dispose();
         this.limitedTextIcon = null;
         this.formIcon.dispose();
         this.formIcon = null;
         this.rareIcon.dispose();
         this.rareIcon = null;
         this.rareBg = null;
         this._data = null;
         this._owner = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
         this._tweens = null;
         if(this._inventoryFadeTween)
         {
            this._inventoryFadeTween.dispose();
            this._inventoryFadeTween = null;
         }
         this.styleNameTF = null;
         this.limitedText = null;
         this.rentalIcon = null;
         this.rentalTF = null;
         this.storageIcon.dispose();
         this.storageIcon = null;
         this.storageTF = null;
         this.hitMc = null;
         this.progressionLevelIcon = null;
         this.progressionStylesLevelIcon = null;
         this.progressionRewindIcon = null;
         this.serialNumberIcon.dispose();
         this.serialNumberIcon = null;
         this._styleTfFiltersPreset.length = 0;
         this._styleTfFiltersPreset = null;
         this._scheduler = null;
         this._soundMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:PriceVO = null;
         var _loc2_:PriceVO = null;
         var _loc3_:PriceVO = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.applyData();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            _loc1_ = new PriceVO([CURRENCIES_CONSTANTS.GOLD,int(this._buyOperationAllowed)]);
            _loc2_ = new PriceVO([CURRENCIES_CONSTANTS.CREDITS,int(this._buyOperationAllowed)]);
            _loc3_ = new PriceVO([CURRENCIES_CONSTANTS.CRYSTAL,int(this._buyOperationAllowed)]);
            this.compoundPrice.updateEnoughStatuses(new <PriceVO>[_loc1_,_loc2_,_loc3_]);
         }
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      public function setImageSize() : void
      {
         this.setImageIconTransform();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function applyData() : void
      {
         var _loc5_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc1_:Boolean = this._data != null && this._data.intCD;
         var _loc2_:Boolean = this.isResponsive && App.appHeight < MIN_HEIGHT_RESOLUTION;
         if(this.considerWidth && !_loc2_)
         {
            _loc2_ = this.isResponsive && App.appWidth <= MIN_WIDTH_RESOLUTION;
         }
         var _loc3_:Rectangle = CustomizationShared.computeItemSize(Boolean(this._data) ? Boolean(this._data.isWide) : Boolean(false),_loc2_);
         this._customWidth = _loc3_.width;
         this._customHeight = _loc3_.height;
         this.hitMc.width = this.bg.width = this._customWidth;
         this.hitMc.height = this.bg.height = this._customHeight;
         this.shadow.width = this.bg.width - (IMAGE_MARGIN << 1);
         this.shadow.height = this.bg.height * SHADOW_SCALE;
         this.hover.width = this.bg.width - (IMAGE_MARGIN << 1);
         this.hover.height = this.bg.height - (IMAGE_MARGIN << 1);
         this.imgIcon.cacheType = ImageCacheTypes.USE_WEB_CACHE;
         this.setEnable(_loc1_);
         if(!_loc1_)
         {
            this.imgIcon.source = null;
            this.disabledFill.visible = false;
            this.lockedIcon.visible = false;
            this.imgIcon.alpha = Boolean(this._data) ? Number(this._data.defaultIconAlpha) : Number(Values.DEFAULT_ALPHA);
            this.counter.visible = false;
            this.imgBg.visible = false;
            this.editBtn.visible = false;
            this.editBtnSmall.visible = false;
            this.btnBackground.visible = false;
            this.editableSlotHint.visible = false;
            this.editBtnCounter.visible = false;
            this.editBtnHint.visible = false;
            return;
         }
         this.editBtn.enabled = this.editBtnSmall.enabled = this._data.editBtnEnabled;
         this.editBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_SLOT_EDITSTYLE;
         this.editBtn.visible = this._data.isEquipped && (this._data.isEditableStyle && !_loc2_);
         this.editBtn.x = (_loc3_.width >> 1) - (this.editBtn.width >> 1);
         this.buttonBackgroundPosition(this.editBtn);
         this.editBtnSmall.iconSource = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_EDIT_BTN;
         this.editBtnSmall.container.alpha = !!this.editBtnSmall.enabled ? Number(SoundButton.ENABLED_ALPHA) : Number(SoundButton.DISABLED_ALPHA);
         this.editBtnSmall.visible = this._data.isEquipped && (this._data.isEditableStyle && _loc2_);
         this.editBtnSmall.x = (_loc3_.width >> 1) - (this.editBtnSmall.width >> 1);
         this.buttonBackgroundPosition(this.editBtnSmall);
         this.btnBackground.visible = this.editBtn.visible || this.editBtnSmall.visible;
         this.editBtnCounter.visible = (this.editBtn.visible || this.editBtnSmall.visible) && this._data.editNoveltyCounter > 0;
         if(this.editBtnCounter.visible)
         {
            this.editBtnCounter.setCount(this._data.editNoveltyCounter.toString());
            this.editBtnCounter.x = !!this.editBtn.visible ? Number(this.editBtn.x + this.editBtn.width) : Number(this.editBtnSmall.x + this.editBtnSmall.width);
            this.editBtnCounter.x += EDIT_BTN_COUNTER_OFFSET_X;
            this.editBtnCounter.y = !!this.editBtn.visible ? Number(this.editBtn.y) : Number(this.editBtnSmall.y);
            this.editBtnCounter.y += EDIT_BTN_COUNTER_OFFSET_Y;
         }
         if(this._data.customizationDisplayType == CUSTOMIZATION_CONSTS.NON_HISTORICAL_TYPE)
         {
            this.nonHistoricImg.source = !!_loc2_ ? RES_ICONS.MAPS_ICONS_CUSTOMIZATION_NON_HISTORICAL_MINI : RES_ICONS.MAPS_ICONS_CUSTOMIZATION_NON_HISTORICAL;
         }
         else if(this._data.customizationDisplayType == CUSTOMIZATION_CONSTS.FANTASTICAL_TYPE)
         {
            this.nonHistoricImg.source = !!_loc2_ ? RES_ICONS.MAPS_ICONS_CUSTOMIZATION_FANTASTICAL_MINI : RES_ICONS.MAPS_ICONS_CUSTOMIZATION_FANTASTICAL;
         }
         this.editableImg.source = !!_loc2_ ? this._data.editableIcon : this._data.editableIconBig;
         if(this._data.isDarked)
         {
            this.frontground.width = this._customWidth;
            this.frontground.height = this._customHeight;
            this.frontground.visible = true;
            buttonMode = true;
         }
         else
         {
            this.frontground.visible = false;
         }
         this.editableSlotHint.visible = this._data.showEditableHint;
         this.editBtnHint.visible = this.btnBackground.visible && this._data.showEditBtnHint;
         if(this.editBtnHint.visible)
         {
            this.editBtnHint.play();
         }
         this.disabledFill.visible = this._data.locked;
         this.lockedIcon.visible = this._data.locked && !this._data.isLinked;
         this.iconLockGrey.visible = this._data.locked && this._data.isLinked;
         this.iconLockGrey.x = this.lockedIcon.x = this._customWidth - this.lockedIcon.width - ICON_PADDING_RIGHT;
         this.iconLockGrey.y = this._customHeight - this.iconLockGrey.height + ICON_LOCK_GREY_BOTTOM_OFFSET;
         this.iconInProgress.visible = this._data.isInProgress;
         this.iconInProgress.x = this._customWidth - this.iconInProgress.width >> 1;
         this.iconInProgress.y = this._customHeight - this.iconInProgress.height >> 1;
         this.counter.visible = this._data.noveltyCounter > 0;
         if(this.counter.visible)
         {
            this.counter.setCount(this._data.noveltyCounter.toString());
            this.counter.x = this._customWidth + COUNTER_OFFSET | 0;
         }
         this.limitedIcon.visible = this._data.isSpecial;
         this.rareIcon.visible = this.rareBg.visible = this._data.showRareIcon;
         this.imgBg.visible = this._data.isDim;
         if(this.imgBg.visible)
         {
            this.imgBg.width = this._customWidth;
            this.imgBg.height = this._customHeight;
         }
         this.selectedMC.width = this.shadow.width + SELECTED_WIDTH_OFFSET;
         this.selectedMC.height = this.bg.height + SELECTED_HEIGHT_OFFSET;
         if(_loc2_)
         {
            this.selectedMC.x = !!this._data.isWide ? Number(SELECTED_MIN_RES_WIDE_X) : Number(SELECTED_MIN_RES_SMALL_X);
            this.selectedMC.y = SELECTED_MIN_RES_Y;
         }
         else
         {
            this.selectedMC.x = !!this._data.isWide ? Number(SELECTED_WIDE_X) : Number(SELECTED_SMALL_X);
            this.selectedMC.y = SELECTED_Y;
         }
         this.disabledFill.width = this.shadow.width;
         this.disabledFill.height = this.bg.height - (IMAGE_MARGIN << 1);
         this.disabledFill.widthFill = this.shadow.width;
         this.disabledFill.heightFill = this.bg.height - (IMAGE_MARGIN << 1);
         this.imgIcon.scaleX = this.imgIcon.scaleY = 1;
         this.imgIcon.source = this._data.icon;
         this.setImageIconTransform();
         this.nonHistoricImg.visible = this._data.customizationDisplayType != CUSTOMIZATION_CONSTS.HISTORICAL_TYPE;
         if(this.nonHistoricImg.visible)
         {
            this.nonHistoricImg.alpha = !!this._data.locked ? Number(LOCKED_IMG_ALPHA) : Number(1);
         }
         this.editableImg.visible = this._data.isEditableStyle;
         this.nonHistoricImgPosition();
         this.imgIcon.alpha = !!this._data.locked ? Number(LOCKED_IMG_ALPHA) : Number(this._data.defaultIconAlpha);
         this.alertIcon.visible = this._data.showAlert;
         this.formIcon.y = !!_loc2_ ? Number(FORM_ICON_OFFSET_SMALL_Y) : Number(FORM_ICON_OFFSET_Y);
         this.formIcon.visible = StringUtils.isNotEmpty(this._data.formIconSource);
         this.formIcon.source = this._data.formIconSource;
         if(this._data.isNew)
         {
            if(!this.newMC || this._isWideNewMC != this._data.isWide)
            {
               this.clearNewMC();
               this.newMC = App.utils.classFactory.getComponent(!!this._data.isWide ? BORDER_NEW_WIDE_UI : BORDER_NEW_UI,MovieClip);
               this.newMC.mouseEnabled = this.newMC.mouseChildren = false;
               addChild(this.newMC);
               this.newMC.addFrameScript(this.newMC.totalFrames - 1,this.newMCframeScriptFunction);
               this._isWideNewMC = this._data.isWide;
               dispatchEvent(new CustomizationEvent(CustomizationEvent.NEW_ANIMATION_SHOWN,false,this._data.intCD));
               this._data.isNew = false;
            }
            this.newMC.gotoAndPlay(1);
         }
         else
         {
            this.clearNewMC();
         }
         if(this.newMC)
         {
            this.newMC.scaleX = this.newMC.scaleY = !!_loc2_ ? Number(NEW_MC_MIN_SCALE) : Number(NEW_MC_NORMAL_SCALE);
         }
         var _loc4_:Boolean = this._data.isProgressionRewindEnabled;
         _loc5_ = this._data.typeId == GUI_ITEM_TYPES.STYLE;
         var _loc6_:Boolean = _loc5_ || this._data.isLinked;
         this.progressionStylesLevelIcon.visible = _loc6_;
         this.progressionLevelIcon.visible = !_loc6_;
         var _loc7_:MovieClip = !!_loc6_ ? this.progressionStylesLevelIcon : this.progressionLevelIcon;
         var _loc8_:String = this._data.progressionLevel.toString().concat(!!_loc2_ ? PROGRESSION_ICON_SMALL_LABEL_POSTFIX : PROGRESSION_ICON_BIG_LABEL_POSTFIX);
         _loc7_.gotoAndStop(_loc8_);
         _loc7_.visible = this._data.progressionLevel >= 0 && (this._data.isLinked || !_loc4_);
         this.serialNumberIcon.visible = this._data.isWithSerialNumber;
         var _loc9_:int = 0;
         var _loc10_:int = !!_loc2_ ? int(PROGRESSION_LEVEL_GAP_SMALL) : int(PROGRESSION_LEVEL_GAP);
         if(this.serialNumberIcon.visible)
         {
            _loc9_ = this.serialNumberIcon.x + this.serialNumberIcon.width + SERIAL_NUMBER_GAP;
         }
         if(_loc7_.visible)
         {
            _loc9_ = _loc7_.x + _loc7_.width + _loc10_;
            _loc7_.alpha = !!this._data.locked ? Number(LOCKED_IMG_ALPHA) : Number(1);
            if(this._data.locked)
            {
               addChildAt(_loc7_,getChildIndex(this.disabledFill) + 1);
            }
         }
         this.progressionRewindIcon.visible = _loc4_;
         if(_loc4_)
         {
            this.progressionRewindIcon.gotoAndStop(!!_loc2_ ? PROGRESSION_REWIND_SMALL_LABEL : PROGRESSION_REWIND_BIG_LABEL);
            _loc9_ = this.progressionRewindIcon.x + this.progressionRewindIcon.width + _loc10_;
         }
         if(this.editableSlotHint.visible)
         {
            this.editableSlotHint.x = _loc9_ + EDITABLE_BG_X;
         }
         if(this.editableImg.visible)
         {
            this.editableImg.x = _loc9_ + EDITABLE_IMG_X;
            _loc9_ = this.editableImg.x + EDITABLE_IMG_WIDTH + EDITABLE_IMG_GAP;
         }
         if(this.limitedIcon.visible)
         {
            this.limitedIcon.x = _loc9_;
            _loc9_ = this.limitedIcon.x + this.limitedIcon.width + LIMITED_ICON_GAP;
         }
         if(this.alertIcon.visible)
         {
            this.alertIcon.x = _loc9_ + ALERT_ICON_X;
         }
         if(this._data.isEquipped)
         {
            this.equippedImg.visible = true;
            this.equippedImg.source = !!this._data.isChained ? RES_ICONS.MAPS_ICONS_CUSTOMIZATION_CHAINED_SLOT : RES_ICONS.MAPS_ICONS_CUSTOMIZATION_EQUIPPED_SLOT;
            this.equippedImg.buttonMode = this._data.isChained;
            this.equippedImg.mouseEnabled = this.equippedImg.mouseChildren = this._data.isChained;
            if(this._data.isChained)
            {
               this.equippedImg.addEventListener(MouseEvent.ROLL_OVER,this.onEquippedImgRollOverHandler);
               this.equippedImg.addEventListener(MouseEvent.ROLL_OUT,this.onEquippedImgRollOutHandler);
            }
            this.equippedImgPosition();
         }
         else
         {
            this.equippedImg.visible = false;
         }
         this.compoundPrice.visible = false;
         this.compoundPrice.itemsDirection = CompoundPrice.DIRECTION_UP;
         this.compoundPrice.itemsAnchor = CompoundPrice.ANCHOR_BOTTOM_RIGHT;
         this.compoundPrice.priceIconOffset = PRICE_ICON_OFFSET;
         this.compoundPrice.priceActionOffset = PRICE_BG_OFFSET;
         this.styleNameTF.visible = StringUtils.isNotEmpty(this._data.styleName);
         if(this.styleNameTF.visible)
         {
            this.styleNameTF.alpha = Values.DEFAULT_ALPHA;
            this.styleNameTF.htmlText = !!_loc2_ ? this._data.styleNameSmall : this._data.styleName;
            this.styleNameTF.filters = !!_loc2_ ? [] : this._styleTfFiltersPreset;
         }
         this.styleNameTF.y = STYLE_NAME_TF_V_POS + int(_loc2_) * STYLE_NAME_TF_V_OFFSET;
         this.styleNameTF.width = !!_loc2_ ? Number(STYLE_NAME_TF_WIDE_SMALL_WIDTH) : Number(STYLE_NAME_TF_WIDE_WIDTH);
         this.limitedText.visible = false;
         this.limitedTextIcon.visible = false;
         if(this._data.isAlreadyUsed)
         {
            this.imgIcon.alpha = this._data.defaultIconAlpha;
            this.frontground.visible = false;
            this.styleNameTF.alpha = ALREADY_USED_STYLE_NAME_ALPHA;
            this.lockedIcon.visible = false;
            this.limitedTextIcon.visible = true;
            if(this._data.isWide)
            {
               this.limitedText.visible = true;
               this.updateLimitedText(this._data.lockText,LIMITED_TEXT_SIZE_LOCKED);
            }
            this.updateLimitedIconTextLayout(this._data.isWide);
         }
         if(this._data.isUnsuitable)
         {
            this.imgIcon.alpha = LOCKED_IMG_ALPHA;
            this.styleNameTF.alpha = ALREADY_USED_STYLE_NAME_ALPHA;
            _loc7_.alpha = LOCKED_IMG_ALPHA;
            this.nonHistoricImg.alpha = LOCKED_IMG_ALPHA;
            this.lockedIcon.visible = false;
            this.disabledFill.visible = true;
            this.limitedText.visible = true;
            this.limitedTextIcon.visible = true;
            this.updateLimitedText(this._data.lockText,LIMITED_TEXT_SIZE_UNSUITABLE);
            this.updateLimitedIconTextLayout(this._data.isWide);
         }
         if(this._data.buyPrice)
         {
            this.compoundPrice.setData(this._data.buyPrice);
            this.compoundPrice.validateNow();
            this.buyOperationAllowed = this._data.buyOperationAllowed;
            this.compoundPrice.visible = StringUtils.isEmpty(this._data.quantity);
            if(this.compoundPrice.visible)
            {
               _loc11_ = this._data.buyPrice.action != null;
               _loc12_ = !!_loc2_ ? int(0) : int(-ICON_PADDING_RIGHT);
               _loc13_ = !!_loc11_ ? int(ACTION_ICON_PADDING_RIGHT) : int(0);
               _loc14_ = _loc11_ && _loc2_ ? int(ACTION_MIN_RES_OFFSET) : int(0);
               this.compoundPrice.x = this._customWidth + _loc12_ + _loc13_ + _loc14_;
               this.compoundPrice.y = this._customHeight;
            }
         }
         if(this._data.isRental)
         {
            if(StringUtils.isNotEmpty(this._data.quantity))
            {
               this.rentalTF.visible = this.rentalIcon.visible = true;
               this.storageIcon.visible = this.storageTF.visible = false;
               this.rentalTF.text = this._data.quantity.toString();
               _loc15_ = this._customWidth - this.rentalTF.textWidth - RENTAL_TF_PADDING_RIGHT;
               this.rentalTF.x = _loc15_;
               this.rentalTF.y = this._customHeight - this.rentalTF.height ^ 0;
               this.rentalIcon.x = _loc15_ - RENTAL_ICON_SIZE + RENTAL_ICON_OFFSET_X;
               this.rentalIcon.y = this._customHeight - RENTAL_ICON_SIZE + RENTAL_ICON_OFFSET_Y;
               this.rentalIcon.source = !!this._data.autoRentEnabled ? RES_ICONS.MAPS_ICONS_CUSTOMIZATION_ICON_RENT : RES_ICONS.MAPS_ICONS_LIBRARY_CLOCKICON_1;
            }
            else
            {
               this.rentalTF.visible = false;
               this.rentalIcon.visible = false;
               this.storageIcon.visible = false;
               this.storageTF.visible = true;
               this.compoundPrice.validateNow();
               this.storageTF.htmlText = this._data.rentalInfoText;
               this.storageTF.x = this.compoundPrice.x - this.compoundPrice.contentWidth - this.storageTF.width ^ 0;
               this.storageTF.y = this._customHeight - this.storageTF.height ^ 0;
               this.storageIcon.y = this._customHeight - this.storageIcon.height ^ 0;
            }
         }
         else if(StringUtils.isNotEmpty(this._data.quantity))
         {
            this.rentalTF.visible = this.rentalIcon.visible = false;
            this.storageIcon.visible = this.storageTF.visible = true;
            this.storageTF.text = this._data.quantity.toString();
            this.layoutStorageInfo();
         }
         else
         {
            this.rentalTF.visible = this.rentalIcon.visible = false;
            this.storageIcon.visible = this.storageTF.visible = false;
         }
         if(!this._data.showDetailItems)
         {
            this.rentalTF.visible = this.rentalIcon.visible = false;
            this.storageIcon.visible = this.storageTF.visible = false;
         }
         if(this._data.isPlaceHolder)
         {
            alpha = PLACEHOLDER_ALPHA;
         }
      }
      
      private function newMCframeScriptFunction() : void
      {
         this.clearNewMC();
      }
      
      private function clearNewMC() : void
      {
         if(this.newMC)
         {
            removeChild(this.newMC);
            this.newMC.addFrameScript(this.newMC.totalFrames - 1,null);
            this.newMC = null;
         }
      }
      
      private function buttonBackgroundPosition(param1:SoundButtonEx) : void
      {
         if(!param1.visible)
         {
            return;
         }
         this.btnBackground.x = param1.x;
         this.btnBackground.y = param1.y;
         this.btnBackground.width = param1.width;
         this.btnBackground.height = param1.height;
         this.editBtnHint.gotoAndStop(1);
         this.editBtnHint.x = param1.x + (param1.width >> 1);
         this.editBtnHint.y = param1.y + (param1.height >> 1);
         this.editBtnHint.width = param1.width;
         this.editBtnHint.height = param1.height;
      }
      
      private function equippedImgPosition() : void
      {
         this.equippedImg.x = this.shadow.width - this.equippedImg.width >> 1;
         this.equippedImg.y = -this.equippedImg.height >> 1;
      }
      
      private function registerHandlers() : void
      {
         if(!this._handlersRegistered)
         {
            this.hitMc.addEventListener(MouseEvent.CLICK,this.onClickHandler);
            this.hitMc.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.hitMc.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this._handlersRegistered = true;
         }
      }
      
      private function unregisterHandlers() : void
      {
         if(this._handlersRegistered)
         {
            this.hitMc.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            this.hitMc.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.hitMc.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this._handlersRegistered = false;
         }
      }
      
      private function setEnable(param1:Boolean) : void
      {
         if(enabled != param1)
         {
            enabled = param1;
            this.imgIcon.visible = param1;
         }
      }
      
      private function setImageIconTransform() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._originalImgWidth != 0 && this._originalImgHeight != 0 && this._customWidth != 0 && this._customHeight != 0)
         {
            _loc1_ = this._customWidth - (IMAGE_MARGIN << 1);
            _loc2_ = this._customHeight - (IMAGE_MARGIN << 1);
            _loc3_ = Math.min(Math.min(_loc1_ / this._originalImgWidth,_loc2_ / this._originalImgHeight),1) * this._data.scale;
            this.imgIcon.width = this._originalImgWidth * _loc3_ | 0;
            this.imgIcon.height = this._originalImgHeight * _loc3_ | 0;
            this.imgIcon.x = this._customWidth - this.imgIcon.width >> 1;
            this.imgIcon.y = this._customHeight - this.imgIcon.height >> 1;
         }
      }
      
      private function showItemTooltip() : void
      {
         this.tooltipDecorator.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM,null,this._data.intCD,-1,true,this._data.progressionLevel);
         this._soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.CUSTOMIZATION_DEFAULT,null);
      }
      
      private function layoutStorageInfo() : void
      {
         if(this._data && !this._data.isRental)
         {
            this.storageTF.x = this._customWidth - this.storageTF.width - STORAGE_OFFSET ^ 0;
            this.storageIcon.x = this.storageTF.x - this.storageIcon.width + ICON_PADDING_RIGHT ^ 0;
         }
         this.storageTF.y = this._customHeight - this.storageTF.height ^ 0;
         this.storageIcon.y = this._customHeight - this.storageIcon.height ^ 0;
      }
      
      private function resetCounter() : void
      {
         if(this.counter.visible)
         {
            this.counter.visible = false;
            dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.SEEN_ITEM,this._data.intCD));
         }
      }
      
      private function updateLimitedText(param1:String, param2:int) : void
      {
         this.limitedText.width = this._customWidth;
         this.limitedText.htmlText = param1;
         this.limitedText.autoSize = TextFieldAutoSize.LEFT;
         var _loc3_:TextFormat = this.limitedText.getTextFormat();
         _loc3_.size = param2;
         this.limitedText.setTextFormat(_loc3_);
         this.limitedText.width = this.limitedText.textWidth + TEXTFIELD_PADDING;
      }
      
      private function updateLimitedIconTextLayout(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = this._customWidth - LIMITED_TEXT_ICON_SIZE - this.limitedText.width >> 1;
            this.limitedTextIcon.y = this._customHeight - LIMITED_TEXT_ICON_SIZE >> 1;
            this.limitedTextIcon.x = _loc2_;
            this.limitedText.y = this._customHeight - this.limitedText.height >> 1;
            this.limitedText.x = this.limitedTextIcon.x + LIMITED_TEXT_ICON_SIZE;
         }
         else
         {
            this.limitedTextIcon.x = this._customWidth - LIMITED_TEXT_ICON_SIZE >> 1;
            this.limitedTextIcon.y = this._customHeight - LIMITED_TEXT_ICON_SIZE >> 1;
            if(this.limitedText.visible)
            {
               this.limitedTextIcon.y += LIMITED_ICON_OFFSET_Y;
               this.limitedText.x = this._customWidth - this.limitedText.width >> 1;
               this.limitedText.y = this.limitedTextIcon.y + LIMITED_TEXT_OFFSET_Y;
            }
         }
      }
      
      private function nonHistoricImgPosition() : void
      {
         this.nonHistoricImg.x = this.shadow.width - this.nonHistoricImg.width + NON_HISTORIC_OFFSET >> 0;
      }
      
      public function set buyOperationAllowed(param1:Boolean) : void
      {
         this._buyOperationAllowed = param1;
         invalidateState();
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this.selectedMC.visible = param1;
         if(this._selected != param1)
         {
            this._selected = param1;
            if(this._selected)
            {
               this._scheduler.cancelTask(this.resetCounter);
               this.resetCounter();
            }
         }
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         if(param1)
         {
            this._data = CustomizationCarouselRendererVO(param1);
            invalidateData();
         }
         else
         {
            this.compoundPrice.visible = false;
         }
      }
      
      public function get tooltipDecorator() : ITooltipMgr
      {
         if(this._toolTipMgr != null)
         {
            return this._toolTipMgr;
         }
         return App.toolTipMgr;
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
         this._toolTipMgr = param1;
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
      }
      
      public function get getCursorType() : String
      {
         return Cursors.HAND;
      }
      
      public function get isLocked() : Boolean
      {
         return this._data.locked;
      }
      
      public function get rowsCount() : int
      {
         return Values.ZERO;
      }
      
      public function set rowsCount(param1:int) : void
      {
      }
      
      public function get adaptiveSize() : String
      {
         return ScrollerItemRendererSize.NORMAL_SIZE;
      }
      
      private function onNonHistoricImgChangeHandler(param1:Event = null) : void
      {
         this.nonHistoricImgPosition();
      }
      
      private function onNonHistoricImgRollOutHandler(param1:MouseEvent) : void
      {
         this.tooltipDecorator.hide();
      }
      
      private function onNonHistoricImgRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = this._data.customizationDisplayType == CUSTOMIZATION_CONSTS.FANTASTICAL_TYPE ? TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_FANTASTICAL_ITEM : TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_NONHISTORIC_ITEM;
         this.tooltipDecorator.showSpecial(_loc2_,null);
      }
      
      private function onEquippedImgRollOutHandler(param1:MouseEvent) : void
      {
         this.tooltipDecorator.hide();
      }
      
      private function onEquippedImgRollOverHandler(param1:MouseEvent) : void
      {
         this.tooltipDecorator.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_CHAINED_ITEM,null);
      }
      
      private function onEditBtnRollOutHandler(param1:MouseEvent) : void
      {
         this.tooltipDecorator.hide();
      }
      
      private function onEditBtnRollOverHandler(param1:MouseEvent) : void
      {
         this.tooltipDecorator.show(this._data.tooltip);
      }
      
      private function onEquippedImgChangeHandler(param1:Event) : void
      {
         this.equippedImgPosition();
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         this._originalImgWidth = this.imgIcon.width;
         this._originalImgHeight = this.imgIcon.height;
         this.setImageSize();
      }
      
      private function onStorageIconChangeHandler(param1:Event) : void
      {
         this.layoutStorageInfo();
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:uint = this.getPressedButtonIndex(param1);
         if(_loc2_ == MouseEventEx.LEFT_BUTTON && this._data.locked && !this._data.isLinked)
         {
            param1.stopImmediatePropagation();
         }
         else if(_loc2_ == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.SELECT_ITEM,this._index,this._data.intCD,this._data.progressionLevel));
         }
         else if(_loc2_ == MouseEventEx.RIGHT_BUTTON)
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.CUSTOMIZATION_ITEM,this,{
               "itemID":this._data.intCD,
               "itemType":this._data.typeId,
               "itemIndex":this._index
            });
         }
         this.tooltipDecorator.hide();
         this._soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.CUSTOMIZATION_DEFAULT,null);
      }
      
      private function onEditBtnClickHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(this._data.editBtnEnabled && this.getPressedButtonIndex(param1) == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.EDIT_ITEM,this._data.intCD));
         }
      }
      
      private function getPressedButtonIndex(param1:MouseEvent) : uint
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         return _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.hover.visible = false;
         this.tooltipDecorator.hide();
         this._scheduler.cancelTask(this.resetCounter);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.hover.visible = true;
         this.showItemTooltip();
         this._scheduler.scheduleTask(this.resetCounter,RESET_COUNTER_DELAY);
      }
   }
}
