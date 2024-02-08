package net.wg.gui.lobby.storage.categories.cards
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.data.constants.generated.SLOT_HIGHLIGHT_TYPES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.components.controls.ButtonIconNormal;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.VO.CompoundPriceVO;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   import net.wg.gui.lobby.storage.categories.cards.configs.CardConfigs;
   import net.wg.gui.lobby.storage.categories.cards.configs.CardImageSizeVO;
   import net.wg.gui.lobby.storage.categories.cards.configs.CardSizeVO;
   import net.wg.gui.lobby.storage.categories.storage.ExtraParams;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import net.wg.utils.IStageSizeDependComponent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.motion.Tween;
   
   [Event(name="showContextMenu",type="net.wg.gui.lobby.storage.categories.cards.CardEvent")]
   [Event(name="sell",type="net.wg.gui.lobby.storage.categories.cards.CardEvent")]
   public class BaseCard extends UIComponentEx implements IStageSizeDependComponent, IScrollerItemRenderer, ISoundable
   {
      
      protected static const FIRST_ANIMATION_DURATION:Number = 200;
      
      protected static const HALF_FIRST_ANIMATION_DURATION:Number = 100;
      
      protected static const FLAG_SIZE:Rectangle = new Rectangle(0,0,205,171);
      
      protected static const DISCOUNT_OFFSET:int = 2;
      
      protected static const ROLL_OVER_ANIMATION_DELAY:int = 300;
      
      protected static const SELL_BUTTON_MIN_WIDTH:int = 84;
      
      protected static const BORDER_OFFSET:Number = 0.5;
      
      protected static const BORDER_CORNER_RADIUS:int = 2;
      
      protected static const OVERLAY_OFFSET:int = 1;
      
      protected static const ININVENTORY_ICON_OFFSET:int = 2;
      
      protected static const BORDER_SIZE_CORRECTION:Number = 2.5;
      
      protected static const OVERLAY_SIZE_CORRECTION:int = 3;
      
      private static const CANNOT_SELL_ICON_V_OFFSET:int = 1;
      
      private static const TOOLTIP_ACTION_PRICE_FIELD_NAME_ITEM:String = "item";
      
      private static const DISPLAY_OBJECT_NAME_OVERLAY:String = "overlay";
      
      private static const DISPLAY_OBJECT_NAME_CONTAINER:String = "container";
      
      private static const FRAME_LABEL_CONNECTOR:String = "_";
      
      private static const FLAG_HOVER_ALPHA:Number = 0.7;
      
      private static const SMALL_BUTTON_WIDTH:int = 45;
      
      private static const GAP_BUTTONS:int = -5;
      
      private static const SPECIALIZATION_X:int = -5;
      
      private static const SPECIALIZATION_Y:int = -12;
      
      private static const SPECIALIZATION_GAP:int = 32;
      
      private static const EXTRA_PARAMS_GAP:int = -4;
      
      private static const EXTRA_PARAMS_SMALL_CARD_MAX_NUM:int = 3;
      
      private static const EXTRA_PARAMS_BIG_CARD_MAX_NUM:int = 4;
      
      private static const CARD_SMALL_WIDTH:int = 280;
      
      private static const DESCRIPTION_SMALL_CARD_MAX_LINES:uint = 2;
      
      private static const DESCRIPTION_BIG_CARD_MAX_LINES:uint = 3;
      
      private static const DESCRIPTION_TRANCATION_SYMBOL:String = "...";
      
      private static const TOOLTIP_HIT_AREA_NAME:String = "tooltipHitArea";
       
      
      public var inInventoryIcon:MovieClip;
      
      public var discountIcon:MovieClip;
      
      public var equipmentType:MovieClip;
      
      public var price:IconText;
      
      public var titleTF:TextField;
      
      public var descriptionTF:TextField;
      
      public var inInventoryCountTF:TextField;
      
      public var cannotSellTF:TextField;
      
      public var cannotSellIcon:MovieClip;
      
      public var sellButton:BlackButton;
      
      public var upgradeButton:ButtonIconNormal;
      
      public var image:Image;
      
      public var flags:Image;
      
      public var specialization:GroupEx;
      
      public var extraParams:ExtraParams;
      
      protected var _container:Sprite;
      
      protected var _overlay:Sprite;
      
      protected var _tweens:Vector.<Tween>;
      
      protected var _data:BaseCardVO;
      
      protected var _sizeVO:CardSizeVO;
      
      protected var _imageSizeVO:CardImageSizeVO;
      
      protected var _isOver:Boolean;
      
      protected var _resetViewOnDataChange:Boolean = true;
      
      protected var _stageWidthBoundary:int;
      
      private var _tooltipHitArea:Sprite = null;
      
      private var _index:uint;
      
      public function BaseCard()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         alpha = 0;
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(dispatchEvent);
         if(App.soundMgr != null)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         this.disposeTooltipHitArea();
         this.disposeTweens();
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         if(this.flags)
         {
            this.flags.removeEventListener(Event.CHANGE,this.onFlagsChangeHandler);
            this.flags.dispose();
            this.flags = null;
         }
         this.inInventoryIcon = null;
         this.discountIcon = null;
         this.equipmentType = null;
         this.sellButton.dispose();
         this.sellButton = null;
         if(this.upgradeButton != null)
         {
            this.upgradeButton.dispose();
            this.upgradeButton = null;
         }
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         if(this.price)
         {
            this.price.dispose();
            this.price = null;
         }
         if(this.specialization)
         {
            this.specialization.dispose();
            this.specialization = null;
         }
         if(this.extraParams)
         {
            this.extraParams.dispose();
            this.extraParams = null;
         }
         this.titleTF = null;
         this.descriptionTF = null;
         this.inInventoryCountTF = null;
         this.cannotSellTF = null;
         this.cannotSellIcon = null;
         this._data = null;
         this._tweens = null;
         this._container = null;
         this._overlay = null;
         this._sizeVO = null;
         this._imageSizeVO = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:VerticalGroupLayout = null;
         super.configUI();
         this._tweens = new Vector.<Tween>(0);
         this._overlay = new Sprite();
         this._overlay.name = DISPLAY_OBJECT_NAME_OVERLAY;
         this._overlay.alpha = 0;
         this._container = new Sprite();
         this._container.name = DISPLAY_OBJECT_NAME_CONTAINER;
         this._container.addChild(this.titleTF);
         this._container.mouseEnabled = this._container.mouseChildren = false;
         if(this.price)
         {
            this.price.mouseEnabled = this.price.mouseChildren = false;
         }
         this.titleTF.multiline = true;
         this.titleTF.wordWrap = true;
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         if(this.cannotSellTF)
         {
            this.cannotSellTF.mouseEnabled = this.cannotSellTF.mouseWheelEnabled = false;
            this.cannotSellTF.autoSize = TextFieldAutoSize.LEFT;
            this.cannotSellTF.text = STORAGE.CARD_CANNOTSELLTITLE;
            this.cannotSellIcon.mouseChildren = this.cannotSellIcon.mouseEnabled = false;
         }
         if(this.inInventoryCountTF)
         {
            this.inInventoryCountTF.mouseEnabled = this.inInventoryCountTF.mouseWheelEnabled = false;
            this.inInventoryCountTF.autoSize = TextFieldAutoSize.LEFT;
            this.inInventoryIcon.mouseEnabled = this.inInventoryIcon.mouseChildren = false;
         }
         hitArea = this._overlay;
         if(this.equipmentType)
         {
            this.equipmentType.visible = false;
            this.equipmentType.mouseEnabled = this.equipmentType.mouseChildren = false;
         }
         if(this.flags)
         {
            this.flags.mouseEnabled = this.flags.mouseChildren = false;
            this.flags.addEventListener(Event.CHANGE,this.onFlagsChangeHandler);
         }
         if(this.discountIcon)
         {
            this.discountIcon.mouseEnabled = this.discountIcon.mouseChildren = false;
         }
         this.image.mouseEnabled = this.image.mouseChildren = false;
         this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         if(this.descriptionTF)
         {
            this._container.addChild(this.descriptionTF);
            this.descriptionTF.alpha = 0;
            this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         }
         if(this.specialization)
         {
            this.specialization.x = SPECIALIZATION_X;
            this.specialization.y = SPECIALIZATION_Y;
            this.specialization.layout = new HorizontalGroupLayout(SPECIALIZATION_GAP,false);
            this.specialization.itemRendererLinkage = Linkages.SPECIALIZATION_ITEM_RENDERER;
            this.specialization.mouseEnabled = false;
            this.specialization.mouseChildren = false;
         }
         if(this.extraParams)
         {
            _loc1_ = new VerticalGroupLayout();
            _loc1_.gap = EXTRA_PARAMS_GAP;
            this.extraParams.layout = _loc1_;
            this.extraParams.itemRendererLinkage = Linkages.EXTRA_PARAMS_RENDERER;
            this._container.addChild(this.extraParams);
            this.extraParams.alpha = 0;
         }
         this.sellButton.alpha = 0;
         this.sellButton.dynamicSizeByText = true;
         addChild(this._container);
         addChildAt(this._overlay,0);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         if(App.soundMgr)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
         alpha = 1;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Graphics = null;
         var _loc3_:Rectangle = null;
         var _loc4_:uint = 0;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            buttonMode = this._data.enabled;
            this.titleTF.htmlText = this._data.title;
            if(this.descriptionTF)
            {
               if(this._resetViewOnDataChange)
               {
                  this.descriptionTF.alpha = 0;
               }
            }
            if(this.extraParams)
            {
               if(this._resetViewOnDataChange)
               {
                  this.extraParams.alpha = 0;
               }
            }
            if(this.specialization)
            {
               if(this._resetViewOnDataChange)
               {
                  this.specialization.alpha = 1;
               }
            }
            this.drawPrice();
            if(this.flags)
            {
               if(this._data.nationFlagIcon)
               {
                  this.flags.source = this._data.nationFlagIcon;
                  this.flags.visible = true;
                  if(this._resetViewOnDataChange)
                  {
                     this.flags.alpha = FLAG_HOVER_ALPHA;
                  }
               }
               else
               {
                  this.flags.visible = false;
               }
            }
            if(this.inInventoryCountTF)
            {
               this.inInventoryCountTF.visible = this.inInventoryIcon.visible = this._data.count > 0;
               this.inInventoryCountTF.text = App.utils.locale.integer(this._data.count);
               if(this._resetViewOnDataChange)
               {
                  this.inInventoryCountTF.alpha = 1;
                  this.inInventoryIcon.alpha = 1;
               }
            }
            if(this.discountIcon)
            {
               this.discountIcon.visible = this.hasAction && this._data.enabled;
            }
            this.sellButton.visible = this._data.enabled;
            this.sellButton.tooltip = this._data.actionButtonTooltip;
            _loc1_ = Boolean(this._data.actionButtonIcon);
            if(_loc1_)
            {
               this.sellButton.label = Values.EMPTY_STR;
               this.sellButton.iconSource = this._data.actionButtonIcon;
               this.sellButton.width = SMALL_BUTTON_WIDTH;
            }
            else
            {
               this.sellButton.minWidth = SELL_BUTTON_MIN_WIDTH;
               this.sellButton.iconSource = Values.EMPTY_STR;
               this.sellButton.label = this._data.sellButtonLabel;
            }
            this.createUpgradeButton();
            if(this._resetViewOnDataChange)
            {
               this.sellButton.alpha = 0;
               if(this._data.upgradable)
               {
                  this.upgradeButton.alpha = 0;
               }
               this._overlay.alpha = 0;
            }
            invalidateSize();
         }
         if(this._data && isInvalid(InvalidationType.SIZE))
         {
            if(this._resetViewOnDataChange)
            {
               this.disposeTweens();
            }
            if(this.image.source != this._data.image)
            {
               this.image.alpha = 0;
               this.image.sourceAlt = this._data.imageAlt;
               this.image.source = this._data.image;
            }
            if(this.specialization)
            {
               this.specialization.alpha = 1;
            }
            _loc2_ = graphics;
            _loc2_.clear();
            _loc2_.lineStyle(1,16777215,0.15);
            _loc2_.beginFill(0,0.25);
            _loc2_.drawRoundRect(BORDER_OFFSET,BORDER_OFFSET,width - BORDER_SIZE_CORRECTION,height - BORDER_SIZE_CORRECTION,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
            _loc2_.endFill();
            _loc2_ = this._overlay.graphics;
            _loc2_.clear();
            _loc2_.beginFill(1973272);
            _loc2_.drawRoundRect(1,1,width - OVERLAY_SIZE_CORRECTION,height - OVERLAY_SIZE_CORRECTION,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
            _loc2_.endFill();
            if(this.flags)
            {
               this.flags.y = this._sizeVO.flagsOffset;
            }
            _loc3_ = this._sizeVO.innerPadding;
            if(this.price)
            {
               if(this.discountIcon && this.discountIcon.visible)
               {
                  this.discountIcon.x = _loc3_.left;
                  this.price.x = this.discountIcon.x + this.discountIcon.width + DISCOUNT_OFFSET >> 0;
                  this.price.y = _loc3_.bottom - this.price.height >> 0;
                  this.discountIcon.y = this.price.y + (this.price.height - this.discountIcon.height >> 1);
               }
               else
               {
                  this.price.x = _loc3_.left;
                  this.price.y = _loc3_.bottom - this.price.height >> 0;
               }
            }
            if(this.cannotSellTF)
            {
               this.cannotSellTF.x = _loc3_.left + this.cannotSellIcon.width + ININVENTORY_ICON_OFFSET;
               this.cannotSellTF.y = _loc3_.bottom - this.cannotSellTF.height >> 0;
               this.cannotSellIcon.x = _loc3_.left;
               this.cannotSellIcon.y = this.cannotSellTF.y + (this.cannotSellTF.height - this.cannotSellIcon.height >> 1) + CANNOT_SELL_ICON_V_OFFSET;
            }
            if(this.inInventoryCountTF)
            {
               this.inInventoryCountTF.x = _loc3_.right - this.inInventoryCountTF.width >> 0;
               this.inInventoryCountTF.y = _loc3_.bottom - this.inInventoryCountTF.height >> 0;
               this.inInventoryIcon.x = this.inInventoryCountTF.x - this.inInventoryIcon.width - ININVENTORY_ICON_OFFSET;
               this.inInventoryIcon.y = this.inInventoryCountTF.y - ININVENTORY_ICON_OFFSET;
            }
            this.titleTF.x = _loc3_.left;
            this.titleTF.width = this.price && this.price.visible || !this.inInventoryIcon || !this.inInventoryIcon.visible ? Number(_loc3_.width) : Number(this.inInventoryIcon.x - this.titleTF.x);
            if(!this._isOver)
            {
               this._container.y = this.getContainerYRolloutPosition();
            }
            if(this.descriptionTF)
            {
               this.descriptionTF.x = _loc3_.left;
               this.descriptionTF.y = this.titleTF.y + this.titleTF.height + this._sizeVO.descriptionOffset;
               this.descriptionTF.width = _loc3_.width >> 0;
               _loc4_ = this._sizeVO.size.width < CARD_SMALL_WIDTH ? uint(DESCRIPTION_SMALL_CARD_MAX_LINES) : uint(DESCRIPTION_BIG_CARD_MAX_LINES);
               App.utils.commons.truncateHtmlTextMultiline(this.descriptionTF,this._data.description,_loc4_,DESCRIPTION_TRANCATION_SYMBOL);
            }
            if(this.extraParams)
            {
               if(this._data.description == "")
               {
                  this.extraParams.y = this.descriptionTF.y;
               }
               else
               {
                  this.extraParams.y = this.descriptionTF.y + this.descriptionTF.height + this._sizeVO.descriptionOffset;
               }
            }
            this.sellButton.validateNow();
            this.sellButton.x = _loc3_.right - this.sellButton.width >> 0;
            this.sellButton.y = _loc3_.bottom - this.sellButton.height >> 0;
            if(this._data.upgradable)
            {
               this.upgradeButton.x = this.sellButton.x - this.upgradeButton.width + GAP_BUTTONS;
               this.upgradeButton.y = this.sellButton.y;
            }
            this.renderEquipmentType();
            this.onImageComplete();
            this.drawTooltipHitArea();
         }
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return true;
      }
      
      public function getSoundId() : String
      {
         return null;
      }
      
      public function getSoundType() : String
      {
         return null;
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._stageWidthBoundary = App.stageSizeMgr.calcAllowSize(param1,CardConfigs.getInstance().allowCardsResolution);
         this._sizeVO = CardConfigs.getInstance().cardSize.getConfig(this._stageWidthBoundary);
         this._imageSizeVO = CardConfigs.getInstance().cardImage.getConfig(this._stageWidthBoundary);
         this.updateExtraParamsLayout();
      }
      
      protected function drawPrice() : void
      {
         var _loc1_:PriceVO = Boolean(this._data.price) ? this._data.price.price.getPriceVO() : null;
         if(this._data.enabled && _loc1_)
         {
            if(this.price)
            {
               this.price.text = App.utils.locale.integer(_loc1_.value);
               this.price.icon = _loc1_.name;
               this.price.visible = true;
               this.price.invalidatePosition();
               this.price.validateNow();
            }
            if(this.cannotSellTF)
            {
               this.cannotSellTF.visible = this.cannotSellIcon.visible = false;
            }
         }
         else
         {
            if(this.price)
            {
               this.price.visible = false;
            }
            if(this.cannotSellTF)
            {
               this.cannotSellTF.visible = this.cannotSellIcon.visible = true;
            }
         }
      }
      
      protected function getRollOverTweens() : Vector.<Tween>
      {
         var _loc1_:int = height - this._container.height >> 1;
         if(this.sellButton.visible && _loc1_ + this._container.height > this.sellButton.y)
         {
            _loc1_ = this.sellButton.y - this._container.height >> 1;
         }
         var _loc2_:Vector.<Tween> = new <Tween>[new Tween(FIRST_ANIMATION_DURATION,this._container,{"y":_loc1_},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         }),new Tween(FIRST_ANIMATION_DURATION,this._overlay,{"alpha":1},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         }),new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":0.1},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         })];
         if(this.specialization)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.specialization,{"alpha":0.1},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY
            }));
         }
         if(this.descriptionTF)
         {
            _loc2_.push(new Tween(HALF_FIRST_ANIMATION_DURATION,this.descriptionTF,{"alpha":1},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY + HALF_FIRST_ANIMATION_DURATION
            }));
         }
         if(this.extraParams)
         {
            _loc2_.push(new Tween(HALF_FIRST_ANIMATION_DURATION,this.extraParams,{"alpha":1},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY + HALF_FIRST_ANIMATION_DURATION
            }));
         }
         if(this.equipmentType)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.equipmentType,{"alpha":0.1},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY
            }));
         }
         if(this.flags)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.flags,{"alpha":0.1},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY
            }));
         }
         if(this.inInventoryCountTF)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.inInventoryCountTF,{"alpha":0},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY
            }));
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.inInventoryIcon,{"alpha":0},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY
            }));
         }
         if(this.sellButton.visible)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.sellButton,{"alpha":1},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY + FIRST_ANIMATION_DURATION
            }));
         }
         if(this._data.upgradable)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.upgradeButton,{"alpha":1},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY + FIRST_ANIMATION_DURATION
            }));
         }
         return _loc2_;
      }
      
      protected function getRollOutTweens() : Vector.<Tween>
      {
         var _loc1_:int = this.getContainerYRolloutPosition();
         var _loc2_:Vector.<Tween> = new <Tween>[new Tween(FIRST_ANIMATION_DURATION,this._container,{"y":_loc1_},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,this._overlay,{"alpha":0},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":1},{"fastTransform":false})];
         if(this.specialization)
         {
            _loc2_.unshift(new Tween(HALF_FIRST_ANIMATION_DURATION,this.specialization,{"alpha":1},{"fastTransform":false}));
         }
         if(this.descriptionTF)
         {
            _loc2_.unshift(new Tween(HALF_FIRST_ANIMATION_DURATION,this.descriptionTF,{"alpha":0},{"fastTransform":false}));
         }
         if(this.extraParams)
         {
            _loc2_.unshift(new Tween(HALF_FIRST_ANIMATION_DURATION,this.extraParams,{"alpha":0},{"fastTransform":false}));
         }
         if(this.sellButton.visible)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.sellButton,{"alpha":0},{"fastTransform":false}));
         }
         if(this._data.upgradable)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.upgradeButton,{"alpha":0},{"fastTransform":false}));
         }
         if(this.equipmentType)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.equipmentType,{"alpha":1},{"fastTransform":false}));
         }
         if(this.inInventoryCountTF)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.inInventoryCountTF,{"alpha":1},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,this.inInventoryIcon,{"alpha":1},{"fastTransform":false}));
         }
         if(this.flags)
         {
            _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.flags,{"alpha":FLAG_HOVER_ALPHA},{"fastTransform":false}));
         }
         return _loc2_;
      }
      
      protected function getContainerYRolloutPosition() : int
      {
         var _loc1_:int = 0;
         if(this.price && this.price.visible)
         {
            _loc1_ = this.price.y - this.titleTF.height >> 0;
         }
         else if(this.cannotSellTF && this.cannotSellTF.visible)
         {
            _loc1_ = this.cannotSellTF.y - this.titleTF.height >> 0;
         }
         else
         {
            _loc1_ = this._sizeVO.innerPadding.bottom - this.titleTF.height >> 0;
         }
         return _loc1_;
      }
      
      protected function onRollOver() : void
      {
         this._isOver = true;
         this.disposeTweens();
         this._tweens = this.getRollOverTweens();
         App.utils.scheduler.scheduleTask(dispatchEvent,ROLL_OVER_ANIMATION_DELAY,new CardEvent(CardEvent.PLAY_INFO_SOUND));
      }
      
      protected function onRollOut() : void
      {
         this._isOver = false;
         this.disposeTweens();
         this._tweens = this.getRollOutTweens();
         App.utils.scheduler.cancelTask(dispatchEvent);
      }
      
      protected function animateImage() : void
      {
         if(!this._isOver && this.image.alpha != 1)
         {
            this._tweens.push(new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":1},{"fastTransform":false}));
         }
      }
      
      protected function onImageComplete() : void
      {
         var _loc1_:Rectangle = null;
         if(this.image.width)
         {
            _loc1_ = this._imageSizeVO.getRect(this._data.isWideImage);
            this.image.width = _loc1_.width;
            this.image.height = _loc1_.height;
            this.image.x = _loc1_.x < 0 ? Number(width - this.image.width >> 1) : Number(_loc1_.x);
            this.image.y = _loc1_.y < 0 ? Number(this.image.y) : Number(_loc1_.y);
            this.animateImage();
            if(this.equipmentType)
            {
               this.equipmentType.x = this.image.x + (this.image.width >> 1) >> 0;
               this.equipmentType.y = this.image.y + (this.image.height >> 1) >> 0;
            }
         }
      }
      
      protected function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      protected function setData(param1:BaseCardVO) : void
      {
         if(this.extraParams)
         {
            this.updateExtraParamsLayout();
            this.extraParams.dataProvider = param1.extraParams;
         }
         if(this.specialization)
         {
            this.specialization.dataProvider = param1.specializations;
         }
         this._data = param1;
      }
      
      private function drawTooltipHitArea() : void
      {
         var _loc2_:int = 0;
         if(this._tooltipHitArea == null)
         {
            this._tooltipHitArea = new Sprite();
            this._tooltipHitArea.name = TOOLTIP_HIT_AREA_NAME;
            this._tooltipHitArea.buttonMode = this._data.enabled;
            this._tooltipHitArea.addEventListener(MouseEvent.ROLL_OVER,this.onTooltipHitAreaRollOver);
            this._tooltipHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onTooltipHitAreaRollOut);
            _loc2_ = getChildIndex(this.upgradeButton || this.sellButton);
            addChildAt(this._tooltipHitArea,_loc2_);
         }
         var _loc1_:Graphics = this._tooltipHitArea.graphics;
         _loc1_.clear();
         _loc1_.beginFill(0,0);
         _loc1_.drawRect(0,0,width,height);
         _loc1_.endFill();
      }
      
      private function disposeTooltipHitArea() : void
      {
         if(this._tooltipHitArea)
         {
            this._tooltipHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onTooltipHitAreaRollOver);
            this._tooltipHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onTooltipHitAreaRollOut);
            removeChild(this._tooltipHitArea);
            this._tooltipHitArea = null;
         }
      }
      
      private function createUpgradeButton() : void
      {
         var _loc1_:int = 0;
         if(this.upgradeButton == null)
         {
            this.upgradeButton = App.utils.classFactory.getComponent(Linkages.BUTTON_ICON_NORMAL,ButtonIconNormal);
            this.upgradeButton.width = SMALL_BUTTON_WIDTH;
            this.upgradeButton.alpha = 0;
            _loc1_ = getChildIndex(this.sellButton);
            addChildAt(this.upgradeButton,_loc1_);
         }
         this.upgradeButton.visible = this._data.upgradable;
         this.upgradeButton.iconSource = this._data.upgradeButtonIcon;
         this.upgradeButton.tooltip = this._data.upgradeButtonTooltip;
      }
      
      private function renderEquipmentType() : void
      {
         if(this.equipmentType && this._data)
         {
            if(this._data.type == SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT)
            {
               this.equipmentType.visible = false;
            }
            else
            {
               this.equipmentType.visible = true;
               this.equipmentType.gotoAndStop(this._data.type + FRAME_LABEL_CONNECTOR + this._stageWidthBoundary);
               if(this._resetViewOnDataChange)
               {
                  this.equipmentType.alpha = 1;
               }
            }
         }
      }
      
      private function updateExtraParamsLayout() : void
      {
         var _loc1_:int = 0;
         if(this.extraParams)
         {
            _loc1_ = this._sizeVO.size.width < CARD_SMALL_WIDTH ? int(EXTRA_PARAMS_SMALL_CARD_MAX_NUM) : int(EXTRA_PARAMS_BIG_CARD_MAX_NUM);
            this.extraParams.setMaxTextLines(_loc1_);
            this.extraParams.setMaxTextWidth(this._sizeVO.innerPadding.width >> 0);
         }
      }
      
      private function showDiscountTooltip() : void
      {
         var _loc1_:CompoundPriceVO = this._data.price.price;
         var _loc2_:CompoundPriceVO = this._data.price.defPrice;
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,TOOLTIP_ACTION_PRICE_FIELD_NAME_ITEM,this._data.id,[_loc1_.getPriceValueByName(CURRENCIES_CONSTANTS.CREDITS),_loc1_.getPriceValueByName(CURRENCIES_CONSTANTS.GOLD),_loc1_.getPriceValueByName(CURRENCIES_CONSTANTS.CRYSTAL)],[_loc2_.getPriceValueByName(CURRENCIES_CONSTANTS.CREDITS),_loc2_.getPriceValueByName(CURRENCIES_CONSTANTS.GOLD),_loc2_.getPriceValueByName(CURRENCIES_CONSTANTS.CRYSTAL)],false,true,-1);
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
         return null;
      }
      
      public function set owner(param1:UIComponent) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:BaseCardVO = param1 as BaseCardVO;
         if(this._data == _loc2_)
         {
            return;
         }
         this.setData(_loc2_);
         invalidateData();
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
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
      
      private function get hasAction() : Boolean
      {
         return this._data != null && this._data.price && this._data.price.action != null;
      }
      
      protected function onTooltipHitAreaRollOver(param1:MouseEvent) : void
      {
         if(this.hasAction && this._data.enabled)
         {
            this.showDiscountTooltip();
         }
      }
      
      protected function onTooltipHitAreaRollOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         if(this._data == null)
         {
            return;
         }
         var _loc2_:ICommons = App.utils.commons;
         if(_loc2_.isRightButton(param1))
         {
            if(this._data.contextMenuId)
            {
               dispatchEvent(new CardEvent(CardEvent.SHOW_CONTEXT_MENU,this._data));
            }
         }
         else if(param1.target == this.upgradeButton)
         {
            dispatchEvent(new CardEvent(CardEvent.UPGRADE,this._data));
         }
         else if(this._data.enabled)
         {
            dispatchEvent(new CardEvent(CardEvent.SELL,this._data));
         }
      }
      
      private function onFlagsChangeHandler(param1:Event) : void
      {
         this.flags.width = FLAG_SIZE.width;
         this.flags.height = FLAG_SIZE.height;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.onRollOver();
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.onRollOut();
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         this.onImageComplete();
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         this.onClick(param1);
      }
   }
}
