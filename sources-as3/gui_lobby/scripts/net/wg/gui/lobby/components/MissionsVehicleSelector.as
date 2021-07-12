package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.generated.QUESTS_ALIASES;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.interfaces.IMissionsVehicleSelector;
   import net.wg.gui.lobby.hangar.tcarousel.TankCarouselItemRenderer;
   import net.wg.gui.lobby.hangar.tcarousel.VehicleSelectorCarousel;
   import net.wg.gui.lobby.missions.data.MissionVehicleSelectorVO;
   import net.wg.infrastructure.base.meta.impl.MissionsVehicleSelectorMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class MissionsVehicleSelector extends MissionsVehicleSelectorMeta implements IMissionsVehicleSelector
   {
      
      private static const VEHICLE_SELECTOR_CAROUSEL_NAME:String = "vehicleSelectorCarousel";
      
      private static const SMALL_TANK_CAROUSEL_ITEM_RENDERER_UI:String = "SmallTankCarouselItemRendererUI";
      
      private static const VEHICLE_SELECTOR_CAROUSEL_LEFT:int = 0;
      
      private static const VEHICLE_SELECTOR_CAROUSEL_TOP:int = 0;
      
      private static const SELECT_VEHICLE_BTN_X:int = 294;
      
      private static const SELECT_VEHICLE_BTN_Y:int = 482;
       
      
      public var btnClose:ISoundButtonEx = null;
      
      public var separator:ISeparatorAsset = null;
      
      public var background:MovieClip = null;
      
      public var selectVehicleButton:TankCarouselItemRenderer = null;
      
      public var titleTF:TextField = null;
      
      public var vehicleStatusTF:TextField = null;
      
      public var hitMc:MovieClip = null;
      
      private var _vehicleSelectorCarousel:VehicleSelectorCarousel = null;
      
      private var _selectedVehicleData:VehicleCarouselVO = null;
      
      private var _title:String = null;
      
      private var _statusText:String = null;
      
      private var _isOpen:Boolean = false;
      
      private var _addedToDisplayList:Boolean = false;
      
      private var _vehicleSelectorCarouselAlias:String;
      
      public function MissionsVehicleSelector()
      {
         super();
         this.selectVehicleButton = App.utils.classFactory.getComponent(SMALL_TANK_CAROUSEL_ITEM_RENDERER_UI,TankCarouselItemRenderer);
         this.selectVehicleButton.x = SELECT_VEHICLE_BTN_X;
         this.selectVehicleButton.y = SELECT_VEHICLE_BTN_Y;
         addChild(this.selectVehicleButton);
      }
      
      override protected function showSelectedVehicle(param1:VehicleCarouselVO) : void
      {
         if(!param1.isNull)
         {
            this._selectedVehicleData = param1;
            invalidateData();
            visible = true;
         }
         else
         {
            this._selectedVehicleData = null;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         this.selectVehicleButton.visible = false;
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._selectedVehicleData != null)
            {
               this.selectVehicleButton.data = this._selectedVehicleData;
               this.selectVehicleButton.visible = true;
            }
            this.titleTF.htmlText = this._title;
            this.vehicleStatusTF.htmlText = this._statusText;
            this._vehicleSelectorCarousel.visible = this._isOpen && this._addedToDisplayList;
            this.separator.visible = this._isOpen;
            this.background.visible = this._isOpen;
            this.btnClose.visible = this._isOpen;
            this.titleTF.visible = this._isOpen;
            this.hitMc.visible = this._isOpen;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.isOpen = false;
         initSize();
         mouseEnabled = false;
         this.separator.setType(SeparatorConstants.MEDIUM_TYPE);
         this.background.mouseEnabled = false;
         this.hitMc.mouseEnabled = true;
         this.selectVehicleButton.tooltipDecorator = App.toolTipMgr;
         this.selectVehicleButton.addEventListener(ButtonEvent.CLICK,this.onSelectVehicleButtonClickHandler);
         this.btnClose.addEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.selectVehicleButton.removeEventListener(ButtonEvent.CLICK,this.onSelectVehicleButtonClickHandler);
         this.btnClose.removeEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         this.btnClose.dispose();
         this.btnClose = null;
         this.selectVehicleButton.dispose();
         this.selectVehicleButton = null;
         this.separator.dispose();
         this.separator = null;
         this._vehicleSelectorCarousel = null;
         this.vehicleStatusTF = null;
         this.titleTF = null;
         this.background = null;
         this.hitMc = null;
         this._selectedVehicleData = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._vehicleSelectorCarousel = App.instance.utils.classFactory.getComponent(QUESTS_ALIASES.VEHICLE_SELECTOR_CAROUSEL_LINKAGE,VehicleSelectorCarousel);
         this._vehicleSelectorCarousel.name = VEHICLE_SELECTOR_CAROUSEL_NAME;
         this._vehicleSelectorCarousel.x = VEHICLE_SELECTOR_CAROUSEL_LEFT;
         this._vehicleSelectorCarousel.y = VEHICLE_SELECTOR_CAROUSEL_TOP;
         registerFlashComponentS(this._vehicleSelectorCarousel,this._vehicleSelectorCarouselAlias);
      }
      
      override protected function setInitData(param1:MissionVehicleSelectorVO) : void
      {
         this._title = param1.title;
         this._statusText = param1.statusText;
         invalidateData();
      }
      
      public function as_close() : void
      {
         this.isOpen = false;
      }
      
      public function as_hideSelectedVehicle() : void
      {
         this.visible = false;
         this.isOpen = false;
      }
      
      public function setVehicleSelectorCarouselAlias(param1:String) : void
      {
         this._vehicleSelectorCarouselAlias = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return this._isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         if(param1 != this._isOpen)
         {
            this._isOpen = param1;
            if(!this._addedToDisplayList && this._isOpen)
            {
               addChild(this._vehicleSelectorCarousel);
               this._addedToDisplayList = true;
            }
            invalidateData();
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      private function onSelectVehicleButtonClickHandler(param1:ButtonEvent) : void
      {
         this.isOpen = !this._isOpen;
      }
      
      private function onBtnCloseClickHandler(param1:ButtonEvent) : void
      {
         this.isOpen = false;
      }
   }
}
