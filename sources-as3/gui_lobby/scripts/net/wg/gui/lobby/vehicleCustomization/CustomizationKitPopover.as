package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPopoverKitRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.infrastructure.base.meta.ICustomizationKitPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.CustomizationKitPopoverMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class CustomizationKitPopover extends CustomizationKitPopoverMeta implements ICustomizationKitPopoverMeta
   {
      
      private static const WIDTH:int = 420;
      
      private static const HEIGHT:int = 410;
      
      private static const CLEAR_STATE_INVALID:String = "ClearStateInvalid";
      
      private static const SCROLL_BAR_VALUE:String = "ScrollBar";
      
      private static const SCROLL_BAR_STEP_FACTOR:int = 40;
      
      private static const SCROLL_SHIFT_HORIZONTAL:int = 3;
       
      
      public var titleTF:TextField;
      
      public var autoProlongationCheckbox:CheckBox;
      
      public var clearTF:TextField;
      
      public var clearBtn:BlackButton;
      
      public var bottomShadow:MovieClip;
      
      public var scrollPane:ResizableScrollPane;
      
      public var topShadow:MovieClip;
      
      private var _table:CustomizationKitTable;
      
      private var _dataProvider:IDataProvider;
      
      private var _isClear:Boolean = false;
      
      private var _clearMsg:String = "";
      
      public function CustomizationKitPopover()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._table = CustomizationKitTable(CustomizationKitPopoverContent(this.scrollPane.target).table);
         this._table.itemRenderer = App.instance.utils.classFactory.getClass(Linkages.CUSTOMIZATION_KIT_RENDERER);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._dataProvider = new ListDAAPIDataProvider(CustomizationPopoverKitRendererVO);
         this._table.dataProvider = this._dataProvider;
      }
      
      override protected function configUI() : void
      {
         var _loc1_:Sprite = null;
         super.configUI();
         _loc1_ = new Sprite();
         this.topShadow.hitArea = _loc1_;
         this.bottomShadow.hitArea = _loc1_;
         addChild(_loc1_);
         this.bottomShadow.mouseChildren = this.bottomShadow.mouseEnabled = false;
         this.topShadow.mouseChildren = this.topShadow.mouseEnabled = false;
         this.scrollPane.scrollStepFactor = SCROLL_BAR_STEP_FACTOR;
         this.scrollPane.isSmoothScroll = false;
         this.scrollPane.setSize(this._table.width,this._table.height);
         this.scrollPane.scrollBarShiftHorizontal = SCROLL_SHIFT_HORIZONTAL;
         this.scrollPane.scrollPosition = 0;
         this.scrollPane.scrollBar = SCROLL_BAR_VALUE;
         this.clearBtn.mouseEnabledOnDisabled = true;
         this.clearBtn.soundType = SoundTypes.CUSTOMIZATION_DEFAULT;
         this.clearBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_ASSET_1;
         this.clearBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_CLEARBUTTON_LABEL_REMOVEALL;
         this.clearBtn.addEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.autoProlongationCheckbox.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_KITPOPOVER_AUTOPROLONGATIONLABEL;
         this.autoProlongationCheckbox.addEventListener(MouseEvent.CLICK,this.onAutoProlongationCheckboxClickHandler);
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(CLEAR_STATE_INVALID))
         {
            this.clearTF.htmlText = this._clearMsg;
            this.clearTF.visible = this._isClear;
            this.clearBtn.enabled = !this._isClear;
            this.scrollPane.visible = !this._isClear;
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            if(!this.autoProlongationCheckbox.visible)
            {
               this.titleTF.y = this.topShadow.y - this.titleTF.height >> 1;
            }
         }
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
         this.clearTF = null;
         this.titleTF = null;
         this.bottomShadow = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.topShadow = null;
         this.autoProlongationCheckbox.removeEventListener(MouseEvent.CLICK,this.onAutoProlongationCheckboxClickHandler);
         this.autoProlongationCheckbox.dispose();
         this.autoProlongationCheckbox = null;
         this._table = null;
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         super.onDispose();
      }
      
      public function as_getDP() : Object
      {
         return this._dataProvider;
      }
      
      public function as_setAutoProlongationCheckboxEnabled(param1:Boolean) : void
      {
         this.autoProlongationCheckbox.enabled = this.autoProlongationCheckbox.visible = param1;
         invalidateLayout();
      }
      
      public function as_setAutoProlongationCheckboxSelected(param1:Boolean) : void
      {
         this.autoProlongationCheckbox.selected = param1;
      }
      
      public function as_setHeader(param1:String) : void
      {
         this.titleTF.htmlText = param1;
      }
      
      public function as_showClearMessage(param1:Boolean, param2:String) : void
      {
         this._isClear = param1;
         this._clearMsg = param2;
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
      
      private function onClearBtnClickHandler(param1:ButtonEvent) : void
      {
         this.autoProlongationCheckbox.enabled = false;
         removeCustomizationKitS();
      }
      
      private function onAutoProlongationCheckboxClickHandler(param1:MouseEvent) : void
      {
         if(this.autoProlongationCheckbox.enabled)
         {
            updateAutoProlongationS();
         }
      }
   }
}
