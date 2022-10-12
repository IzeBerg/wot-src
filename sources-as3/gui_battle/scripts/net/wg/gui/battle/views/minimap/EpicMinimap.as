package net.wg.gui.battle.views.minimap
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.gui.battle.views.minimap.containers.EpicMinimapEntriesContainer;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.meta.IEpicMinimapMeta;
   import net.wg.infrastructure.base.meta.impl.EpicMinimapMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
   import scaleform.gfx.MouseEventEx;
   
   public class EpicMinimap extends EpicMinimapMeta implements IEpicBattleStatisticDataController, IEpicMinimapMeta
   {
      
      private static const BORDER_OFFSET:int = -14;
      
      private static const TOPLEFT_OFFSET:Point = new Point(0,-60);
      
      private static const FRAME_WIDTH_MULTIPLIER:int = 2;
      
      private static const FRAME_BORDER_WIDTH:int = 24;
      
      private static const MMAP_BASE_SIZE:int = 210;
      
      private static const SECTORS_FIELD:String = "sectors";
      
      private static const MAX_ZOOM_MODE:uint = 2;
      
      private static const ZOOM_MODE_STEP:Number = 0.5;
      
      private static const MINIMAP_SCALE:Vector.<Number> = new <Number>[1,1.21,1.48,1.86,2.33,2.9,3.33];
      
      private static const MINIMAP_SIZE:Vector.<uint> = new <uint>[216,260,320,400,502,624,700];
      
      public static const TAB_MODE_502_IDX:int = MINIMAP_SIZE.indexOf(502);
      
      public static const TAB_MODE_700_IDX:int = MINIMAP_SIZE.indexOf(700);
       
      
      public var mapHit:Sprite = null;
      
      public var mapShortcutLabel:MovieClip = null;
      
      public var mapZoomMode:MovieClip = null;
      
      public var entriesContainer:EpicMinimapEntriesContainer = null;
      
      public var bgFrame:Sprite = null;
      
      public var fgFrame:Sprite = null;
      
      public var background:UILoaderAlt = null;
      
      private var _clickAreaSpr:Sprite;
      
      private var _updateSizeIndexForce:Boolean = false;
      
      private var _currentSizeIndex:int = 0;
      
      private var _savedSizeIndex:int = 0;
      
      private var _mapWidth:int = 210;
      
      private var _mapHeight:int = 210;
      
      private var _sectors:Vector.<MovieClip> = null;
      
      private var _sectorState:Vector.<int>;
      
      private var _isAttacker:Boolean = false;
      
      private var _isTabMode:Boolean = false;
      
      private var _zoomMode:Number = 0;
      
      private var _settingsAlpha:Number = 1.0;
      
      private var _tabModeCustomAlpha:Number = 1.0;
      
      private var _isTabModeCustomAlpha:Boolean = false;
      
      private var _mapScaleIndex:int = 1;
      
      public function EpicMinimap()
      {
         this._clickAreaSpr = new Sprite();
         this._sectorState = new <int>[0,0,0,0,0,0,0];
         super();
         this.background = this.entriesContainer.background;
         addChildAt(this._clickAreaSpr,getChildIndex(this.mapHit));
         this.mapHit.visible = true;
         this._clickAreaSpr.hitArea = this.mapHit;
         this.mapZoomMode.visible = true;
         this.mapShortcutLabel.sectorOverview.mmapAreaHighlight.visible = false;
         if(TAB_MODE_502_IDX < 0 || TAB_MODE_700_IDX < 0)
         {
            App.utils.asserter.assert(false,"You must update constants TAB_MODE because MINIMAP_SIZEs were changed");
         }
      }
      
      override public function as_setAlpha(param1:Number) : void
      {
         if(this._settingsAlpha != param1)
         {
            this._settingsAlpha = param1;
            this.updateAlpha();
         }
      }
      
      override public function as_setBackground(param1:String) : void
      {
         this.background.setOriginalHeight(this._mapHeight);
         this.background.setOriginalWidth(this._mapWidth);
         this.background.maintainAspectRatio = false;
         this.background.source = param1;
      }
      
      override public function as_setSize(param1:int) : void
      {
         if(this._isTabMode)
         {
            return;
         }
         if(initialized)
         {
            this._updateSizeIndexForce = true;
            this.checkNewSize(param1);
         }
         else
         {
            this._currentSizeIndex = param1;
         }
      }
      
      override public function getMessageCoordinate() : Number
      {
         return this.currentHeight - this.currentTopLeftPoint.y;
      }
      
      override public function getMinimapRectBySizeIndex(param1:int) : Rectangle
      {
         var _loc2_:int = this._currentSizeIndex;
         if(param1 >= 0 && param1 < MINIMAP_SIZE.length)
         {
            _loc2_ = param1;
         }
         return new Rectangle(0,0,MINIMAP_SIZE[_loc2_],MINIMAP_SIZE[_loc2_]);
      }
      
      override public function getRectangles() : Vector.<Rectangle>
      {
         if(this._isTabMode || !visible)
         {
            return null;
         }
         return new <Rectangle>[this.mapHit.getBounds(App.stage)];
      }
      
      override public function setAllowedSizeIndex(param1:Number) : void
      {
         if((this._currentSizeIndex != param1 || this._updateSizeIndexForce) && initialized)
         {
            this._currentSizeIndex = param1;
            dispatchEvent(new MinimapEvent(MinimapEvent.SIZE_CHANGED));
            this.updateContainersSize(this._currentSizeIndex);
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
            applyNewSizeS(this._currentSizeIndex);
            this._updateSizeIndexForce = false;
         }
      }
      
      override public function updateSizeIndex(param1:Boolean) : void
      {
         this._updateSizeIndexForce = param1 || this._updateSizeIndexForce;
         this.checkNewSize(this._currentSizeIndex);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateSizeIndex(true);
         this._clickAreaSpr.addEventListener(MouseEvent.CLICK,this.onAreaMouseClickHandler);
         this._clickAreaSpr.addEventListener(MouseEvent.MOUSE_WHEEL,this.onAreaMouseWheelHandler);
         this.mapShortcutLabel.mapBtnTF.text = READABLE_KEY_NAMES.KEY_M;
         this._sectors = new <MovieClip>[this.mapShortcutLabel.sectorOverview.sector1,this.mapShortcutLabel.sectorOverview.sector2,this.mapShortcutLabel.sectorOverview.sector3,this.mapShortcutLabel.sectorOverview.sector4,this.mapShortcutLabel.sectorOverview.sector5,this.mapShortcutLabel.sectorOverview.sector6,this.mapShortcutLabel.sectorOverview.sectorHQ];
         this.updateSectorOverview();
      }
      
      override protected function onDispose() : void
      {
         this._clickAreaSpr.removeEventListener(MouseEvent.CLICK,this.onAreaMouseClickHandler);
         this._clickAreaSpr.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onAreaMouseWheelHandler);
         this._clickAreaSpr = null;
         this.mapHit = null;
         this.mapShortcutLabel = null;
         this.mapZoomMode.stop();
         this.mapZoomMode = null;
         this.entriesContainer.dispose();
         this.entriesContainer = null;
         this.bgFrame = null;
         this.fgFrame = null;
         this.background.dispose();
         this.background = null;
         this._sectors.splice(0,this._sectors.length);
         this._sectors = null;
         this._sectorState.splice(0,this._sectorState.length);
         this._sectorState = null;
         super.onDispose();
      }
      
      public function as_setMapDimensions(param1:int, param2:int) : void
      {
         this._mapWidth = param1;
         this._mapHeight = param2;
      }
      
      public function as_setZoomMode(param1:Number, param2:String) : void
      {
         if(!this._isTabMode)
         {
            this._zoomMode = param1;
            this.mapZoomMode.mapZoomModeContainer.zoomLevelTF.text = param2;
            this.mapZoomMode.gotoAndPlay(2);
         }
      }
      
      public function as_updateSectorStateStats(param1:Object) : void
      {
         var _loc2_:int = this._sectorState.length;
         var _loc3_:MovieClip = this.mapShortcutLabel.sectorOverview.changeOwnerAnim;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(this._sectorState[_loc4_] != param1[SECTORS_FIELD][_loc4_])
            {
               if(this._sectorState[_loc4_] != 0)
               {
                  _loc3_.x = this._sectors[_loc4_].x;
                  _loc3_.y = this._sectors[_loc4_].y;
                  _loc3_.gotoAndPlay(2);
               }
               this._sectorState[_loc4_] = param1[SECTORS_FIELD][_loc4_];
            }
            _loc4_++;
         }
         this.updateSectorOverview();
      }
      
      public function restoreZoomMode() : void
      {
         onZoomModeChangedS((this._zoomMode - MAX_ZOOM_MODE) / ZOOM_MODE_STEP);
      }
      
      public function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
      }
      
      public function setTabZoomMode() : void
      {
         var _loc1_:int = (MAX_ZOOM_MODE - this._zoomMode) / ZOOM_MODE_STEP;
         if(_loc1_ > 0)
         {
            onZoomModeChangedS(_loc1_);
         }
      }
      
      public function toggleTabMode(param1:Boolean) : void
      {
         if(param1 == this._isTabMode)
         {
            return;
         }
         if(param1)
         {
            this._savedSizeIndex = this._currentSizeIndex;
            this._clickAreaSpr.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onAreaMouseWheelHandler);
         }
         else
         {
            this._currentSizeIndex = this._savedSizeIndex;
            this._clickAreaSpr.addEventListener(MouseEvent.MOUSE_WHEEL,this.onAreaMouseWheelHandler);
         }
         this._isTabMode = param1;
         this.fgFrame.visible = this.bgFrame.visible = !this._isTabMode;
         this.updateSizeIndex(true);
         this.updateAlpha();
      }
      
      public function updateEpicPlayerStats(param1:EpicPlayerStatsVO) : void
      {
         if(this._isAttacker != param1.isAttacker)
         {
            this.updateSectorOverview();
            this._isAttacker = param1.isAttacker;
         }
      }
      
      public function updateEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
      }
      
      private function updateAlpha() : void
      {
         alpha = this._isTabMode && this._isTabModeCustomAlpha ? Number(this._tabModeCustomAlpha) : Number(this._settingsAlpha);
      }
      
      private function updateSectorOverview() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._sectors)
         {
            _loc1_ = this._sectors.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(this._isAttacker)
               {
                  this._sectors[_loc2_].gotoAndStop(this._sectorState[_loc2_] >= 2 ? 1 : 2);
               }
               else
               {
                  this._sectors[_loc2_].gotoAndStop(this._sectorState[_loc2_] < 2 ? 1 : 2);
               }
               _loc2_++;
            }
         }
      }
      
      private function updateContainersSize(param1:int) : void
      {
         this.entriesContainer.scaleX = this.entriesContainer.scaleY = MINIMAP_SCALE[param1];
         var _loc2_:Number = MINIMAP_SCALE[param1];
         var _loc3_:Number = _loc2_ * MMAP_BASE_SIZE;
         this._mapScaleIndex = param1;
         var _loc4_:Number = _loc3_ + FRAME_WIDTH_MULTIPLIER * FRAME_BORDER_WIDTH;
         var _loc5_:Number = _loc2_ * FRAME_WIDTH_MULTIPLIER;
         this.fgFrame.width = this.fgFrame.height = _loc4_;
         this.bgFrame.width = this.bgFrame.height = _loc4_ + _loc5_ * FRAME_WIDTH_MULTIPLIER;
         this.fgFrame.x = this.fgFrame.y = -FRAME_BORDER_WIDTH;
         this.bgFrame.x = this.bgFrame.y = this.fgFrame.x - _loc5_;
         this.mapHit.scaleX = this.mapHit.scaleY = _loc2_;
         this.mapShortcutLabel.x = BORDER_OFFSET - _loc5_;
         this.mapZoomMode.y = -FRAME_BORDER_WIDTH - _loc5_;
      }
      
      private function checkNewSize(param1:int) : void
      {
         dispatchEvent(new MinimapEvent(MinimapEvent.TRY_SIZE_CHANGED,false,false,param1));
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
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
      
      override public function get currentWidth() : int
      {
         return MINIMAP_SIZE[this._currentSizeIndex];
      }
      
      override public function get currentHeight() : int
      {
         return MINIMAP_SIZE[this._currentSizeIndex];
      }
      
      override public function get currentTopLeftPoint() : Point
      {
         return TOPLEFT_OFFSET;
      }
      
      override public function get currentSizeIndex() : Number
      {
         return this._currentSizeIndex;
      }
      
      public function set isTabModeCustomAlpha(param1:Boolean) : void
      {
         if(param1 != this._isTabModeCustomAlpha)
         {
            this._isTabModeCustomAlpha = param1;
            if(this._isTabMode)
            {
               this.updateAlpha();
            }
         }
      }
      
      public function set tabModeCustomAlpha(param1:Number) : void
      {
         if(param1 != this._tabModeCustomAlpha)
         {
            this._tabModeCustomAlpha = param1;
            if(this._isTabMode)
            {
               this.updateAlpha();
            }
         }
      }
      
      public function get isTabMode() : Boolean
      {
         return this._isTabMode;
      }
      
      private function onAreaMouseClickHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx && param1.target == this._clickAreaSpr)
         {
            if(this.mapHit.mouseX < 0 || this.mapHit.mouseY < 0 || this.mapHit.mouseX > this.background.width || this.mapHit.mouseY > this.background.height)
            {
               return;
            }
            onMinimapClickedS(this.mapHit.mouseX,this.mapHit.mouseY,MouseEventEx(param1).buttonIdx,this._mapScaleIndex);
         }
      }
      
      private function onAreaMouseWheelHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx && param1.target == this._clickAreaSpr)
         {
            onZoomModeChangedS(param1.delta > 0 ? int(-1) : int(1));
         }
      }
   }
}
