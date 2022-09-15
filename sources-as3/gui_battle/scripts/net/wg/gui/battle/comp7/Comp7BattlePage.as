package net.wg.gui.battle.comp7
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.DragType;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.comp7.infrastructure.Comp7StatisticsDataController;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.BattleTankCarousel;
   import net.wg.gui.battle.components.StatusNotificationsPanel;
   import net.wg.gui.battle.components.pointsOfInterestNotificationPanel.PointsOfInterestNotificationPanel;
   import net.wg.gui.battle.views.battleMessenger.BattleMessage;
   import net.wg.gui.battle.views.battleMessenger.BattleMessenger;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.components.vehicleHitArea.VehicleHitAreaComponent;
   import net.wg.gui.components.vehicleStatus.VehicleStatus;
   import net.wg.gui.components.vehicleStatus.data.VehicleStatusVO;
   import net.wg.infrastructure.base.meta.IComp7BattlePageMeta;
   import net.wg.infrastructure.base.meta.impl.Comp7BattlePageMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class Comp7BattlePage extends Comp7BattlePageMeta implements IComp7BattlePageMeta, IDraggable
   {
      
      private static const VEHICLE_STATUS_OFFSET_Y:int = 44;
      
      private static const MESSENGER_OFFSET:int = 0;
      
      private static const PADDINGS_1600:int = 100;
      
      private static const STATUS_TO_HINT_OFFSET:int = -130;
      
      private static const PREBATTLE_AMMO_PANEL_WIDTH_BREAKPOINT:int = 1135;
      
      private static const PREBATTLE_AMMO_PANEL_Y_SHIFT:int = -70;
      
      private static const PREBATTLE_CONSUMABLES_BOTTOM_ADDITIONAL_PADDING:int = 7;
      
      private static const HELP_BUTTON_X_OFFSET:int = 24;
      
      private static const HELP_BUTTON_Y_OFFSET:int = 15;
      
      private static const HELP_LABEL:String = "#comp7:battlePage/rulesButtonLabel";
      
      private static const MINIMAP_OFFSET:int = -2;
       
      
      public var pointsOfInterestNotificationPanel:PointsOfInterestNotificationPanel = null;
      
      public var statusNotificationsPanel:StatusNotificationsPanel = null;
      
      public var vehicleStatus:VehicleStatus = null;
      
      public var carousel:BattleTankCarousel = null;
      
      public var helpButton:Comp7HelpCtrl = null;
      
      public var vehicleHitArea:VehicleHitAreaComponent = null;
      
      private var _isDragRegister:Boolean = false;
      
      private var _isPrebattle:Boolean = false;
      
      private var _isVehicleSelectConfirmed:Boolean = false;
      
      private var _isPrebattleStateLocked:Boolean = false;
      
      private var _resetDragParams:Boolean;
      
      private var _dragOffsetX:Number = 0;
      
      private var _dragOffsetY:Number = 0;
      
      private var _hasVehicleStatus:Boolean = false;
      
      public function Comp7BattlePage()
      {
         super();
      }
      
      private static function getPrebattleSize(param1:int) : int
      {
         var _loc2_:int = App.appWidth;
         if(_loc2_ < StageSizeBoundaries.WIDTH_2560 && _loc2_ >= StageSizeBoundaries.WIDTH_1920)
         {
            return MinimapSizeConst.SIZE_INDEX_2;
         }
         if(_loc2_ >= StageSizeBoundaries.WIDTH_1366)
         {
            return MinimapSizeConst.SIZE_INDEX_1;
         }
         if(_loc2_ < StageSizeBoundaries.WIDTH_1366)
         {
            return MinimapSizeConst.MIN_SIZE_INDEX;
         }
         return param1;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         if(isDisposed())
         {
            return;
         }
         super.updateStage(param1,param2);
         this.pointsOfInterestNotificationPanel.updateStage(param1,param2);
         this.statusNotificationsPanel.updateStage(param1,param2);
         invalidateLayout();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         minimap.addEventListener(MinimapEvent.TRY_INIT_PREBATTLE_SIZE,this.onMiniMapTryInitPrebattleSize);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.helpButton.setLabel(HELP_LABEL);
         this.vehicleHitArea.hit.addEventListener(MouseEvent.MOUSE_WHEEL,this.onHitAreaMouseWheelHandler);
         this.vehicleHitArea.addEventListener(MouseEvent.ROLL_OVER,this.onVehicleHitAreaRollOverHandler);
         this.vehicleHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onVehicleHitAreaRollOutHandler);
         addChildAt(this.vehicleHitArea,getChildIndex(hitTestFix) + 1);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(_baseDisposed)
         {
            return;
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            battleTimer.visible = !this._isPrebattle;
            this.helpButton.visible = this._isPrebattle && !battleLoading.visible;
            this.helpButton.x = _originalWidth - this.helpButton.hitMc.width - HELP_BUTTON_X_OFFSET | 0;
            this.helpButton.y = HELP_BUTTON_Y_OFFSET;
            this.updateMessengerWidth();
            this.updateBattleMessengerPosition();
            updateAmmunitionPanelY();
            this.updateVehicleStatusPosition();
            this.updateHintPanelPosition();
            _loc1_ = 0;
            if(_originalWidth > StageSizeBoundaries.WIDTH_1366)
            {
               _loc1_ = PADDINGS_1600 * (_originalWidth - StageSizeBoundaries.WIDTH_1024) / (StageSizeBoundaries.WIDTH_1600 - StageSizeBoundaries.WIDTH_1024);
            }
            _loc2_ = _originalWidth >> 1;
            _loc3_ = this.getFreeSpace(_originalWidth,_loc1_);
            this.carousel.updateStage(_loc3_,_originalHeight);
            this.carousel.y = _originalHeight - this.carousel.getBottom() ^ 0;
            this.carousel.x = _loc2_ - (_loc3_ >> 1) + MESSENGER_OFFSET;
            this.vehicleHitArea.width = _originalWidth;
            this.vehicleHitArea.height = _originalHeight;
         }
      }
      
      override protected function getLoadedPrebattleAmmoPanelYShift() : int
      {
         if(this._isVehicleSelectConfirmed)
         {
            return 0;
         }
         if(_originalWidth <= PREBATTLE_AMMO_PANEL_WIDTH_BREAKPOINT)
         {
            return PREBATTLE_AMMO_PANEL_Y_SHIFT;
         }
         return PREBATTLE_CONSUMABLES_BOTTOM_ADDITIONAL_PADDING;
      }
      
      override protected function createStatisticsController() : BattleStatisticDataController
      {
         return new Comp7StatisticsDataController();
      }
      
      override protected function onPopulate() : void
      {
         registerComponent(this.pointsOfInterestNotificationPanel,BATTLE_VIEW_ALIASES.POINT_OF_INTEREST_NOTIFICATIONS_PANEL);
         registerComponent(this.statusNotificationsPanel,BATTLE_VIEW_ALIASES.STATUS_NOTIFICATIONS_PANEL);
         registerComponent(this.carousel,BATTLE_VIEW_ALIASES.COMP7_TANK_CAROUSEL);
         this.carousel.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onCarouselOnBeforeDisposeHandler);
         this.helpButton.addEventListener(MouseEvent.CLICK,this.onHelpButtonClickHandler);
         super.onPopulate();
      }
      
      override protected function updateVehicleStatus(param1:VehicleStatusVO) : void
      {
         this.vehicleStatus.setData(param1);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.helpButton.removeEventListener(MouseEvent.CLICK,this.onHelpButtonClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.carousel.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onCarouselOnBeforeDisposeHandler);
         this.vehicleHitArea.hit.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onHitAreaMouseWheelHandler);
         this.vehicleHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onVehicleHitAreaRollOverHandler);
         this.vehicleHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onVehicleHitAreaRollOutHandler);
         minimap.removeEventListener(MinimapEvent.TRY_INIT_PREBATTLE_SIZE,this.onMiniMapTryInitPrebattleSize);
         this.vehicleHitArea.dispose();
         this.vehicleHitArea = null;
         this.pointsOfInterestNotificationPanel = null;
         this.statusNotificationsPanel = null;
         this.carousel = null;
         this.helpButton.dispose();
         this.helpButton = null;
         this.vehicleStatus.dispose();
         this.vehicleStatus = null;
         super.onDispose();
      }
      
      override protected function onComponentVisibilityChanged(param1:String, param2:Boolean) : void
      {
         super.onComponentVisibilityChanged(param1,param2);
         if(param1 == BATTLE_VIEW_ALIASES.DAMAGE_PANEL)
         {
            this._isPrebattle = !param2;
            if(this._isPrebattle)
            {
               this.registerDraging();
            }
            else
            {
               this.unregisterDragging();
            }
            invalidateLayout();
         }
         else if(param1 == BATTLE_VIEW_ALIASES.FULL_STATS)
         {
            this.updateVehicleStatusPosition();
         }
      }
      
      override protected function updateBattleMessengerPosition() : void
      {
         battleMessenger.x = damagePanel.x;
         var _loc1_:int = !!this._isPrebattle ? int(height) : int(damagePanel.y);
         battleMessenger.y = _loc1_ - battleMessenger.height + MESSENGER_Y_OFFSET;
      }
      
      override protected function updateHintPanelPosition() : void
      {
         super.updateHintPanelPosition();
         if(this._hasVehicleStatus)
         {
            hintPanel.y = this.vehicleStatus.y + STATUS_TO_HINT_OFFSET;
         }
      }
      
      override protected function updateBattleMessengerSwapArea() : void
      {
         battleMessenger.isSmallState = this.isBattleMessengerSmall();
         super.updateBattleMessengerSwapArea();
      }
      
      override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._isPrebattle && !this._isPrebattleStateLocked)
         {
            _loc2_ = true;
            _loc3_ = MinimapSizeConst.MIN_SIZE_INDEX;
            _loc4_ = MinimapSizeConst.MAP_SIZE.length - 1;
            _loc5_ = App.appWidth;
            if(_loc5_ >= StageSizeBoundaries.WIDTH_2560)
            {
               _loc2_ = false;
            }
            else if(_loc5_ >= StageSizeBoundaries.WIDTH_1600)
            {
               _loc4_ = MinimapSizeConst.SIZE_INDEX_3;
            }
            else if(_loc5_ >= StageSizeBoundaries.WIDTH_1366)
            {
               _loc4_ = MinimapSizeConst.SIZE_INDEX_2;
            }
            else
            {
               _loc2_ = false;
               param1 = _loc3_;
            }
            if(_loc2_)
            {
               param1 = Math.max(_loc3_,Math.min(param1,_loc4_));
            }
            return param1;
         }
         return super.getAllowedMinimapSizeIndex(param1);
      }
      
      public function as_onPrebattleInputStateLocked(param1:Boolean) : void
      {
         this._isPrebattleStateLocked = !param1;
         this.carousel.setInteractive(param1);
      }
      
      public function as_onVehicleSelectionConfirmed() : void
      {
         this._isVehicleSelectConfirmed = true;
         this.carousel.setInteractive(!this._isVehicleSelectConfirmed);
         invalidateLayout();
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function getHitArea() : InteractiveObject
      {
         App.utils.asserter.assertNotNull(this.vehicleHitArea.hit,Errors.CANT_NULL);
         return this.vehicleHitArea.hit;
      }
      
      public function onDragging(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = !!this._resetDragParams ? Number(0) : Number(-(this._dragOffsetX - stage.mouseX));
         var _loc4_:Number = !!this._resetDragParams ? Number(0) : Number(-(this._dragOffsetY - stage.mouseY));
         this._resetDragParams = false;
         this._dragOffsetX = stage.mouseX;
         this._dragOffsetY = stage.mouseY;
         moveSpaceS(_loc3_,_loc4_,0);
      }
      
      public function onEndDrag() : void
      {
         notifyCursorDraggingS(false);
      }
      
      public function onStartDrag() : void
      {
         notifyCursorDraggingS(true);
         this._dragOffsetX = stage.mouseX;
         this._dragOffsetY = stage.mouseY;
      }
      
      private function updateMessengerWidth() : void
      {
         this.updateBattleMessengerSwapArea();
         battleMessenger.setAvailableWidthForMessages(this.getBattleMessengerWidth());
      }
      
      private function getFreeSpace(param1:int, param2:int) : int
      {
         var _loc3_:int = minimap.getMinimapTotalWidthByIndex(minimap.currentSizeIndex) + MINIMAP_OFFSET;
         var _loc4_:int = Math.max(battleMessenger.x + this.getBattleMessengerWidth() + MESSENGER_OFFSET,_loc3_);
         return param1 - (_loc4_ << 1) - param2;
      }
      
      private function getBattleMessengerWidth() : int
      {
         return !!this.isBattleMessengerSmall() ? int(BattleMessenger.BOTTOM_SIDE_WIDTH) : int(BattleMessage.DEFAULT_TEXT_WIDTH);
      }
      
      private function isBattleMessengerSmall() : Boolean
      {
         return this._isPrebattle && _originalWidth <= StageSizeBoundaries.WIDTH_1600;
      }
      
      private function registerDraging() : void
      {
         if(!this._isDragRegister)
         {
            this._isDragRegister = true;
            this.vehicleHitArea.hit.addEventListener(MouseEvent.MOUSE_WHEEL,this.onHitAreaMouseWheelHandler);
            this.vehicleHitArea.visible = true;
            App.cursor.registerDragging(this,Cursors.ROTATE);
         }
      }
      
      private function unregisterDragging() : void
      {
         if(this._isDragRegister)
         {
            this.vehicleHitArea.visible = false;
            this.vehicleHitArea.hit.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onHitAreaMouseWheelHandler);
            App.cursor.unRegisterDragging(this);
            this._isDragRegister = false;
         }
      }
      
      private function updateVehicleStatusPosition() : void
      {
         this._hasVehicleStatus = !(this._isVehicleSelectConfirmed || battleLoading.visible || fullStats.visible);
         this.vehicleStatus.visible = this._hasVehicleStatus;
         if(this._hasVehicleStatus)
         {
            this.vehicleStatus.x = _originalWidth >> 1;
            this.vehicleStatus.y = prebattleAmmunitionPanel.y - this.vehicleStatus.height + VEHICLE_STATUS_OFFSET_Y | 0;
         }
      }
      
      override protected function onMinimapSizeChangedHandler(param1:MinimapEvent) : void
      {
         super.onMinimapSizeChangedHandler(param1);
         invalidateLayout();
      }
      
      private function onHelpButtonClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            showHelpS();
         }
      }
      
      private function onCarouselOnBeforeDisposeHandler(param1:LifeCycleEvent) : void
      {
         this.carousel.tabChildren = this.carousel.tabEnabled = this.carousel.mouseChildren = this.carousel.mouseEnabled = false;
         setFocus(this);
      }
      
      private function onHitAreaMouseWheelHandler(param1:MouseEvent) : void
      {
         moveSpaceS(0,0,param1.delta * 200);
      }
      
      private function onVehicleHitAreaRollOverHandler(param1:MouseEvent) : void
      {
         notifyCursorOver3dSceneS(true);
      }
      
      private function onVehicleHitAreaRollOutHandler(param1:MouseEvent) : void
      {
         this._resetDragParams = true;
         notifyCursorOver3dSceneS(false);
      }
      
      private function onMiniMapTryInitPrebattleSize(param1:MinimapEvent) : void
      {
         minimap.setAllowedSizeIndex(this.getAllowedMinimapSizeIndex(getPrebattleSize(param1.sizeIndex)));
      }
   }
}
