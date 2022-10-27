package net.wg.gui.battle.random.views.fragCorrelationBar.components
{
   import flash.display.MovieClip;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.FragCorrelationBarStatus;
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IClassFactory;
   
   public class VehicleMarkersList implements IVehicleMarkerAnimFinishedHandler, IDisposable
   {
      
      private static const TIER_GROUPING_Y_OFFSET:int = 23;
      
      private static const MARKERS_TOP_OFFSET:int = 17;
      
      private static const TIER_GROUPING_Y_OFFSET_NO_BAR:int = 13;
      
      private static const MARKERS_TOP_OFFSET_NO_BAR:int = 7;
      
      private static const ALLY_MARKERS_START_POSITION:int = -88;
      
      private static const ENEMY_MARKERS_START_POSITION:int = 58;
      
      private static const ALLY_TIER_GROUPING_START_POSITION:int = -71;
      
      private static const ENEMY_TIER_GROUPING_START_POSITION:int = 42;
      
      private static const MARKER_SHIFT:int = 16;
      
      private static const ALLY_TIER_GROUPING_SHIFT:int = 30;
      
      private static const ENEMY_TIER_GROUPING_SHIFT:int = 0;
      
      private static const TIER_7_GROUPING_OFFSET:int = 2;
      
      private static const TIER_8_GROUPING_OFFSET:int = 4;
      
      private static const TIER_9_GROUPING_OFFSET:int = 1;
      
      private static const TIER_7_GROUPING_START_OFFSET:int = 4;
      
      private static const TIER_8_GROUPING_START_OFFSET:int = 8;
      
      private static const TIER_GROUP_VEH_ICON_OFFSET:int = 29;
       
      
      private var _vehicleMarkers:Vector.<FCVehicleMarker>;
      
      private var _vehicleIDs:Vector.<Number>;
      
      private var _container:MovieClip = null;
      
      private var _color:String = "";
      
      private var _markerStartPosition:int = -1;
      
      private var _markerShift:int = -1;
      
      private var _classFactory:IClassFactory;
      
      private var _observerIDs:Vector.<Number>;
      
      private var _isVehicleCounterShown:Boolean = true;
      
      private var _isTierGroupingEnabled:Boolean = true;
      
      private var _isHPBarEnabled:Boolean = true;
      
      private var _isForceTierGrouping:Boolean = false;
      
      private var _activeTierGroupings:Vector.<TierGroupingElement>;
      
      private var _activeTierLevels:Vector.<int>;
      
      private var _disposed:Boolean = false;
      
      private var _markerOffset:int = 0;
      
      public function VehicleMarkersList(param1:MovieClip, param2:Boolean, param3:String)
      {
         this._vehicleMarkers = new Vector.<FCVehicleMarker>(0);
         this._vehicleIDs = new Vector.<Number>();
         this._classFactory = App.utils.classFactory;
         this._observerIDs = new Vector.<Number>();
         this._activeTierGroupings = new Vector.<TierGroupingElement>();
         this._activeTierLevels = new Vector.<int>();
         super();
         this._container = param1;
         this._markerStartPosition = !!param2 ? int(ENEMY_MARKERS_START_POSITION) : int(ALLY_MARKERS_START_POSITION);
         this._markerShift = !!param2 ? int(MARKER_SHIFT) : int(-MARKER_SHIFT);
         this._color = param3;
      }
      
      public function addVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>) : void
      {
         var _loc3_:DAAPIVehicleInfoVO = null;
         for each(_loc3_ in param1)
         {
            if(!this.removeObserverFromVehicleInfo(_loc3_))
            {
               this.addVehicle(_loc3_);
            }
         }
         if(param2)
         {
            this._vehicleIDs = this.getCorrectVehicleIds(param2);
            this.createTierGroupingElements();
            this.sort();
         }
      }
      
      public final function dispose() : void
      {
         var _loc1_:FCVehicleMarker = null;
         var _loc2_:TierGroupingElement = null;
         this._disposed = true;
         for each(_loc1_ in this._vehicleMarkers)
         {
            _loc1_.dispose();
            this._container.removeChild(_loc1_);
         }
         for each(_loc2_ in this._activeTierGroupings)
         {
            _loc2_.dispose();
            this._container.removeChild(_loc2_);
         }
         this._container = null;
         this._vehicleMarkers.fixed = false;
         this.cleanVehicleMarker();
         this._vehicleMarkers = null;
         this._activeTierGroupings.fixed = false;
         this._activeTierGroupings.splice(0,this._activeTierGroupings.length);
         this._activeTierGroupings = null;
         this._vehicleIDs.fixed = false;
         this._vehicleIDs.splice(0,this._vehicleIDs.length);
         this._vehicleIDs = null;
         this._observerIDs.splice(0,this._observerIDs.length);
         this._observerIDs = null;
         this._classFactory = null;
         this._activeTierLevels.fixed = false;
         this._activeTierLevels.splice(0,this._activeTierLevels.length);
         this._activeTierLevels = null;
      }
      
      public function hasMultipleTierLevel() : Boolean
      {
         return this._activeTierLevels.length > 1;
      }
      
      public function setMarkerOffset(param1:int) : void
      {
         if(this._markerOffset != param1)
         {
            this._markerOffset = param1;
            this.sort();
         }
      }
      
      public function hideVehicleMarkers() : void
      {
         var _loc1_:FCVehicleMarker = null;
         this._isVehicleCounterShown = false;
         for each(_loc1_ in this._vehicleMarkers)
         {
            _loc1_.visible = false;
         }
         this.updateTierGroupingVisibility(this._isVehicleCounterShown);
      }
      
      public function setIsForcedTierGrouping(param1:Boolean) : void
      {
         if(param1 == this._isForceTierGrouping)
         {
            return;
         }
         this._isForceTierGrouping = param1;
         this.sort();
      }
      
      public function setViewSetting(param1:int) : void
      {
         var _loc2_:Boolean = FragCorrelationBarStatus.isShowTierGrouping(param1);
         var _loc3_:Boolean = FragCorrelationBarStatus.isShowTeamHPBar(param1);
         if(_loc2_ == this._isTierGroupingEnabled && _loc3_ == this._isHPBarEnabled)
         {
            return;
         }
         this._isTierGroupingEnabled = _loc2_;
         this._isHPBarEnabled = _loc3_;
         this.sort();
         this.updateTierGroupingVisibility(this._isTierGroupingEnabled);
      }
      
      public function showVehicleMarkers() : void
      {
         var _loc1_:FCVehicleMarker = null;
         this._isVehicleCounterShown = true;
         this.sort();
         for each(_loc1_ in this._vehicleMarkers)
         {
            _loc1_.visible = true;
         }
         this.updateTierGroupingVisibility(this._isVehicleCounterShown && this._isTierGroupingEnabled);
      }
      
      public function sort() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:FCVehicleMarker = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this._vehicleIDs != null)
         {
            if(this._isTierGroupingEnabled)
            {
               this._vehicleMarkers.sort(this.compareWithTierGroup);
            }
            else
            {
               this._vehicleMarkers.sort(this.compare);
            }
            _loc1_ = this._markerStartPosition + this._markerOffset;
            _loc2_ = 0;
            _loc3_ = this._activeTierLevels.length > 1 && this._isTierGroupingEnabled || this._isForceTierGrouping && this._isTierGroupingEnabled;
            if(_loc3_)
            {
               _loc1_ = (this._markerStartPosition > 0 ? ENEMY_TIER_GROUPING_START_POSITION : ALLY_TIER_GROUPING_START_POSITION) + this._markerOffset;
               _loc2_ = this._markerStartPosition > 0 ? int(TIER_GROUP_VEH_ICON_OFFSET) : int(-TIER_GROUP_VEH_ICON_OFFSET);
               this.updateTierGroupingVisibility(_loc3_);
            }
            _loc5_ = 0;
            _loc6_ = 0;
            for each(_loc4_ in this._vehicleMarkers)
            {
               if(_loc3_)
               {
                  if(_loc5_ == 0 || _loc5_ != _loc4_.vehicleLevel)
                  {
                     if(_loc5_ == 0)
                     {
                        _loc7_ = 0;
                        if(_loc4_.vehicleLevel == 9)
                        {
                           _loc7_ += this._markerShift > 0 ? TIER_9_GROUPING_OFFSET : -TIER_9_GROUPING_OFFSET;
                        }
                        else if(_loc4_.vehicleLevel == 8)
                        {
                           _loc7_ += this._markerShift > 0 ? TIER_8_GROUPING_START_OFFSET : -TIER_8_GROUPING_START_OFFSET;
                        }
                        else if(_loc4_.vehicleLevel == 7)
                        {
                           _loc7_ += this._markerShift > 0 ? TIER_7_GROUPING_START_OFFSET : -TIER_7_GROUPING_START_OFFSET;
                        }
                        _loc1_ += _loc7_;
                     }
                     _loc1_ += _loc2_;
                     this.positionTierInfo(_loc6_,_loc4_.vehicleLevel,_loc1_);
                     _loc6_ += 1;
                     _loc5_ = _loc4_.vehicleLevel;
                  }
               }
               if(_loc4_.x != _loc1_)
               {
                  _loc4_.x = _loc1_;
               }
               _loc1_ += this._markerShift;
               if(this._isHPBarEnabled)
               {
                  _loc4_.y = MARKERS_TOP_OFFSET;
               }
               else
               {
                  _loc4_.y = MARKERS_TOP_OFFSET_NO_BAR;
               }
            }
         }
      }
      
      public function updateMarkers(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>) : void
      {
         var _loc4_:FCVehicleMarker = null;
         var _loc5_:DAAPIVehicleInfoVO = null;
         var _loc3_:Vector.<DAAPIVehicleInfoVO> = this.removeObserversFromVehicleInfos(param1);
         for each(_loc4_ in this._vehicleMarkers)
         {
            this._container.removeChild(_loc4_);
            _loc4_.dispose();
         }
         this.cleanVehicleMarker();
         for each(_loc5_ in _loc3_)
         {
            this.addVehicle(_loc5_);
         }
         if(param2)
         {
            this._vehicleIDs = this.getCorrectVehicleIds(param2);
            this.createTierGroupingElements();
            this.sort();
         }
      }
      
      public function updateVehicleStatus(param1:Number, param2:uint, param3:Vector.<Number>) : void
      {
         var _loc4_:FCVehicleMarker = null;
         if(this._observerIDs.indexOf(param1) == -1)
         {
            _loc4_ = this.getVehicleMarkerByID(param1);
            if(_loc4_ && param3)
            {
               this._vehicleIDs = this.getCorrectVehicleIds(param3);
               _loc4_.updateVehicleStatus(param2);
            }
         }
      }
      
      public function updateVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>) : void
      {
         var _loc3_:DAAPIVehicleInfoVO = null;
         var _loc4_:FCVehicleMarker = null;
         for each(_loc3_ in param1)
         {
            _loc4_ = this.getVehicleMarkerByID(_loc3_.vehicleID);
            if(_loc4_)
            {
               if(!this.removeObserverFromVehicleInfo(_loc3_))
               {
                  _loc4_.update(_loc3_.vehicleType,_loc3_.vehicleStatus,_loc3_.vehicleLevel,this._color);
                  this.addActiveTierLevels(_loc3_.vehicleLevel);
               }
               else
               {
                  this._container.removeChild(_loc4_);
                  _loc4_.dispose();
                  _loc4_ = null;
               }
            }
         }
         if(param2)
         {
            this._vehicleIDs = this.getCorrectVehicleIds(param2);
            this.createTierGroupingElements();
            this.sort();
         }
      }
      
      protected function getMarkerLinkage() : String
      {
         return Linkages.FC_MARKER_ITEM;
      }
      
      private function cleanVehicleMarker() : void
      {
         this._vehicleMarkers.splice(0,this._vehicleMarkers.length);
      }
      
      private function createTierGroupingElements() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TierGroupingElement = null;
         if(this._activeTierLevels.length != this._activeTierGroupings.length)
         {
            _loc1_ = this._activeTierLevels.length - this._activeTierGroupings.length;
            if(_loc1_ > 0)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  _loc3_ = App.utils.classFactory.getComponent(Linkages.TIER_GROUPING_UI,TierGroupingElement);
                  if(_loc3_)
                  {
                     this._activeTierGroupings.push(_loc3_);
                     if(this._isHPBarEnabled)
                     {
                        _loc3_.y = TIER_GROUPING_Y_OFFSET;
                     }
                     else
                     {
                        _loc3_.y = TIER_GROUPING_Y_OFFSET_NO_BAR;
                     }
                     this._container.addChild(_loc3_);
                  }
                  _loc2_++;
               }
            }
         }
      }
      
      private function addVehicle(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc2_:FCVehicleMarker = FCVehicleMarker(this._classFactory.getObject(this.getMarkerLinkage()));
         _loc2_.init(param1.vehicleID,param1.vehicleType,param1.vehicleStatus,this._color,param1.vehicleLevel,this);
         this._vehicleMarkers.push(_loc2_);
         if(!this._isVehicleCounterShown)
         {
            _loc2_.visible = false;
         }
         this.addActiveTierLevels(param1.vehicleLevel);
         this._container.addChild(_loc2_);
      }
      
      private function addActiveTierLevels(param1:int) : void
      {
         if(this._activeTierLevels.indexOf(param1) == -1)
         {
            this._activeTierLevels.push(param1);
         }
      }
      
      private function updateTierGroupingVisibility(param1:Boolean) : void
      {
         var _loc2_:TierGroupingElement = null;
         for each(_loc2_ in this._activeTierGroupings)
         {
            _loc2_.visible = param1;
            if(this._isHPBarEnabled)
            {
               _loc2_.y = TIER_GROUPING_Y_OFFSET;
            }
            else
            {
               _loc2_.y = TIER_GROUPING_Y_OFFSET_NO_BAR;
            }
         }
      }
      
      private function getVehicleMarkerByID(param1:Number) : FCVehicleMarker
      {
         var _loc2_:FCVehicleMarker = null;
         for each(_loc2_ in this._vehicleMarkers)
         {
            if(_loc2_.vehicleID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function positionTierInfo(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         if(param1 < this._activeTierGroupings.length)
         {
            _loc4_ = this._markerShift > 0 ? int(ENEMY_TIER_GROUPING_SHIFT) : int(ALLY_TIER_GROUPING_SHIFT);
            if(param2 == 9)
            {
               _loc4_ += this._markerShift > 0 ? -TIER_9_GROUPING_OFFSET : TIER_9_GROUPING_OFFSET;
            }
            else if(param2 == 8)
            {
               _loc4_ += this._markerShift > 0 ? -TIER_8_GROUPING_OFFSET : TIER_8_GROUPING_OFFSET;
            }
            else if(param2 == 7)
            {
               _loc4_ += this._markerShift > 0 ? -TIER_7_GROUPING_OFFSET : TIER_7_GROUPING_OFFSET;
            }
            this._activeTierGroupings[param1].x = param3 + _loc4_;
            this._activeTierGroupings[param1].setTierLevel(param2);
         }
      }
      
      private function compareWithTierGroup(param1:FCVehicleMarker, param2:FCVehicleMarker) : Number
      {
         var _loc3_:int = param1.vehicleLevel;
         var _loc4_:int = param2.vehicleLevel;
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         return this.compare(param1,param2);
      }
      
      private function compare(param1:FCVehicleMarker, param2:FCVehicleMarker) : Number
      {
         var _loc3_:int = this._vehicleIDs.indexOf(param1.vehicleID);
         var _loc4_:int = this._vehicleIDs.indexOf(param2.vehicleID);
         if(_loc3_ == _loc4_)
         {
            return 0;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return -1;
      }
      
      private function removeObserversFromVehicleInfos(param1:Vector.<DAAPIVehicleInfoVO>) : Vector.<DAAPIVehicleInfoVO>
      {
         var _loc4_:DAAPIVehicleInfoVO = null;
         var _loc2_:int = -1;
         var _loc3_:Vector.<DAAPIVehicleInfoVO> = new Vector.<DAAPIVehicleInfoVO>(0);
         for each(_loc4_ in param1)
         {
            if(_loc4_.isObserver)
            {
               _loc2_ = this._observerIDs.indexOf(_loc4_.vehicleID);
               if(_loc2_ == -1)
               {
                  this._observerIDs.push(_loc4_.vehicleID);
               }
            }
            else
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      private function removeObserverFromVehicleInfo(param1:DAAPIVehicleInfoVO) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(param1.isObserver)
         {
            _loc2_ = true;
            _loc3_ = this._observerIDs.indexOf(param1.vehicleID);
            if(_loc3_ == -1)
            {
               this._observerIDs.push(param1.vehicleID);
            }
         }
         return _loc2_;
      }
      
      private function getCorrectVehicleIds(param1:Vector.<Number>) : Vector.<Number>
      {
         var _loc2_:Vector.<Number> = null;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         if(param1)
         {
            _loc2_ = param1.concat();
            _loc2_.fixed = false;
            for each(_loc4_ in this._observerIDs)
            {
               _loc3_ = _loc2_.indexOf(_loc4_);
               if(_loc3_ != -1)
               {
                  _loc2_.splice(_loc3_,1);
               }
            }
         }
         return _loc2_;
      }
      
      public function set color(param1:String) : void
      {
         var _loc2_:FCVehicleMarker = null;
         if(this._color != param1)
         {
            this._color = param1;
            for each(_loc2_ in this._vehicleMarkers)
            {
               _loc2_.color = this._color;
            }
         }
      }
      
      protected function get vehicleMarkers() : Vector.<FCVehicleMarker>
      {
         return this._vehicleMarkers;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
