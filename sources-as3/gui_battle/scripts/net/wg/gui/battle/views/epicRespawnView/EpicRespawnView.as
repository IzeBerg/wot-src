package net.wg.gui.battle.views.epicRespawnView
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.gui.battle.views.ammunitionPanel.EpicRespawnAmmunitionPanelView;
   import net.wg.gui.battle.views.battleTankCarousel.BattleTankCarousel;
   import net.wg.gui.battle.views.epicDeploymentMap.constants.DeploymentMapConstants;
   import net.wg.gui.battle.views.epicRespawnView.components.EpicRespawnDeployButtonGroup;
   import net.wg.gui.battle.views.epicRespawnView.components.EpicRespawnMapEntriesContainer;
   import net.wg.gui.battle.views.epicRespawnView.data.RespawnPointVO;
   import net.wg.gui.battle.views.epicRespawnView.events.EpicRespawnEvent;
   import net.wg.infrastructure.base.meta.IEpicRespawnViewMeta;
   import net.wg.infrastructure.base.meta.impl.EpicRespawnViewMeta;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.events.ButtonEvent;
   
   public class EpicRespawnView extends EpicRespawnViewMeta implements IEpicRespawnViewMeta, IEpicBattleStatisticDataController
   {
      
      private static const DEPLOY_BUTTON_GROUP_CAROUSEL_OFFSET_Y_SMALL:int = 221;
      
      private static const DEPLOY_BUTTON_GROUP_CAROUSEL_OFFSET_Y_BIG:int = 103;
      
      private static const TOPBAR_TF_OFFSET_Y:int = -22;
      
      private static const AMMUNITION_PANEL_WIDTH:int = 840;
       
      
      public var deployButtonGroup:EpicRespawnDeployButtonGroup = null;
      
      public var respawnEntriesContainer:EpicRespawnMapEntriesContainer = null;
      
      public var ammunitionPanel:EpicRespawnAmmunitionPanelView = null;
      
      public var topBarBG:MovieClip = null;
      
      public var topBarTF:TextField = null;
      
      public var carousel:BattleTankCarousel = null;
      
      private var _originalWidth:int = 0;
      
      private var _originalHeight:int = 0;
      
      private var _deploymentMapWidth:int = 0;
      
      private var _deploymentMapHeight:int = 0;
      
      private var _isVehPostProgressionEnabled:Boolean = true;
      
      public function EpicRespawnView()
      {
         super();
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         super.setCompVisible(param1);
         this.carousel.visible = param1;
         dispatchEvent(new EpicRespawnEvent(EpicRespawnEvent.VIEW_CHANGED));
         if(!param1)
         {
            App.popoverMgr.hide();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.deployButtonGroup.deployButton.label = EPIC_BATTLE.RESPAWN_DEPLOY_BUTTON;
         this.deployButtonGroup.deployButton.addEventListener(ButtonEvent.CLICK,this.onBattleBtnClickHandler);
         this.deployButtonGroup.addEventListener(EpicRespawnEvent.DEPLOYMENT_BUTTON_READY,this.onDeploymentButtonReadyHandler);
         this.topBarBG.visible = false;
         this.topBarTF.text = EPIC_BATTLE.RESPAWNSCREEN_HEADERTITLE;
         this.respawnEntriesContainer.addEventListener(EpicRespawnEvent.RESPAWN_LOCATION_SELECT,this.onRespawnLocationSelectHandler);
         this.ammunitionPanel = new EpicRespawnAmmunitionPanelView();
         addChild(this.ammunitionPanel);
      }
      
      override protected function onDispose() : void
      {
         this.carousel.removeEventListener(Event.RESIZE,this.onCarouselResizeHandler);
         this.carousel = null;
         this.deployButtonGroup.deployButton.removeEventListener(ButtonEvent.CLICK,this.onBattleBtnClickHandler);
         this.deployButtonGroup.removeEventListener(EpicRespawnEvent.DEPLOYMENT_BUTTON_READY,this.onDeploymentButtonReadyHandler);
         this.deployButtonGroup.dispose();
         this.deployButtonGroup = null;
         this.respawnEntriesContainer.removeEventListener(EpicRespawnEvent.RESPAWN_LOCATION_SELECT,this.onRespawnLocationSelectHandler);
         this.respawnEntriesContainer = null;
         if(isFlashComponentRegisteredS(BATTLE_VIEW_ALIASES.EPIC_RESPAWN_AMMUNITION_PANEL))
         {
            unregisterFlashComponentS(BATTLE_VIEW_ALIASES.EPIC_RESPAWN_AMMUNITION_PANEL);
         }
         this.topBarBG = null;
         this.topBarTF = null;
         this.ammunitionPanel = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.updateCarouselElementsPositions();
            if(hasEventListener(Event.RESIZE))
            {
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.carousel.addEventListener(Event.RESIZE,this.onCarouselResizeHandler);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.carousel,BATTLE_VIEW_ALIASES.BATTLE_TANK_CAROUSEL);
         registerFlashComponentS(this.ammunitionPanel,BATTLE_VIEW_ALIASES.EPIC_RESPAWN_AMMUNITION_PANEL);
      }
      
      override protected function setRespawnLocations(param1:Vector.<RespawnPointVO>) : void
      {
         this.respawnEntriesContainer.setRespawnLocations(param1);
      }
      
      public function as_handleAsReplay() : void
      {
         mouseEnabled = mouseChildren = false;
      }
      
      public function as_resetRespawnState() : void
      {
         this.deployButtonGroup.reset();
      }
      
      public function as_setLaneState(param1:int, param2:Boolean, param3:String) : void
      {
         this.respawnEntriesContainer.setLaneLockedState(param1 - 1,!param2,param3);
      }
      
      public function as_setMapDimensions(param1:int, param2:int) : void
      {
         this._deploymentMapWidth = param1;
         this._deploymentMapHeight = param2;
      }
      
      public function as_setSelectedLocation(param1:int) : void
      {
         this.respawnEntriesContainer.setSelectedLocation(param1);
         var _loc2_:RespawnPointVO = this.respawnEntriesContainer.selectedPointVO;
         this.deployButtonGroup.updateRespawnWarning(Boolean(_loc2_) ? Boolean(_loc2_.isEnemyNear) : Boolean(false));
      }
      
      public function as_updateAutoTimer(param1:Boolean, param2:String) : void
      {
         this.deployButtonGroup.updateAutoTimer(param1,param2);
      }
      
      public function as_updateTimer(param1:Boolean, param2:String) : void
      {
         this.deployButtonGroup.updateTimer(param1,param2);
      }
      
      public function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
      }
      
      public function updateEpicPlayerStats(param1:EpicPlayerStatsVO) : void
      {
      }
      
      public function updateEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._originalWidth = param1;
         this._originalHeight = param2;
         invalidate(InvalidationType.SIZE);
      }
      
      private function updateLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this._originalWidth >> 1;
         this.topBarBG.x = -_loc1_;
         this.topBarBG.y = 0;
         this.topBarBG.width = this._originalWidth;
         var _loc2_:Number = (this._originalHeight - DeploymentMapConstants.RESPAWN_ELEMENTS_SIZE) / this._deploymentMapHeight * DeploymentMapConstants.RESPAWN_SCALE_FACTOR;
         var _loc3_:Number = _loc2_ * this._deploymentMapWidth;
         var _loc4_:Number = _loc2_ * this._deploymentMapHeight;
         this.respawnEntriesContainer.x = -_loc3_ >> 1;
         this.respawnEntriesContainer.y = DeploymentMapConstants.getScorePanelTopOffset(this._isVehPostProgressionEnabled) + ((this._originalHeight - DeploymentMapConstants.RESPAWN_ELEMENTS_SIZE) * (1 - DeploymentMapConstants.RESPAWN_SCALE_FACTOR) >> 1);
         this.respawnEntriesContainer.setBounds(_loc3_,_loc4_);
         this.deployButtonGroup.x = _loc1_;
         this.topBarTF.x = -this.topBarTF.width >> 1;
         this.topBarTF.y = (this.respawnEntriesContainer.y >> 1) + TOPBAR_TF_OFFSET_Y;
         if(this.carousel != null)
         {
            this.carousel.x = -_loc1_;
            this.carousel.updateStage(this._originalWidth,this._originalHeight);
            this.updateCarouselElementsPositions();
         }
         if(this.ammunitionPanel)
         {
            this.ammunitionPanel.visible = this._isVehPostProgressionEnabled;
            this.ammunitionPanel.x = -this.ammunitionPanel.width >> 1;
         }
      }
      
      private function updateCarouselElementsPositions() : void
      {
         var _loc1_:int = this._originalHeight - this.carousel.getBottom() ^ 0;
         this.carousel.y = _loc1_;
         var _loc2_:int = this._originalWidth <= StageSizeBoundaries.WIDTH_1366 && this._isVehPostProgressionEnabled ? int(DEPLOY_BUTTON_GROUP_CAROUSEL_OFFSET_Y_SMALL) : int(DEPLOY_BUTTON_GROUP_CAROUSEL_OFFSET_Y_BIG);
         this.deployButtonGroup.y = _loc1_ - _loc2_;
         this.deployButtonGroup.isWide = this._originalWidth >= StageSizeBoundaries.WIDTH_1920;
         this.ammunitionPanel.setSize(AMMUNITION_PANEL_WIDTH,_loc1_ - (this.respawnEntriesContainer.y + this.respawnEntriesContainer.bounds.height));
         this.ammunitionPanel.y = _loc1_ - this.ammunitionPanel.height;
      }
      
      public function set isVehPostProgressionEnabled(param1:Boolean) : void
      {
         this._isVehPostProgressionEnabled = param1;
         invalidateSize();
      }
      
      private function onCarouselResizeHandler(param1:Event) : void
      {
         invalidateState();
      }
      
      private function onBattleBtnClickHandler(param1:ButtonEvent) : void
      {
         onRespawnBtnClickS();
      }
      
      private function onDeploymentButtonReadyHandler(param1:EpicRespawnEvent) : void
      {
         onDeploymentReadyS();
      }
      
      private function onRespawnLocationSelectHandler(param1:EpicRespawnEvent) : void
      {
         onLocationSelectedS(param1.locationIdx);
      }
   }
}
