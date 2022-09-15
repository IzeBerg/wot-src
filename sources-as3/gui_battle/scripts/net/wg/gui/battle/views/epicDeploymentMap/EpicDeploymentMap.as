package net.wg.gui.battle.views.epicDeploymentMap
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.views.epicDeploymentMap.components.EpicDeploymentMapEntriesContainer;
   import net.wg.gui.battle.views.epicDeploymentMap.components.EpicMapContainer;
   import net.wg.gui.battle.views.epicDeploymentMap.constants.DeploymentMapConstants;
   import net.wg.gui.battle.views.epicDeploymentMap.events.EpicDeploymentMapEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.meta.IEpicDeploymentMapMeta;
   import net.wg.infrastructure.base.meta.impl.EpicDeploymentMapMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   
   public class EpicDeploymentMap extends EpicDeploymentMapMeta implements IEpicDeploymentMapMeta
   {
      
      private static const HALF_RATIO_SCALE:Number = 0.5;
      
      private static const MAP_SCALE:Number = 0.6;
      
      private static const MAP_BACKGROUND_SCALE:Number = 1.33333333333333;
      
      private static const NORMAL_AVAILABLE_HEIGHT:int = 420;
      
      private static const LOADING_SCREEN_Y_OFFSET:int = 69;
       
      
      public var mapContainer:EpicMapContainer = null;
      
      public var bigBackground:UILoaderAlt = null;
      
      private var _isVehPostProgressionEnabled:Boolean;
      
      private var _inRespawnScreen:Boolean = false;
      
      private var _inLoadingScreen:Boolean = false;
      
      private var _entryContainer:Vector.<Sprite> = null;
      
      private var _mapWidth:int = 512;
      
      private var _mapHeight:int = 512;
      
      private var _originalWidth:int = 0;
      
      private var _originalHeight:int = 0;
      
      public function EpicDeploymentMap()
      {
         super();
         var _loc1_:EpicDeploymentMapEntriesContainer = this.mapContainer.entriesContainer;
         this._entryContainer = new <Sprite>[_loc1_.personal,_loc1_.hqs,_loc1_.points,_loc1_.aliveVehicles,_loc1_.deadVehicles,_loc1_.equipments,_loc1_.icons,_loc1_.flags,_loc1_.zones,_loc1_.landingZone];
      }
      
      override public function as_setBackground(param1:String) : void
      {
         var _loc2_:Sprite = null;
         this.bigBackground.setOriginalHeight(this._mapHeight * MAP_BACKGROUND_SCALE | 0);
         this.bigBackground.setOriginalWidth(this._mapWidth * MAP_BACKGROUND_SCALE >> 0);
         this.mapContainer.mapHit.width = this._mapWidth;
         this.mapContainer.mapHit.height = this._mapHeight;
         this.mapContainer.mapMask.width = this._mapWidth;
         this.mapContainer.mapMask.height = this._mapHeight;
         this.bigBackground.maintainAspectRatio = false;
         this.bigBackground.source = param1;
         for each(_loc2_ in this._entryContainer)
         {
            _loc2_.x = this._mapWidth * HALF_RATIO_SCALE;
            _loc2_.y = this._mapHeight * HALF_RATIO_SCALE;
         }
      }
      
      override public function getRectangles() : Vector.<Rectangle>
      {
         if(!visible)
         {
            return null;
         }
         return new <Rectangle>[this.mapContainer.mapHit.getBounds(App.stage)];
      }
      
      override protected function onDispose() : void
      {
         this.mapContainer.removeEventListener(EpicDeploymentMapEvent.MAP_CLICKED,this.onDeploymentMapClickedHandler);
         this._entryContainer.splice(0,this._entryContainer.length);
         this._entryContainer = null;
         this.bigBackground.dispose();
         this.bigBackground = null;
         this.mapContainer.dispose();
         this.mapContainer = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mapContainer.initializeMouseHandler();
         this.mapContainer.addEventListener(EpicDeploymentMapEvent.MAP_CLICKED,this.onDeploymentMapClickedHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      public function activeInLoadingScreen(param1:Boolean, param2:int, param3:int) : void
      {
         this._inLoadingScreen = param1;
         var _loc4_:EpicDeploymentMapEntriesContainer = this.mapContainer.entriesContainer;
         _loc4_.aliveVehicles.visible = _loc4_.personal.visible = _loc4_.landingZone.visible = _loc4_.zones.visible = !param1;
         this.updateStagePosition(param2,param3);
      }
      
      public function activeInRespawn(param1:Boolean, param2:int, param3:int) : void
      {
         this._inRespawnScreen = param1;
         this.updateMouseHandling();
         this.updateStagePosition(param2,param3);
      }
      
      public function as_setMapDimensions(param1:int, param2:int) : void
      {
         this._mapWidth = param1;
         this._mapHeight = param2;
      }
      
      public function updateStagePosition(param1:int, param2:int) : void
      {
         this._originalWidth = param1;
         this._originalHeight = param2;
         invalidateSize();
      }
      
      private function updateMouseHandling() : void
      {
         mouseEnabled = mouseChildren = !this._inRespawnScreen;
      }
      
      private function updateLayout() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:int = this._originalHeight * MAP_SCALE;
         if(this._inRespawnScreen)
         {
            _loc1_ = (this._originalHeight - DeploymentMapConstants.RESPAWN_ELEMENTS_SIZE) * DeploymentMapConstants.RESPAWN_SCALE_FACTOR;
         }
         else if(this._inLoadingScreen)
         {
            _loc1_ = NORMAL_AVAILABLE_HEIGHT;
         }
         _loc2_ = _loc1_ / this._mapHeight;
         _loc3_ = _loc2_ * this._mapWidth;
         _loc4_ = _loc2_ * this._mapHeight;
         this.mapContainer.scaleX = _loc2_;
         this.mapContainer.scaleY = _loc2_;
         var _loc5_:int = _loc3_ * MAP_BACKGROUND_SCALE;
         var _loc6_:int = _loc4_ * MAP_BACKGROUND_SCALE;
         this.bigBackground.x = -(_loc5_ * DeploymentMapConstants.BORDER_WIDTH_PERCENTAGE) >> 0;
         this.bigBackground.y = -(_loc6_ * DeploymentMapConstants.BORDER_WIDTH_PERCENTAGE) >> 0;
         this.bigBackground.width = _loc5_;
         this.bigBackground.height = _loc6_;
         if(this._inRespawnScreen)
         {
            this.y = DeploymentMapConstants.getScorePanelTopOffset(this._isVehPostProgressionEnabled) + ((this._originalHeight - DeploymentMapConstants.RESPAWN_ELEMENTS_SIZE) * (1 - DeploymentMapConstants.RESPAWN_SCALE_FACTOR) >> 1);
         }
         else if(this._inLoadingScreen)
         {
            this.y = (this._originalHeight - _loc4_ >> 1) - LOADING_SCREEN_Y_OFFSET;
         }
         else
         {
            this.y = this._originalHeight - _loc4_ >> 1;
         }
         this.x = this._originalWidth - _loc3_ >> 1;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(super.visible == param1)
         {
            return;
         }
         super.visible = param1;
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
      }
      
      public function set isVehPostProgressionEnabled(param1:Boolean) : void
      {
         this._isVehPostProgressionEnabled = param1;
         invalidateSize();
      }
      
      private function onDeploymentMapClickedHandler(param1:EpicDeploymentMapEvent) : void
      {
         onMinimapClickedS(param1.mouseX,param1.mouseY,param1.buttonIdx,0);
      }
   }
}
