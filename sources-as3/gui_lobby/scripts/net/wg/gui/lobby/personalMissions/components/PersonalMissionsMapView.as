package net.wg.gui.lobby.personalMissions.components
{
   import fl.motion.easing.Cubic;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.gui.lobby.personalMissions.data.MapSettingsData;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsMapPlanVO;
   import net.wg.gui.lobby.personalMissions.events.ChainEvent;
   import net.wg.gui.lobby.personalMissions.events.PlanLoaderEvent;
   import net.wg.gui.lobby.personalMissions.events.PlanRegionEvent;
   import net.wg.infrastructure.base.meta.IPersonalMissionsMapViewMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionsMapViewMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class PersonalMissionsMapView extends PersonalMissionsMapViewMeta implements IViewStackContent, IPersonalMissionsMapViewMeta
   {
      
      private static const MAX_MAP_LEN:int = 2;
      
      private static const SHOW_HIDE_PLAN_TIME:int = 250;
      
      private static const MOVE_MAP_TIME:int = 700;
      
      private static const ORIGINAL_WIDTH:Number = 1150;
      
      private static const ORIGINAL_HEIGHT:Number = 740;
      
      private static const LEFT_DIRECTION:String = "left";
      
      private static const RIGHT_DIRECTION:String = "right";
      
      private static const PLAN_X_OFFSET:int = 100;
      
      private static const PLAN_Y_OFFSET:int = 60;
      
      private static const INVALID_PLAN_VISIBILITY:String = "invalid_plan_visibility";
      
      private static const SHADOWS_WIDTH:int = 1920;
      
      private static const SHADOWS_COEFF:int = 150;
      
      private static const HEIGHT_SCALE_DIV:int = 780;
      
      private static const BLUR_DISTANCE:int = 16;
      
      private static const BLUR_QUALITY:int = 2;
       
      
      public var mapImageSeason0:PersonalMissionMapBgContainer = null;
      
      public var mapImageSeason1:PersonalMissionMapBgContainer = null;
      
      public var shadow:Sprite = null;
      
      public var leftBG:DisplayObject = null;
      
      public var rightBG:DisplayObject = null;
      
      public var leftShadow:DisplayObject = null;
      
      public var rightShadow:DisplayObject = null;
      
      public var footerShadow:DisplayObject = null;
      
      private var _isMapReadyCount:int = 0;
      
      private var _isMapMoving:Boolean = false;
      
      private var _isContentShown:Boolean = true;
      
      private var _plan:PersonalMissionsPlan = null;
      
      private var _planLnk:String = "";
      
      private var _planModel:PersonalMissionsMapPlanVO = null;
      
      private var _needChangePlanLinkage:Boolean = false;
      
      private var _currentMap:Sprite = null;
      
      private var _nextMap:Sprite = null;
      
      private var _planReady:Boolean = false;
      
      private var _mapVisibilityInited:Boolean = false;
      
      private var _mapReady:Boolean = false;
      
      private var _direction:String = "";
      
      private var _currentChainID:int = -1;
      
      private var _currentOperationID:int = -1;
      
      private var _needHidePlan:Boolean = false;
      
      private var _needInstantMapMove:Boolean = false;
      
      private var _needMapChange:Boolean = false;
      
      private var _needMapMove:Boolean = false;
      
      private var _needEnsureInvisible:Boolean = false;
      
      private var _showPlanTween:Tween = null;
      
      private var _mapMoveTween:Tween = null;
      
      private var _hidePlanTween:Tween = null;
      
      private var _nextMapX:int;
      
      private var _nextMapY:int;
      
      private var _mapOffset:Point = null;
      
      private var _mapPoints:Object = null;
      
      private var _chainOrder:Array = null;
      
      private var _mapsLinkages:Object = null;
      
      private var _pmType:int = -1;
      
      private var _plansLoaderMgr:PersonalMissionPlansLoaderMgr;
      
      public function PersonalMissionsMapView()
      {
         super();
         this._plansLoaderMgr = new PersonalMissionPlansLoaderMgr();
         this._plansLoaderMgr.addEventListener(PlanLoaderEvent.PLAN_READY,this.onPlansLoaderMgrPlanReadyHandler);
         this.mapImageSeason0.addEventListener(Event.COMPLETE,this.onMapLoadCompleteHandler);
         this.mapImageSeason1.addEventListener(Event.COMPLETE,this.onMapLoadCompleteHandler);
      }
      
      override protected function setPlanData(param1:PersonalMissionsMapPlanVO) : void
      {
         if(param1 != null && this._planModel != param1)
         {
            this._planModel = param1;
            invalidateData();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.shadow.mouseChildren = this.shadow.mouseEnabled = false;
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         this.tryMoveMapShowPlan();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         this.mapImageSeason0.removeEventListener(Event.COMPLETE,this.onMapLoadCompleteHandler);
         this.mapImageSeason1.removeEventListener(Event.COMPLETE,this.onMapLoadCompleteHandler);
         this.mapImageSeason0.dispose();
         this.mapImageSeason1.dispose();
         this.mapImageSeason0 = null;
         this.mapImageSeason1 = null;
         this.disposeShowPlanTween();
         if(this._mapMoveTween != null)
         {
            this._mapMoveTween.paused = true;
            this._mapMoveTween.dispose();
            this._mapMoveTween = null;
         }
         if(this._hidePlanTween != null)
         {
            this._hidePlanTween.paused = true;
            this._hidePlanTween.dispose();
            this._hidePlanTween = null;
         }
         this.clearPlan();
         this.shadow = null;
         this.footerShadow = null;
         this.leftBG = null;
         this.rightBG = null;
         this.leftShadow = null;
         this.rightShadow = null;
         this._planModel = null;
         this.clearFilters();
         this._currentMap = null;
         this._nextMap = null;
         App.utils.data.cleanupDynamicObject(this._mapPoints);
         this._mapPoints = null;
         this._mapOffset = null;
         this._chainOrder.splice(0,this._chainOrder.length);
         this._chainOrder = null;
         App.utils.data.cleanupDynamicObject(this._mapsLinkages);
         this._mapsLinkages = null;
         this._plansLoaderMgr.removeEventListener(PlanLoaderEvent.PLAN_READY,this.onPlansLoaderMgrPlanReadyHandler);
         this._plansLoaderMgr.dispose();
         this._plansLoaderMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._planModel != null && isInvalid(InvalidationType.DATA))
         {
            this._planReady = false;
            this._needInstantMapMove = this._currentChainID == Values.DEFAULT_INT || this._currentOperationID == Values.DEFAULT_INT;
            this._needMapMove = false;
            if(!this._needInstantMapMove)
            {
               this._needMapChange = this._currentOperationID != this._planModel.operationID;
               this._needMapMove = !this._needMapChange && this._planModel.chainID != this._currentChainID;
               if(this._needMapChange)
               {
                  this._direction = this._currentOperationID < this._planModel.operationID ? LEFT_DIRECTION : RIGHT_DIRECTION;
               }
            }
            this._currentChainID = this._planModel.chainID;
            this._currentOperationID = this._planModel.operationID;
            this._needChangePlanLinkage = this._planLnk != this._mapsLinkages[this._planModel.chainID];
            this._needHidePlan = this._needChangePlanLinkage || this._needMapChange || this._needMapMove;
            if(this._plan != null)
            {
               this.tryHidePlan();
            }
            else
            {
               this.changePlanLnk();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.shadow.width = width;
            this.shadow.height = height;
            this.footerShadow.width = width;
            this.footerShadow.y = height;
            if(this._plan != null)
            {
               this.positionPlan();
               if(this._mapReady && !this._mapVisibilityInited)
               {
                  this._mapVisibilityInited = true;
                  this.mapImageSeason0.alpha = Values.DEFAULT_ALPHA;
                  this.mapImageSeason1.alpha = Values.DEFAULT_ALPHA;
               }
            }
         }
         if(this._plan != null && isInvalid(INVALID_PLAN_VISIBILITY))
         {
            if(this._mapMoveTween == null || this._mapMoveTween != null && this._mapMoveTween.paused)
            {
               this.showPlan();
            }
         }
      }
      
      public function as_getPmType() : int
      {
         return this._pmType;
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function init(param1:int) : void
      {
         if(this._pmType == param1)
         {
            return;
         }
         this._currentChainID = Values.DEFAULT_INT;
         this._currentOperationID = Values.DEFAULT_INT;
         this._pmType = param1;
         this.clearFilters();
         var _loc2_:String = param1 == PERSONAL_MISSIONS_ALIASES.PERONAL_MISSIONS_PM_TYPE_REGULAR ? RES_ICONS.MAPS_ICONS_PERSONALMISSIONS_MAP_1 : RES_ICONS.MAPS_ICONS_PERSONALMISSIONS_MAP_2;
         this.mapImageSeason0.map = _loc2_;
         this.mapImageSeason1.map = _loc2_;
         this._nextMap = this.mapImageSeason0;
         this._currentMap = this.mapImageSeason1;
         this._nextMap.visible = true;
         this._currentMap.visible = true;
         this._nextMap.alpha = Values.ZERO;
         this._currentMap.alpha = Values.ZERO;
         this._mapPoints = MapSettingsData.getMapPoints(param1);
         this._mapOffset = MapSettingsData.getMapOffsets(param1);
         this._chainOrder = MapSettingsData.getChainOrder(param1);
         this._mapsLinkages = MapSettingsData.getPlanLinkage(param1);
         if(!this._isContentShown)
         {
            this._isContentShown = true;
            this.showHideContent(false);
         }
      }
      
      public function reinit(param1:int) : void
      {
         this.clearPlan();
         this._isMapReadyCount = Values.ZERO;
         this._mapVisibilityInited = false;
         this.init(param1);
      }
      
      public function showHideContent(param1:Boolean) : void
      {
         if(this._isContentShown == param1)
         {
            return;
         }
         this._isContentShown = param1;
         if(this._nextMap && this._plan)
         {
            if(param1)
            {
               this._nextMap.filters = [];
               this._plan.filters = [];
            }
            else
            {
               App.utils.commons.setBlur(this._nextMap,BLUR_DISTANCE,BLUR_DISTANCE,BLUR_QUALITY);
               App.utils.commons.setBlur(this._plan,BLUR_DISTANCE,BLUR_DISTANCE,BLUR_QUALITY);
            }
         }
      }
      
      public function update(param1:Object) : void
      {
      }
      
      private function clearFilters() : void
      {
         if(this._nextMap != null)
         {
            this._nextMap.filters = [];
         }
         if(this._plan != null)
         {
            this._plan.filters = [];
         }
      }
      
      private function tryHidePlan() : void
      {
         var _loc1_:Function = this.changePlanData;
         if(this._needHidePlan || this._needChangePlanLinkage)
         {
            this._needEnsureInvisible = true;
            if(this._needChangePlanLinkage)
            {
               _loc1_ = this.changePlanLnk;
            }
            this._hidePlanTween = new Tween(SHOW_HIDE_PLAN_TIME,this._plan,{"alpha":0},{
               "ease":Cubic.easeInOut,
               "paused":false,
               "onComplete":_loc1_
            });
         }
         else
         {
            _loc1_();
         }
      }
      
      private function changePlanLnk() : void
      {
         this._planLnk = this._mapsLinkages[this._planModel.chainID];
         this._plansLoaderMgr.loadPlanByName(MapSettingsData.getPlanSwfByLinkage(this._planLnk));
      }
      
      private function changePlanData() : void
      {
         if(this._needEnsureInvisible)
         {
            this._plan.alpha = 0;
            this._plan.visible = false;
            this._needEnsureInvisible = false;
         }
         if(this._planModel != null && this._plan != null)
         {
            this._plan.setData(this._planModel);
            this._plan.validateNow();
            invalidateSize();
         }
         this._planReady = true;
         this.tryMoveMapShowPlan();
      }
      
      private function tryMoveMapShowPlan() : void
      {
         if(this._planReady && this._mapReady)
         {
            this._planReady = false;
            if(this._needInstantMapMove || this._needMapChange || this._needMapMove)
            {
               this.moveMap();
            }
            else
            {
               this.invalidatePlanVisibility();
            }
         }
      }
      
      private function positionPlan() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:Number = 1;
         if(width < ORIGINAL_WIDTH)
         {
            _loc1_ = width / ORIGINAL_WIDTH;
         }
         else if(height < ORIGINAL_HEIGHT)
         {
            _loc1_ = height / HEIGHT_SCALE_DIV;
         }
         this._plan.scaleX = this._plan.scaleY = _loc1_;
         this._currentMap.scaleX = this._currentMap.scaleY = _loc1_;
         this._nextMap.scaleX = this._nextMap.scaleY = _loc1_;
         this._plan.x = (width - this._plan.hitArea.width * _loc1_ >> 1) + PLAN_X_OFFSET;
         this._plan.y = (height - this._plan.hitArea.height * _loc1_ >> 1) + PLAN_Y_OFFSET;
         if(!this._isMapMoving)
         {
            this._currentMap.x = this._nextMap.x = this._plan.x - this._mapOffset.x * _loc1_ | 0;
            this._currentMap.y = this._nextMap.y = this._plan.y - this._mapOffset.y * _loc1_ + this._mapPoints[this._currentChainID] * _loc1_ | 0;
            _loc2_ = width > SHADOWS_WIDTH * _loc1_;
            this.leftShadow.visible = this.rightShadow.visible = _loc2_;
            this.leftBG.visible = this.rightBG.visible = _loc2_;
            if(_loc2_)
            {
               _loc3_ = (width - SHADOWS_WIDTH * _loc1_) / SHADOWS_COEFF + 1;
               _loc4_ = height + LobbyMetrics.LOBBY_MESSENGER_HEIGHT;
               this.leftShadow.y = 0;
               this.leftShadow.x = this._nextMap.x;
               this.leftShadow.scaleX = _loc3_;
               this.leftShadow.height = _loc4_;
               this.rightShadow.scaleX = _loc3_;
               this.rightShadow.x = this._nextMap.x + this._nextMap.width;
               this.rightShadow.y = _loc4_;
               this.rightShadow.height = _loc4_;
               this.leftBG.x = 0;
               this.leftBG.y = 0;
               this.leftBG.width = this.leftShadow.x;
               this.leftBG.height = _loc4_;
               this.rightBG.x = this.rightShadow.x;
               this.rightBG.y = 0;
               this.rightBG.width = width - this.rightShadow.x;
               this.rightBG.height = _loc4_;
            }
         }
      }
      
      private function showPlan() : void
      {
         this._plan.alpha = 0;
         this._plan.visible = true;
         this._showPlanTween = new Tween(SHOW_HIDE_PLAN_TIME,this._plan,{"alpha":1},{
            "ease":Cubic.easeInOut,
            "paused":false,
            "onComplete":this.ensurePlanShown
         });
      }
      
      private function ensurePlanShown() : void
      {
         this.disposeShowPlanTween();
         this.positionPlan();
         this._plan.alpha = 1;
      }
      
      private function disposeShowPlanTween() : void
      {
         if(this._showPlanTween != null)
         {
            this._showPlanTween.paused = true;
            this._showPlanTween.dispose();
            this._showPlanTween = null;
         }
      }
      
      private function invalidatePlanVisibility() : void
      {
         this._isMapMoving = false;
         invalidate(INVALID_PLAN_VISIBILITY);
      }
      
      private function moveMap() : void
      {
         var _loc3_:Sprite = null;
         var _loc1_:Function = Cubic.easeInOut;
         if(this._isMapMoving)
         {
            if(this._mapMoveTween != null)
            {
               this._mapMoveTween.paused = true;
               this._mapMoveTween.dispose();
            }
            if(!this._needMapChange)
            {
               _loc1_ = null;
            }
            else
            {
               this._nextMap.x = this._nextMapX;
               this._nextMap.y = this._nextMapY;
            }
         }
         else
         {
            this._isMapMoving = true;
         }
         this.positionPlan();
         var _loc2_:Number = this._plan.scaleX;
         this._nextMapX = this._plan.x - this._mapOffset.x * _loc2_;
         this._nextMapY = this._plan.y - this._mapOffset.y * _loc2_ + this._mapPoints[this._currentChainID] * _loc2_;
         if(this._needInstantMapMove)
         {
            this._nextMap.x = this._nextMapX;
            this._nextMap.y = this._nextMapY;
            this.invalidatePlanVisibility();
         }
         else
         {
            if(this._needMapChange)
            {
               _loc3_ = this._currentMap;
               this._currentMap = this._nextMap;
               this._nextMap = _loc3_;
               this._nextMap.x = this._direction == LEFT_DIRECTION ? Number(width) : Number(-this._nextMap.width);
               this._nextMap.y = this._nextMapY;
               setChildIndex(this._currentMap,0);
            }
            else
            {
               this._nextMap.visible = true;
            }
            if(this._showPlanTween != null && !this._showPlanTween.paused)
            {
               this.disposeShowPlanTween();
               this._plan.alpha = 0;
               this._plan.visible = false;
            }
            this._mapMoveTween = new Tween(MOVE_MAP_TIME,this._nextMap,{
               "x":this._nextMapX,
               "y":this._nextMapY
            },{
               "ease":_loc1_,
               "onComplete":this.invalidatePlanVisibility
            });
         }
      }
      
      private function clearPlan() : void
      {
         if(this._plan != null)
         {
            this._plan.alpha = 0;
            this._plan.visible = false;
            removeChild(this._plan);
            this._plan.removeEventListener(PlanRegionEvent.CLICK,this.onPlanClickHandler);
            this._plan.dispose();
            this._plan = null;
         }
      }
      
      private function onMapLoadCompleteHandler(param1:Event) : void
      {
         ++this._isMapReadyCount;
         if(this._isMapReadyCount == MAX_MAP_LEN)
         {
            this._mapReady = true;
            invalidateSize();
         }
      }
      
      private function onPlansLoaderMgrPlanReadyHandler(param1:PlanLoaderEvent) : void
      {
         if(MapSettingsData.getPlanSwfByLinkage(this._planLnk) == param1.swfUrl)
         {
            this.clearPlan();
            this._plan = App.utils.classFactory.getComponent(this._planLnk,PersonalMissionsPlan);
            this._plan.visible = false;
            addChild(this._plan);
            setChildIndex(this.shadow,numChildren - 1);
            this._plan.addEventListener(PlanRegionEvent.CLICK,this.onPlanClickHandler);
            if(!this._isContentShown)
            {
               App.utils.commons.setBlur(this._nextMap,BLUR_DISTANCE,BLUR_DISTANCE,BLUR_QUALITY);
               App.utils.commons.setBlur(this._plan,BLUR_DISTANCE,BLUR_DISTANCE,BLUR_QUALITY);
            }
            else
            {
               this._plan.filters = [];
            }
            this.changePlanData();
         }
      }
      
      private function onPlanClickHandler(param1:PlanRegionEvent) : void
      {
         onRegionClickS(param1.id);
      }
      
      private function onMouseWheelHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if((this._mapMoveTween == null || this._mapMoveTween != null && this._mapMoveTween.paused) && (this._hidePlanTween == null || this._hidePlanTween != null && this._hidePlanTween.paused) && (this._showPlanTween == null || this._showPlanTween != null && this._showPlanTween.paused))
         {
            _loc2_ = this._chainOrder.indexOf(this._currentChainID);
            if(param1.delta > 0)
            {
               if(_loc2_ - 1 >= 0)
               {
                  App.toolTipMgr.hide();
                  dispatchEvent(new ChainEvent(ChainEvent.CHAIN_CHANGED,this._chainOrder[_loc2_ - 1]));
               }
            }
            else if(_loc2_ + 1 < this._chainOrder.length)
            {
               App.toolTipMgr.hide();
               dispatchEvent(new ChainEvent(ChainEvent.CHAIN_CHANGED,this._chainOrder[_loc2_ + 1]));
            }
         }
      }
   }
}
