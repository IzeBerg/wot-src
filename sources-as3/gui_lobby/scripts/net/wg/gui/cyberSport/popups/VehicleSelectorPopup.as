package net.wg.gui.cyberSport.popups
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.VEHICLE_SELECTOR_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.cyberSport.controls.VehicleSelector;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
   import net.wg.infrastructure.base.meta.IVehicleSelectorPopupMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleSelectorPopupMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class VehicleSelectorPopup extends VehicleSelectorPopupMeta implements IVehicleSelectorPopupMeta
   {
      
      private static const INVALID_LAYOUT:String = "invalidLayout";
      
      private static const DEFAULT_WIDTH:int = 346;
      
      private static const BTN_PADDING:int = 5;
      
      private static const WND_PADDING:int = 16;
      
      private static const TEXT_INFO_BOTTOM_PADDING:int = 6;
      
      private static const WND_FORM_PADDING:Padding = new Padding(33,11,13,10);
      
      private static const WND_CONTENT_PADDING:Padding = new Padding(35,14,17,12);
      
      private static const INFO_TF_OFFSET:int = -44;
      
      private static const SELECT_BTN_OFFSET:int = -278;
      
      private static const BUTTONS_GAP:int = 6;
       
      
      public var selector:VehicleSelector;
      
      public var selectButton:SoundButtonEx;
      
      public var cancelButton:SoundButtonEx;
      
      public var separator:MovieClip;
      
      public var infoTF:TextField;
      
      private var _selectedItems:Array;
      
      private var _movableComponents:Array;
      
      private var _originalPos:Dictionary;
      
      private var _filtersVisible:Boolean = true;
      
      public function VehicleSelectorPopup()
      {
         var _loc1_:DisplayObject = null;
         this._selectedItems = [];
         super();
         this.infoTF.mouseEnabled = false;
         this._originalPos = new Dictionary();
         this._movableComponents = [this.selector,this.separator];
         for each(_loc1_ in this._movableComponents)
         {
            this._originalPos[_loc1_] = _loc1_.y - this.separator.y;
         }
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         if(param1 != null)
         {
            param1.formBgPadding = WND_FORM_PADDING;
            param1.contentPadding = WND_CONTENT_PADDING;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.selector.addEventListener(VehicleSelectorFilterEvent.CHANGE,this.onSelectorFiltersChangeHandler);
         this.selector.addEventListener(VehicleSelectorEvent.SELECTION_CHANGED,this.onSelectorSelectionChangedHandler);
         this.selector.addEventListener(Event.RESIZE,this.onSelectorResizeHandler);
         this.selectButton.addEventListener(ButtonEvent.CLICK,this.onSelectButtonClickHandler);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         super.draw();
         if(isInvalid(INVALID_LAYOUT))
         {
            _loc1_ = DEFAULT_WIDTH;
            _loc2_ = this.actualHeight + WND_PADDING;
            window.updateSize(_loc1_,_loc2_,true);
            this.infoTF.width = _loc1_ + INFO_TF_OFFSET;
            App.utils.commons.updateTextFieldSize(this.infoTF,false,true);
            _loc3_ = this.infoTF.y + this.infoTF.height + TEXT_INFO_BOTTOM_PADDING;
            for each(_loc4_ in this._movableComponents)
            {
               _loc4_.y = _loc3_ + this._originalPos[_loc4_];
            }
            this.separator.x = this.infoTF.x + (this.infoTF.width - this.separator.width >> 1);
            this.selectButton.x = _loc1_ + SELECT_BTN_OFFSET;
            this.cancelButton.x = this.selectButton.x + this.selectButton.width + BUTTONS_GAP ^ 0;
            this.selectButton.y = this.cancelButton.y = this.selector.y + this.selector.height + BTN_PADDING ^ 0;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.separator.visible = this._filtersVisible;
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
      }
      
      override protected function onDispose() : void
      {
         this.selector.removeEventListener(VehicleSelectorFilterEvent.CHANGE,this.onSelectorFiltersChangeHandler);
         this.selector.removeEventListener(VehicleSelectorEvent.SELECTION_CHANGED,this.onSelectorSelectionChangedHandler);
         this.selector.removeEventListener(Event.RESIZE,this.onSelectorResizeHandler);
         this.selectButton.removeEventListener(ButtonEvent.CLICK,this.onSelectButtonClickHandler);
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.selector.dispose();
         this.selectButton.dispose();
         this.cancelButton.dispose();
         this._selectedItems.splice(0,this._movableComponents.length);
         this._selectedItems = null;
         App.utils.data.cleanupDynamicObject(this._originalPos);
         this._movableComponents.splice(0,this._movableComponents.length);
         this.separator = null;
         this.selectButton = null;
         this.cancelButton = null;
         this.selector = null;
         this.infoTF = null;
         this._movableComponents = null;
         this._originalPos = null;
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.selector.list);
      }
      
      override protected function setFiltersData(param1:VehicleSelectorFilterVO) : void
      {
         this.selector.setFiltersData(param1);
         this._filtersVisible = Boolean(param1.visibility & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_COMPATIBLE_ONLY) || Boolean(param1.visibility & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_LEVEL) || Boolean(param1.visibility & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_NATION) || Boolean(param1.visibility & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_VEHICLE_TYPE) || Boolean(param1.visibility & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_IS_MAIN);
         invalidateData();
      }
      
      override protected function setListData(param1:DataProvider, param2:Array) : void
      {
         var _loc4_:VehicleSelectorItemVO = null;
         var _loc3_:Array = App.utils.getGUINationsS();
         for each(_loc4_ in param1)
         {
            _loc4_.nationOrderIdx = _loc3_.indexOf(App.utils.nations.getNationName(_loc4_.nationID));
         }
         this.selector.setupSelectionOverrides(param2);
         this.selector.setListItems(param1);
      }
      
      public function as_setListMode(param1:Boolean) : void
      {
         this.selector.multiSelection = param1;
      }
      
      public function as_setListRenderer(param1:String) : void
      {
         this.selector.setListRenderer(param1);
         invalidate(INVALID_LAYOUT);
      }
      
      public function as_setTexts(param1:String, param2:String, param3:String, param4:String) : void
      {
         window.title = param1;
         this.infoTF.htmlText = param2;
         this.selectButton.label = param3;
         this.cancelButton.label = param4;
         invalidate(INVALID_LAYOUT);
      }
      
      private function onSelectorResizeHandler(param1:Event) : void
      {
         invalidate(INVALID_LAYOUT);
      }
      
      private function onSelectorSelectionChangedHandler(param1:VehicleSelectorEvent) : void
      {
         this._selectedItems = param1.selectedDescriptors;
         this.selectButton.enabled = this._selectedItems.length > 0;
         if(param1.forceSelect)
         {
            onSelectVehiclesS(this._selectedItems);
         }
      }
      
      private function onSelectorFiltersChangeHandler(param1:VehicleSelectorFilterEvent) : void
      {
         onFiltersUpdateS(param1.nation,param1.vehicleType,param1.isMain,param1.level,param1.compatibleOnly);
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent) : void
      {
         onWindowClose();
      }
      
      private function onSelectButtonClickHandler(param1:ButtonEvent) : void
      {
         onSelectVehiclesS(this._selectedItems);
      }
   }
}
