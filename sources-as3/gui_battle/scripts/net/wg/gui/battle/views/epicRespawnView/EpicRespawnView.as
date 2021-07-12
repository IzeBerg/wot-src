package net.wg.gui.battle.views.epicRespawnView
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.gui.battle.views.battleTankCarousel.BattleTankCarousel;
   import net.wg.gui.battle.views.epicDeploymentMap.constants.DeploymentMapConstants;
   import net.wg.gui.battle.views.epicRespawnView.components.EpicRespawnDeployButtonGroup;
   import net.wg.gui.battle.views.epicRespawnView.components.EpicRespawnMapEntriesContainer;
   import net.wg.gui.battle.views.epicRespawnView.data.RespawnPointVO;
   import net.wg.gui.battle.views.epicRespawnView.events.EpicRespawnEvent;
   import net.wg.infrastructure.base.meta.IEpicRespawnViewMeta;
   import net.wg.infrastructure.base.meta.impl.EpicRespawnViewMeta;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
   import scaleform.clik.events.ButtonEvent;
   
   public class EpicRespawnView extends EpicRespawnViewMeta implements IEpicRespawnViewMeta, IEpicBattleStatisticDataController
   {
      
      private static const DEPLOY_BUTTON_GROUP_CAROUSEL_OFFSET:int = 83;
      
      private static const TOPBAR_TF_OFFSET_Y:int = -22;
       
      
      public var deployButtonGroup:EpicRespawnDeployButtonGroup = null;
      
      public var respawnEntriesContainer:EpicRespawnMapEntriesContainer = null;
      
      public var topBarBG:MovieClip = null;
      
      public var topBarTF:TextField = null;
      
      public var carousel:BattleTankCarousel = null;
      
      private var _originalHeight:int = 0;
      
      private var _deploymentMapWidth:int = 0;
      
      private var _deploymentMapHeight:int = 0;
      
      public function EpicRespawnView()
      {
         super();
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
         this.topBarBG = null;
         this.topBarTF = null;
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
         var _loc3_:int = 0;
         this._originalHeight = param2;
         _loc3_ = param1 >> 1;
         this.topBarBG.x = -_loc3_;
         this.topBarBG.y = 0;
         this.topBarBG.width = param1;
         var _loc4_:Number = (param2 - DeploymentMapConstants.RESPAWN_ELEMENTS_SIZE) / this._deploymentMapHeight * DeploymentMapConstants.RESPAWN_SCALE_FACTOR;
         var _loc5_:Number = _loc4_ * this._deploymentMapWidth;
         var _loc6_:Number = _loc4_ * this._deploymentMapHeight;
         this.respawnEntriesContainer.x = -_loc5_ >> 1;
         this.respawnEntriesContainer.y = DeploymentMapConstants.SCORE_PANEL_TOP_OFFSET + ((param2 - DeploymentMapConstants.RESPAWN_ELEMENTS_SIZE) * (1 - DeploymentMapConstants.RESPAWN_SCALE_FACTOR) >> 1);
         this.respawnEntriesContainer.setBounds(_loc5_,_loc6_);
         this.deployButtonGroup.x = _loc3_;
         this.topBarTF.x = -this.topBarTF.width >> 1;
         this.topBarTF.y = (this.respawnEntriesContainer.y >> 1) + TOPBAR_TF_OFFSET_Y;
         if(this.carousel != null)
         {
            this.carousel.x = -_loc3_;
            this.carousel.updateStage(param1,param2);
            this.updateCarouselElementsPositions();
         }
      }
      
      public function as_setSelectedLocation(param1:int) : void
      {
         this.respawnEntriesContainer.setSelectedLocation(param1);
         var _loc2_:RespawnPointVO = this.respawnEntriesContainer.selectedPointVO;
         this.deployButtonGroup.updateRespawnWarning(Boolean(_loc2_) ? Boolean(_loc2_.isEnemyNear) : Boolean(false));
      }
      
      override protected function setRespawnLocations(param1:Vector.<RespawnPointVO>) : void
      {
         this.respawnEntriesContainer.setRespawnLocations(param1);
      }
      
      private function updateCarouselElementsPositions() : void
      {
         var _loc1_:int = this._originalHeight - this.carousel.getBottom() ^ 0;
         this.carousel.y = _loc1_;
         this.deployButtonGroup.y = _loc1_ - DEPLOY_BUTTON_GROUP_CAROUSEL_OFFSET;
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
