package net.wg.gui.battle.commander.views.spawnMenu.containers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RTS_SPAWN_MENU_ENTRY_TYPES;
   import net.wg.gui.battle.commander.views.spawnMenu.SizeSettings;
   import net.wg.gui.battle.commander.views.spawnMenu.events.EntryEvent;
   import net.wg.gui.battle.commander.views.spawnMenu.items.StagedItem;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.BaseEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.BasePointEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.ControlPointEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.MapVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.PlacePointEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.VehicleEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.BaseEntry;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.BasePointEntry;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.ControlPointEntry;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.PlacePointEntry;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.SpawnBasePointEntry;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.SupplyEntry;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.VehicleEntry;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.utils.IClassFactory;
   
   public class Map extends StagedItem
   {
      
      private static const _INVALID_MAP_DATA:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const _INVALID_HINT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const _HIDDEN_ENTRY_ALPHA:Number = 0.6;
      
      private static const _NORMAL_ENTRY_ALPHA:Number = 1;
      
      private static const _HINT_ALERT_STATE:uint = 0;
      
      private static const _HINT_GREEN_STATE:uint = 1;
       
      
      public var mapBg:UILoaderAlt = null;
      
      public var mapMask:Sprite = null;
      
      public var placePointsMC:MovieClip = null;
      
      public var vehiclesMC:MovieClip = null;
      
      public var pointsMC:MovieClip = null;
      
      public var checkmark:MovieClip = null;
      
      public var hintBg:MovieClip = null;
      
      public var hintTF:TextField = null;
      
      public var hintGreenBg:MovieClip = null;
      
      public var hintGreenTF:TextField = null;
      
      private var _mapData:MapVO = null;
      
      private var _isMapHintActive:Boolean = true;
      
      private var _selectedItemID:String = "";
      
      private var _radiusScaleFactor:Number = 1.0;
      
      private var _placePointsData:Vector.<PlacePointEntryVO> = null;
      
      private var _suppliesData:Vector.<VehicleEntryVO> = null;
      
      private var _vehiclesData:Vector.<VehicleEntryVO> = null;
      
      private var _entries:Object;
      
      private var _baseEntries:Vector.<BaseEntry>;
      
      private var _classFactory:IClassFactory;
      
      private var _hintState:uint = 1.0;
      
      private var _hintText:String = "";
      
      public function Map()
      {
         this._entries = {};
         this._baseEntries = new Vector.<BaseEntry>();
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      private static function isPlacePointEntry(param1:BaseEntry) : Boolean
      {
         return param1.entryType == RTS_SPAWN_MENU_ENTRY_TYPES.PLACE_POINT;
      }
      
      private static function isEntryHighlighted(param1:BaseEntry, param2:EntryEvent) : Boolean
      {
         if(param2)
         {
            if(param2.entryID)
            {
               return param2.value && param2.entryID == param1.entryID;
            }
            if(param2.vehicleID)
            {
               return param2.value && param2.vehicleID == param1.vehicleID;
            }
         }
         return false;
      }
      
      override protected function onDispose() : void
      {
         this.mapBg.dispose();
         this.mapBg = null;
         this.mapMask = null;
         this.hintBg = null;
         this.hintTF = null;
         this.checkmark = null;
         this.hintGreenBg = null;
         this.hintGreenTF = null;
         this._classFactory = null;
         this.clearEntries();
         this._entries = null;
         this._baseEntries = null;
         this._mapData = null;
         this.placePointsMC = null;
         this.vehiclesMC = null;
         this.pointsMC = null;
         this._placePointsData = null;
         this._suppliesData = null;
         this._vehiclesData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:BasePointEntryVO = null;
         var _loc5_:ControlPointEntryVO = null;
         var _loc6_:BasePointEntryVO = null;
         var _loc7_:MovieClip = null;
         var _loc8_:BaseEntry = null;
         var _loc9_:String = null;
         var _loc10_:Object = null;
         var _loc11_:BaseEntryVO = null;
         var _loc12_:VehicleEntryVO = null;
         var _loc13_:VehicleEntryVO = null;
         var _loc14_:BaseEntryVO = null;
         var _loc15_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            mask = this.mapMask;
         }
         if(this._mapData && isInvalid(InvalidationType.SIZE | _INVALID_MAP_DATA))
         {
            this.clearEntries();
            _loc1_ = SizeSettings.getStageSizeSettings(_currentStage).map;
            _loc2_ = _loc1_.width;
            _loc3_ = _loc1_.height;
            this._radiusScaleFactor = _loc2_ / this._mapData.size;
            this.mapBg.source = this._mapData.mapPath;
            this.mapBg.x = -(_loc2_ >> 1);
            this.mapBg.y = -(_loc3_ >> 1);
            this.mapBg.width = this.mapMask.width = _loc2_;
            this.mapBg.height = this.mapMask.height = _loc3_;
            for each(_loc4_ in this._mapData.basePointsData)
            {
               this._baseEntries.push(this.addEntry(_loc4_));
            }
            for each(_loc5_ in this._mapData.controlPointsData)
            {
               this._baseEntries.push(this.addEntry(_loc5_));
            }
            for each(_loc6_ in this._mapData.spawnBasePointsData)
            {
               this._baseEntries.push(this.addEntry(_loc6_));
            }
         }
         if(isInvalid(InvalidationType.SIZE | InvalidationType.DATA))
         {
            _loc10_ = {};
            for each(_loc11_ in this._placePointsData)
            {
               _loc10_[_loc11_.entryID] = _loc11_;
            }
            for each(_loc12_ in this._suppliesData)
            {
               _loc10_[_loc12_.entryID] = _loc12_;
            }
            for each(_loc13_ in this._vehiclesData)
            {
               _loc10_[_loc13_.entryID] = _loc13_;
            }
            for each(_loc8_ in this._entries)
            {
               _loc9_ = _loc8_.data.entryID;
               if(!(_loc9_ in _loc10_))
               {
                  _loc8_ = this._entries[_loc9_];
                  _loc8_.visible = false;
               }
            }
            for each(_loc14_ in _loc10_)
            {
               _loc9_ = _loc14_.entryID;
               if(_loc9_ in this._entries)
               {
                  _loc8_ = this._entries[_loc9_];
                  _loc15_ = _loc8_.data.entryType;
                  if(_loc15_ != _loc14_.entryType)
                  {
                     _loc7_ = this.getContainer(_loc14_);
                     if(_loc7_)
                     {
                        _loc7_.removeChild(_loc8_);
                     }
                     _loc8_.dispose();
                     delete this._entries[_loc9_];
                  }
                  else
                  {
                     _loc8_.setData(_loc14_);
                     _loc8_.visible = true;
                  }
               }
               if(!(_loc9_ in this._entries))
               {
                  this._entries[_loc9_] = this.addEntry(_loc14_);
               }
            }
         }
         if(isInvalid(InvalidationType.SIZE | _INVALID_MAP_DATA | InvalidationType.DATA))
         {
            this.updateEntriesState();
         }
         if(isInvalid(InvalidationType.SIZE | _INVALID_HINT))
         {
            this.hintTF.text = this.hintGreenTF.text = this._hintText;
            this.hintBg.visible = this.hintTF.visible = this._isMapHintActive && this._hintState == _HINT_ALERT_STATE;
            this.hintGreenBg.visible = this.checkmark.visible = this.hintGreenTF.visible = this._isMapHintActive && this._hintState == _HINT_GREEN_STATE;
         }
      }
      
      public function setData(param1:MapVO) : void
      {
         this._mapData = param1;
         invalidate(_INVALID_MAP_DATA);
      }
      
      public function updateEntriesData(param1:Vector.<PlacePointEntryVO>, param2:Vector.<VehicleEntryVO>, param3:Vector.<VehicleEntryVO>) : void
      {
         this._placePointsData = param1;
         this._suppliesData = param2;
         this._vehiclesData = param3;
         invalidateData();
      }
      
      private function getContainer(param1:BaseEntryVO) : MovieClip
      {
         switch(param1.entryType)
         {
            case RTS_SPAWN_MENU_ENTRY_TYPES.PLACE_POINT:
               return this.placePointsMC;
            case RTS_SPAWN_MENU_ENTRY_TYPES.ALLY_VEHICLE:
            case RTS_SPAWN_MENU_ENTRY_TYPES.SUPPLY:
               return this.vehiclesMC;
            case RTS_SPAWN_MENU_ENTRY_TYPES.BASE_POINT:
            case RTS_SPAWN_MENU_ENTRY_TYPES.CONTROL_POINT:
            case RTS_SPAWN_MENU_ENTRY_TYPES.SPAWN_BASE_POINT:
               return this.pointsMC;
            default:
               return null;
         }
      }
      
      private function addEntry(param1:BaseEntryVO) : BaseEntry
      {
         var _loc2_:BaseEntry = null;
         switch(param1.entryType)
         {
            case RTS_SPAWN_MENU_ENTRY_TYPES.PLACE_POINT:
               _loc2_ = this._classFactory.getComponent(Linkages.SPAWN_MENU_MAP_PLACE_POINT_ENTRY,PlacePointEntry);
               break;
            case RTS_SPAWN_MENU_ENTRY_TYPES.ALLY_VEHICLE:
               _loc2_ = this._classFactory.getComponent(Linkages.SPAWN_MENU_MAP_VEHICLE_ENTRY,VehicleEntry);
               break;
            case RTS_SPAWN_MENU_ENTRY_TYPES.SUPPLY:
               _loc2_ = this._classFactory.getComponent(Linkages.SPAWN_MENU_MAP_SUPPLY_ENTRY,SupplyEntry);
               break;
            case RTS_SPAWN_MENU_ENTRY_TYPES.BASE_POINT:
               _loc2_ = this._classFactory.getComponent(Linkages.SPAWN_MENU_MAP_BASE_POINT_ENTRY,BasePointEntry);
               break;
            case RTS_SPAWN_MENU_ENTRY_TYPES.CONTROL_POINT:
               _loc2_ = this._classFactory.getComponent(Linkages.SPAWN_MENU_MAP_CONTROL_POINT_ENTRY,ControlPointEntry);
               break;
            case RTS_SPAWN_MENU_ENTRY_TYPES.SPAWN_BASE_POINT:
               _loc2_ = this._classFactory.getComponent(Linkages.SPAWN_MENU_MAP_SPAWN_BASE_POINT_ENTRY,SpawnBasePointEntry);
               break;
            default:
               DebugUtils.LOG_ERROR("Unsupported entry type");
               return null;
         }
         _loc2_.setData(param1);
         _loc2_.updateStage(_currentStage);
         _loc2_.setRadiusScaleFactor(this._radiusScaleFactor);
         this.updateEntryPosition(_loc2_);
         var _loc3_:MovieClip = this.getContainer(param1);
         if(_loc3_)
         {
            _loc3_.addChild(_loc2_);
         }
         return _loc2_;
      }
      
      private function updateEntryPosition(param1:BaseEntry) : void
      {
         var _loc2_:BaseEntryVO = param1.data;
         var _loc3_:uint = this._mapData.size;
         var _loc4_:Rectangle = SizeSettings.getStageSizeSettings(_currentStage).map;
         param1.x = _loc2_.x / _loc3_ * _loc4_.width;
         param1.y = -(_loc2_.y / _loc3_) * _loc4_.height;
      }
      
      private function clearEntries() : void
      {
         var _loc1_:BaseEntry = null;
         var _loc2_:MovieClip = null;
         for each(_loc1_ in this._entries)
         {
            _loc2_ = this.getContainer(_loc1_.data);
            if(_loc2_)
            {
               _loc2_.removeChild(_loc1_);
            }
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._entries);
         for each(_loc1_ in this._baseEntries)
         {
            _loc2_ = this.getContainer(_loc1_.data);
            if(_loc2_)
            {
               _loc2_.removeChild(_loc1_);
            }
            _loc1_.dispose();
         }
         this._baseEntries.length = 0;
      }
      
      private function isEntryHighlightedByGroup(param1:BaseEntry, param2:EntryEvent) : Boolean
      {
         var _loc3_:String = param1.itemID;
         if(this._selectedItemID && this._selectedItemID == _loc3_)
         {
            return true;
         }
         if(param2)
         {
            if(param2.itemID)
            {
               return param2.value && param2.itemID == _loc3_;
            }
            return isEntryHighlighted(param1,param2);
         }
         return false;
      }
      
      private function updateEntryState(param1:BaseEntry, param2:EntryEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc7_:MovieClip = null;
         var _loc3_:Boolean = isEntryHighlighted(param1,param2);
         _loc4_ = this.isEntryHighlightedByGroup(param1,param2);
         _loc5_ = !this._selectedItemID || _loc4_;
         var _loc6_:Boolean = isPlacePointEntry(param1) || _loc5_;
         param1.isFocusedVisually = _loc4_;
         param1.mouseEnabled = _loc6_;
         param1.alpha = !!_loc5_ ? Number(_NORMAL_ENTRY_ALPHA) : Number(_HIDDEN_ENTRY_ALPHA);
         if(_loc4_)
         {
            _loc7_ = this.getContainer(param1.data);
            if(_loc7_)
            {
               _loc7_.setChildIndex(param1,_loc7_.numChildren - 1);
            }
         }
         if(param2)
         {
            switch(param2.type)
            {
               case EntryEvent.FOCUS:
                  param1.isFocused = _loc6_ && _loc3_;
                  break;
               case EntryEvent.SELECT:
                  param1.isSelected = _loc6_ && _loc3_;
            }
         }
      }
      
      private function updateEntriesState(param1:EntryEvent = null) : void
      {
         var _loc2_:BaseEntry = null;
         for each(_loc2_ in this._baseEntries)
         {
            this.updateEntryState(_loc2_,param1);
         }
         for each(_loc2_ in this._entries)
         {
            this.updateEntryState(_loc2_,param1);
         }
      }
      
      public function set isMapHintActive(param1:Boolean) : void
      {
         if(this._isMapHintActive != param1)
         {
            this._isMapHintActive = param1;
            invalidate(_INVALID_HINT);
         }
      }
      
      public function set selectedItemID(param1:String) : void
      {
         if(this._selectedItemID != param1)
         {
            this._selectedItemID = param1;
            this.updateEntriesState();
         }
      }
      
      public function onEntryEvent(param1:EntryEvent) : void
      {
         switch(param1.type)
         {
            case EntryEvent.SELECT:
               this._selectedItemID = !!param1.value ? param1.itemID : Values.EMPTY_STR;
         }
         this.updateEntriesState(param1);
      }
      
      public function updateHintValues(param1:uint, param2:String) : void
      {
         this._hintState = param1;
         this._hintText = param2;
         invalidate(_INVALID_HINT);
      }
   }
}
