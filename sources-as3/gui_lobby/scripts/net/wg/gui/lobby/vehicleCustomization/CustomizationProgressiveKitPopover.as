package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPopoverEditedItemRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationProgressiveKitPopoverListVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationIndicatorEvent;
   import net.wg.infrastructure.base.meta.ICustomizationProgressiveKitPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.CustomizationProgressiveKitPopoverMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IUniversalBtnStyles;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class CustomizationProgressiveKitPopover extends CustomizationProgressiveKitPopoverMeta implements ICustomizationProgressiveKitPopoverMeta
   {
      
      private static const WIDTH:int = 436;
      
      private static const HEIGHT:int = 435;
      
      private static const CLEAR_STATE_INVALID:String = "clearStateInvalid";
      
      private static const FILTER_STATE_INVALID:String = "filterStateInvalid";
      
      private static const HIT_AREA_NAME:String = "emptyHitArea";
      
      private static const SEASONS_COUNT:int = 3;
       
      
      public var titleTF:TextField;
      
      public var clearTF:TextField;
      
      public var clearBtn:UniversalBtn;
      
      public var defaultBtn:UniversalBtn;
      
      public var items:ScrollingListEx;
      
      public var bottomShadow:MovieClip;
      
      public var topShadow:MovieClip;
      
      public var historicBtn:UniversalBtn;
      
      public var nonHistoricBtn:UniversalBtn;
      
      public var fantasticBtn:UniversalBtn;
      
      public var progressiveLockedBtn:UniversalBtn;
      
      private var _title:String;
      
      private var _clearMsg:String;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function CustomizationProgressiveKitPopover()
      {
         this._title = String.prototype;
         this._clearMsg = String.prototype;
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:IUniversalBtnStyles = App.utils.universalBtnStyles;
         _loc1_.setStyle(this.historicBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.nonHistoricBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.fantasticBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.progressiveLockedBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.defaultBtn,UniversalBtnStylesConst.STYLE_SLIM_GREEN);
         _loc1_.setStyle(this.clearBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:Sprite = null;
         super.configUI();
         this.topShadow.mouseEnabled = this.topShadow.mouseChildren = false;
         this.bottomShadow.mouseEnabled = this.bottomShadow.mouseChildren = false;
         _loc1_ = new Sprite();
         _loc1_.name = HIT_AREA_NAME;
         addChild(_loc1_);
         this.topShadow.hitArea = _loc1_;
         this.bottomShadow.hitArea = _loc1_;
         this.topShadow.width = this.bottomShadow.width = WIDTH;
         this.historicBtn.toggle = true;
         this.historicBtn.tooltip = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_POPOVERFILTER_HISTORIC_TOOLTIP;
         this.historicBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_HIST_SMALL;
         this.historicBtn.addEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.fantasticBtn.toggle = true;
         this.fantasticBtn.tooltip = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_POPOVERFILTER_FANTASTIC_TOOLTIP;
         this.fantasticBtn.iconSource = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_FANTASTICAL_MINI;
         this.fantasticBtn.addEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.nonHistoricBtn.toggle = true;
         this.nonHistoricBtn.tooltip = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_POPOVERFILTER_NONHISTORIC_TOOLTIP;
         this.nonHistoricBtn.iconSource = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_NON_HISTORICAL_MINI;
         this.nonHistoricBtn.addEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.progressiveLockedBtn.toggle = true;
         this.progressiveLockedBtn.tooltip = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_POPOVERFILTER_PROGRESSIVELOCKED_TOOLTIP;
         this.progressiveLockedBtn.iconSource = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_LOCK_ICON;
         this.progressiveLockedBtn.addEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.items.scrollBar = Linkages.SCROLL_BAR;
         this.items.smartScrollBar = true;
         this.items.widthAutoResize = false;
         this.items.addEventListener(CustomizationIndicatorEvent.REMOVAL,this.onItemRemovalHandler);
         this.defaultBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_NONHISTORIC_BUTTONTEXT_DEFAULTVIEW;
         this.defaultBtn.mouseEnabledOnDisabled = true;
         this.defaultBtn.addEventListener(ButtonEvent.CLICK,this.onDefaultBtnClickHandler);
         this.defaultBtn.addEventListener(MouseEvent.ROLL_OVER,this.onDefaultBtnRollOverHandler);
         this.defaultBtn.addEventListener(MouseEvent.ROLL_OUT,this.onDefaultBtnRollOutHandler);
         this.clearBtn.mouseEnabledOnDisabled = true;
         this.clearBtn.mutedSoundTypes = [MouseEvent.MOUSE_DOWN];
         this.clearBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_ASSET_1;
         this.clearBtn.addEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:CustomizationPopoverEditedItemRendererVO = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._title;
         }
         if(isInvalid(CLEAR_STATE_INVALID))
         {
            _loc1_ = StringUtils.isNotEmpty(this._clearMsg);
            _loc2_ = true;
            for each(_loc3_ in this.items.dataProvider)
            {
               if(_loc3_.isRemovable)
               {
                  _loc2_ = false;
                  break;
               }
            }
            this.clearBtn.enabled = !_loc1_ && !_loc2_;
            this.items.visible = !_loc1_;
            this.clearTF.visible = _loc1_;
            this.clearTF.htmlText = this._clearMsg;
         }
         if(isInvalid(FILTER_STATE_INVALID))
         {
            if(this.historicBtn.selected || this.nonHistoricBtn.selected || this.fantasticBtn.selected || this.progressiveLockedBtn.selected)
            {
               this.clearBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_CLEARBUTTON_LABEL_REMOVE;
            }
            else
            {
               this.clearBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_CLEARBUTTON_LABEL_REMOVEALL;
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         App.stage.dispatchEvent(new CustomizationEvent(CustomizationEvent.ITEMS_POPOVER_CLOSED));
         this.progressiveLockedBtn.removeEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.nonHistoricBtn.removeEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.fantasticBtn.removeEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.historicBtn.removeEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.defaultBtn.removeEventListener(ButtonEvent.CLICK,this.onDefaultBtnClickHandler);
         this.defaultBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onDefaultBtnRollOverHandler);
         this.defaultBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onDefaultBtnRollOutHandler);
         this.clearBtn.removeEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.items.removeEventListener(CustomizationIndicatorEvent.REMOVAL,this.onItemRemovalHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.progressiveLockedBtn.dispose();
         this.progressiveLockedBtn = null;
         this.fantasticBtn.dispose();
         this.fantasticBtn = null;
         this.nonHistoricBtn.dispose();
         this.nonHistoricBtn = null;
         this.historicBtn.dispose();
         this.historicBtn = null;
         this.defaultBtn.dispose();
         this.defaultBtn = null;
         this.clearBtn.dispose();
         this.clearBtn = null;
         this.items.dispose();
         this.items = null;
         this.topShadow = null;
         this.bottomShadow = null;
         this.clearTF = null;
         this.titleTF = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function setItems(param1:CustomizationProgressiveKitPopoverListVO) : void
      {
         this.items.dataProvider = param1.items;
      }
      
      public function as_setDefaultButtonEnabled(param1:Boolean) : void
      {
         this.defaultBtn.enabled = param1;
      }
      
      public function as_setHeader(param1:String) : void
      {
         if(param1 == this._title)
         {
            return;
         }
         this._title = param1;
         invalidateData();
      }
      
      public function as_showClearMessage(param1:String) : void
      {
         this._clearMsg = param1;
         invalidate(CLEAR_STATE_INVALID);
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      private function onItemRemovalHandler(param1:CustomizationIndicatorEvent) : void
      {
         removeS(param1.id,param1.itemsList,param1.seasonType);
      }
      
      private function onDefaultBtnClickHandler(param1:ButtonEvent) : void
      {
         setToDefaultS();
      }
      
      private function onDefaultBtnRollOverHandler(param1:Event) : void
      {
         var _loc2_:String = !!this.defaultBtn.enabled ? VEHICLE_CUSTOMIZATION.CUSTOMIZATION_EDITABLEPOPOVER_DEFAULTBTN_ENABLED : VEHICLE_CUSTOMIZATION.CUSTOMIZATION_EDITABLEPOPOVER_DEFAULTBTN_DISABLED;
         this._tooltipMgr.show(_loc2_);
      }
      
      private function onDefaultBtnRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onClearBtnClickHandler(param1:ButtonEvent) : void
      {
         removeAllS();
      }
      
      private function onFilterToggleBtnClickHandler(param1:ButtonEvent) : void
      {
         onFilterChangedS(this.historicBtn.selected,this.nonHistoricBtn.selected,this.fantasticBtn.selected,this.progressiveLockedBtn.selected);
         invalidate(FILTER_STATE_INVALID);
      }
   }
}
