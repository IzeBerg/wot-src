package net.wg.gui.lobby.missions
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUESTS_ALIASES;
   import net.wg.gui.lobby.components.MissionsVehicleSelector;
   import net.wg.gui.lobby.components.data.BaseMissionDetailedViewVO;
   import net.wg.gui.lobby.components.data.BaseMissionDetailsContainerVO;
   import net.wg.gui.lobby.components.interfaces.IMissionsVehicleSelector;
   import net.wg.gui.lobby.missions.data.MissionDetailedViewVO;
   import net.wg.gui.lobby.missions.data.MissionDetailsContainerVO;
   import net.wg.gui.lobby.missions.event.MissionDetailedConditionRendererEvent;
   import net.wg.infrastructure.base.meta.IMissionDetailsContainerViewMeta;
   import net.wg.infrastructure.base.meta.impl.MissionDetailsContainerViewMeta;
   
   public class MissionDetailsContainerView extends MissionDetailsContainerViewMeta implements IMissionDetailsContainerViewMeta
   {
      
      private static const VIEW_WIDTH:int = 753;
      
      private static const BTN_CLOSE_WIDTH:int = 70;
      
      private static const NUM_BTN_HEIGHT:int = 32;
      
      private static const MIN_HEIGHT:int = 677;
      
      private static const MIN_CMP_PADDING:int = 12;
      
      private static const BTN_CLOSE_HEIGHT:int = 32;
      
      private static const ARROW_BTN_GAP:int = 25;
      
      private static const VEHICLE_SELECTOR_NAME:String = "vehicleSelector";
      
      private static const VEHICLE_SELECTOR_TOP:int = 1;
      
      private static const VEHICLE_SELECTOR_LEFT:int = 1;
      
      private static const CLOSE_BTN_ALPHA_FADED:Number = 0.5;
      
      private static const CLOSE_BTN_ALPHA_DEFAULT:Number = Values.DEFAULT_ALPHA;
       
      
      private var _vehicleSelector:IMissionsVehicleSelector = null;
      
      public function MissionDetailsContainerView()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._vehicleSelector = App.instance.utils.classFactory.getComponent(QUESTS_ALIASES.MISSIONS_VEHICLE_SELECTOR_LINKAGE,MissionsVehicleSelector);
         this._vehicleSelector.name = VEHICLE_SELECTOR_NAME;
         this._vehicleSelector.setVehicleSelectorCarouselAlias(QUESTS_ALIASES.VEHICLE_SELECTOR_CAROUSEL_ALIAS);
         registerFlashComponentS(this._vehicleSelector,QUESTS_ALIASES.MISSIONS_VEHICLE_SELECTOR_ALIAS);
         addChild(DisplayObject(this._vehicleSelector));
         this._vehicleSelector.addEventListener(Event.CHANGE,this.onVehicleSelectorChangeHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         MissionDetailedView(view).addEventListener(MissionDetailedConditionRendererEvent.BUY_CLICK,this.onTokenBuyClickHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         this._vehicleSelector.removeEventListener(Event.CHANGE,this.onVehicleSelectorChangeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         MissionDetailedView(view).removeEventListener(MissionDetailedConditionRendererEvent.BUY_CLICK,this.onTokenBuyClickHandler);
         removeChild(DisplayObject(this._vehicleSelector));
         this._vehicleSelector = null;
         super.onDispose();
      }
      
      override protected function updateLayout() : void
      {
         super.updateLayout();
         var _loc1_:int = _height / MIN_HEIGHT * MIN_CMP_PADDING;
         var _loc2_:int = view.height + BTN_CLOSE_HEIGHT + NUM_BTN_HEIGHT + (_loc1_ << 1);
         btnClose.y = (height - _loc2_ - TOP_PANEL_HEIGHT >> 1) + TOP_PANEL_HEIGHT;
         btnClose.x = (_width + VIEW_WIDTH >> 1) - BTN_CLOSE_WIDTH;
         view.y = btnClose.y + BTN_CLOSE_HEIGHT + _loc1_ >> 0;
         this._vehicleSelector.x = view.x - (this._vehicleSelector.width >> 1) + VEHICLE_SELECTOR_LEFT;
         this._vehicleSelector.y = view.y + VEHICLE_SELECTOR_TOP;
      }
      
      override protected function getBaseMissionDetailsContainerVOForData(param1:Object) : BaseMissionDetailsContainerVO
      {
         return new MissionDetailsContainerVO(param1);
      }
      
      override protected function addListeners() : void
      {
         super.addListeners();
         bg.addEventListener(MouseEvent.CLICK,this.onBgClickHandler);
      }
      
      override protected function removeListeners() : void
      {
         super.removeListeners();
         bg.removeEventListener(MouseEvent.CLICK,this.onBgClickHandler);
      }
      
      override protected function getBaseMissionDetailedViewVOForData(param1:Object) : BaseMissionDetailedViewVO
      {
         return new MissionDetailedViewVO(param1);
      }
      
      override public function set viewOpacity(param1:Number) : void
      {
         super.viewOpacity = param1;
         this._vehicleSelector.alpha = param1;
      }
      
      private function onTokenBuyClickHandler(param1:MissionDetailedConditionRendererEvent) : void
      {
         onTokenBuyClickS(param1.tokenId,param1.questId);
      }
      
      private function onBgClickHandler(param1:MouseEvent) : void
      {
         closeViewS();
      }
      
      private function onVehicleSelectorChangeHandler(param1:Event) : void
      {
         btnClose.alpha = !!this._vehicleSelector.isOpen ? Number(CLOSE_BTN_ALPHA_FADED) : Number(CLOSE_BTN_ALPHA_DEFAULT);
         view.setContentVisible(!this._vehicleSelector.isOpen);
      }
   }
}
