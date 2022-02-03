package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationEditedKitPopoverListVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationIndicatorEvent;
   import net.wg.infrastructure.base.meta.ICustomizationEditedKitPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.CustomizationEditedKitPopoverMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class CustomizationEditedKitPopover extends CustomizationEditedKitPopoverMeta implements ICustomizationEditedKitPopoverMeta
   {
      
      private static const CLEAR_STATE_INVALID:String = "ClearStateInvalid";
      
      private static const WIDTH:int = 436;
      
      private static const HEIGHT:int = 435;
       
      
      public var titleTF:TextField;
      
      public var messageTF:TextField;
      
      public var clearTF:TextField;
      
      public var clearBtn:BlackButton;
      
      public var defaultBtn:SoundButtonEx;
      
      public var items:ScrollingListEx;
      
      public var bottomShadow:MovieClip;
      
      public var topShadow:MovieClip;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _clearMsg:String = "";
      
      private var _title:String = "";
      
      private var _helpMessage:String = "";
      
      public function CustomizationEditedKitPopover()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:Sprite = new Sprite();
         this.topShadow.hitArea = _loc1_;
         this.bottomShadow.hitArea = _loc1_;
         addChild(_loc1_);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bottomShadow.mouseChildren = this.bottomShadow.mouseEnabled = false;
         this.topShadow.mouseChildren = this.topShadow.mouseEnabled = false;
         this.topShadow.width = this.bottomShadow.width = WIDTH;
         this.messageTF.autoSize = TextFieldAutoSize.LEFT;
         this.clearBtn.mouseEnabledOnDisabled = true;
         this.clearBtn.mutedSoundTypes = [MouseEvent.MOUSE_DOWN];
         this.clearBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_ASSET_1;
         this.clearBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_KITPOPOVER_BUTTONTEXT_REMOVESTYLEKIT;
         this.clearBtn.addEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.defaultBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_NONHISTORIC_BUTTONTEXT_DEFAULTVIEW;
         this.defaultBtn.mouseEnabledOnDisabled = true;
         this.defaultBtn.addEventListener(MouseEvent.ROLL_OVER,this.onDefaultBtnRollOverHandler);
         this.defaultBtn.addEventListener(MouseEvent.ROLL_OUT,this.onDefaultBtnRollOutHandler);
         this.defaultBtn.addEventListener(ButtonEvent.CLICK,this.onDefaultBtnClickHandler);
         this.items.scrollBar = Linkages.SCROLL_BAR;
         this.items.smartScrollBar = true;
         this.items.widthAutoResize = false;
         this.items.addEventListener(CustomizationIndicatorEvent.REMOVAL,this.onItemRemovalHandler);
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      override protected function onBeforeDispose() : void
      {
         App.stage.dispatchEvent(new CustomizationEvent(CustomizationEvent.ITEMS_POPOVER_CLOSED));
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.clearBtn.removeEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.clearBtn.dispose();
         this.clearBtn = null;
         this.defaultBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onDefaultBtnRollOverHandler);
         this.defaultBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onDefaultBtnRollOutHandler);
         this.defaultBtn.removeEventListener(ButtonEvent.CLICK,this.onDefaultBtnClickHandler);
         this.defaultBtn.dispose();
         this.defaultBtn = null;
         this.items.removeEventListener(CustomizationIndicatorEvent.REMOVAL,this.onItemRemovalHandler);
         this.items.dispose();
         this.items = null;
         this.clearTF = null;
         this.titleTF = null;
         this.messageTF = null;
         this.bottomShadow = null;
         this.topShadow = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._title;
            this.messageTF.htmlText = this._helpMessage;
         }
         if(isInvalid(CLEAR_STATE_INVALID))
         {
            this.clearTF.htmlText = this._clearMsg;
            _loc1_ = !StringUtils.isEmpty(this._clearMsg);
            this.clearTF.visible = _loc1_;
            this.items.visible = !_loc1_;
            this.clearBtn.enabled = !_loc1_;
         }
      }
      
      override protected function setItems(param1:CustomizationEditedKitPopoverListVO) : void
      {
         this.items.dataProvider = param1.items;
      }
      
      private function onClearBtnClickHandler(param1:ButtonEvent) : void
      {
         removeAllS();
      }
      
      private function onDefaultBtnRollOverHandler(param1:Event) : void
      {
         var _loc2_:String = !!this.defaultBtn.enabled ? VEHICLE_CUSTOMIZATION.CUSTOMIZATION_EDITABLEPOPOVER_DEFAULTBTN_ENABLED : VEHICLE_CUSTOMIZATION.CUSTOMIZATION_EDITABLEPOPOVER_DEFAULTBTN_DISABLED;
         this._tooltipMgr.show(_loc2_);
      }
      
      private function onDefaultBtnRollOutHandler(param1:Event) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onDefaultBtnClickHandler(param1:ButtonEvent) : void
      {
         setToDefaultS();
      }
      
      private function onItemRemovalHandler(param1:CustomizationIndicatorEvent) : void
      {
         removeS(param1.id,param1.itemsList,param1.seasonType);
      }
      
      public function as_showClearMessage(param1:String) : void
      {
         this._clearMsg = param1;
         invalidate(CLEAR_STATE_INVALID);
      }
      
      public function as_setHeader(param1:String) : void
      {
         if(this._title != param1)
         {
            this._title = param1;
            invalidateData();
         }
      }
      
      public function as_setHelpMessage(param1:String) : void
      {
         if(this._helpMessage != param1)
         {
            this._helpMessage = param1;
            invalidateData();
         }
      }
      
      public function as_setDefaultButtonEnabled(param1:Boolean) : void
      {
         this.defaultBtn.enabled = param1;
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
   }
}
