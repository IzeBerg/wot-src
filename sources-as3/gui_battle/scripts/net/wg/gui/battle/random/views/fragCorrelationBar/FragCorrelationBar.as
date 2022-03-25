package net.wg.gui.battle.random.views.fragCorrelationBar
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
   import net.wg.data.constants.FragCorrelationBarStatus;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.AllyTeamHealthBar;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.BaseTeamHealthBar;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.VehicleMarkersList;
   import net.wg.infrastructure.base.meta.IFragCorrelationBarMeta;
   import net.wg.infrastructure.base.meta.impl.FragCorrelationBarMeta;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import scaleform.gfx.TextFieldEx;
   
   public class FragCorrelationBar extends FragCorrelationBarMeta implements IFragCorrelationBarMeta, IBattleComponentDataController
   {
      
      private static const FRAG_CORRELATION_WIN:String = "FragCorrelationWin";
      
      private static const FRAG_CORRELATION_LOSE:String = "FragCorrelationLoose";
      
      private static const RED:String = "red";
      
      private static const FRAG_EQUAL:int = 0;
      
      private static const FRAG_WIN:int = 1;
      
      private static const FRAG_LOSE:int = 2;
      
      private static const INVALID_FRAGS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALID_COLOR_SCHEME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const VEHICLE_SHOWN_FLAG:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const SEPARATOR_STR:String = ":";
      
      private static const NO_VEHICLE_ICONS_BARS_TOP_OFFSET:int = 10;
      
      private static const VEHICLE_ICONS_BARS_TOP_OFFSET:int = 0;
       
      
      public var allyTeamFragsField:TextField = null;
      
      public var enemyTeamFragsField:TextField = null;
      
      public var greenBackground:Sprite = null;
      
      public var redBackground:Sprite = null;
      
      public var purpleBackground:Sprite = null;
      
      public var teamFragsSeparatorField:TextField = null;
      
      public var allyTeamHealthBar:AllyTeamHealthBar = null;
      
      public var enemyTeamHealthBar:BaseTeamHealthBar = null;
      
      private var _allyTeamFragsStr:String = "0";
      
      private var _enemyTeamFragsStr:String = "0";
      
      private var _lastTeamSeparatorState:int = 0;
      
      private var _currentTeamSeparatorState:int = 0;
      
      private var _winColorScheme:IColorScheme = null;
      
      private var _loseColorScheme:IColorScheme = null;
      
      private var _colorSchemeMgr:IColorSchemeManager;
      
      private var _rightBg:Sprite = null;
      
      private var _isVehicleCounterShown:Boolean = true;
      
      private var _isColorblind:Boolean = false;
      
      private var _allyVehicleMarkersList:VehicleMarkersList;
      
      private var _enemyVehicleMarkersList:VehicleMarkersList;
      
      public function FragCorrelationBar()
      {
         this._colorSchemeMgr = App.colorSchemeMgr;
         super();
         this._rightBg = this.redBackground;
         TextFieldEx.setNoTranslate(this.allyTeamFragsField,true);
         TextFieldEx.setNoTranslate(this.enemyTeamFragsField,true);
         TextFieldEx.setNoTranslate(this.teamFragsSeparatorField,true);
         this._winColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_WIN);
         this._loseColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_LOSE);
         this._allyVehicleMarkersList = this.createVehicleMarkersLists(this,false,this._winColorScheme.aliasColor);
         this._enemyVehicleMarkersList = this.createVehicleMarkersLists(this,true,this._loseColorScheme.aliasColor);
         mouseChildren = mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_COLOR_SCHEME))
         {
            this.greenBackground.filters = [this._winColorScheme.adjustOffset];
            this._isColorblind = this._loseColorScheme.aliasColor != RED;
            this._rightBg.visible = false;
            this._rightBg = !!this._isColorblind ? this.purpleBackground : this.redBackground;
            this._rightBg.filters = [this._loseColorScheme.adjustOffset];
            this._rightBg.visible = this._currentTeamSeparatorState == FRAG_LOSE;
            this.allyTeamHealthBar.init(false,this._isColorblind);
            this.enemyTeamHealthBar.init(true,this._isColorblind);
         }
         if(isInvalid(INVALID_FRAGS))
         {
            this.allyTeamFragsField.text = this._allyTeamFragsStr;
            this.enemyTeamFragsField.text = this._enemyTeamFragsStr;
            if(this._currentTeamSeparatorState != this._lastTeamSeparatorState)
            {
               this._lastTeamSeparatorState = this._currentTeamSeparatorState;
               this.greenBackground.visible = this._currentTeamSeparatorState == FRAG_WIN;
               this._rightBg.visible = this._currentTeamSeparatorState == FRAG_LOSE;
               this.teamFragsSeparatorField.visible = this._currentTeamSeparatorState == FRAG_EQUAL;
            }
         }
         if(isInvalid(VEHICLE_SHOWN_FLAG))
         {
            if(this._isVehicleCounterShown)
            {
               this._allyVehicleMarkersList.showVehicleMarkers();
               this._enemyVehicleMarkersList.showVehicleMarkers();
               this.enemyTeamHealthBar.y = VEHICLE_ICONS_BARS_TOP_OFFSET;
               this.allyTeamHealthBar.y = VEHICLE_ICONS_BARS_TOP_OFFSET;
            }
            else
            {
               this._allyVehicleMarkersList.hideVehicleMarkers();
               this._enemyVehicleMarkersList.hideVehicleMarkers();
               this.enemyTeamHealthBar.y = NO_VEHICLE_ICONS_BARS_TOP_OFFSET;
               this.allyTeamHealthBar.y = NO_VEHICLE_ICONS_BARS_TOP_OFFSET;
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.greenBackground.visible = false;
         this.redBackground.visible = false;
         this.purpleBackground.visible = false;
         this.teamFragsSeparatorField.text = SEPARATOR_STR;
         this.teamFragsSeparatorField.cacheAsBitmap = true;
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.allyTeamHealthBar.init(false,this._isColorblind);
         this.enemyTeamHealthBar.init(true,this._isColorblind);
      }
      
      override protected function onDispose() : void
      {
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this._colorSchemeMgr = null;
         this.allyTeamFragsField = null;
         this.enemyTeamFragsField = null;
         this.greenBackground = null;
         this.redBackground = null;
         this.purpleBackground = null;
         this.teamFragsSeparatorField = null;
         this.allyTeamHealthBar.dispose();
         this.allyTeamHealthBar = null;
         this.enemyTeamHealthBar.dispose();
         this.enemyTeamHealthBar = null;
         this._allyVehicleMarkersList.dispose();
         this._allyVehicleMarkersList = null;
         this._enemyVehicleMarkersList.dispose();
         this._enemyVehicleMarkersList = null;
         this._winColorScheme.dispose();
         this._winColorScheme = null;
         this._loseColorScheme.dispose();
         this._loseColorScheme = null;
         this._rightBg = null;
         super.onDispose();
      }
      
      public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         if(_loc2_.rightVehicleInfos)
         {
            this._enemyVehicleMarkersList.addVehiclesInfo(_loc2_.rightVehicleInfos,_loc2_.rightCorrelationIDs);
         }
         if(_loc2_.leftVehicleInfos)
         {
            this._allyVehicleMarkersList.addVehiclesInfo(_loc2_.leftVehicleInfos,_loc2_.leftCorrelationIDs);
         }
         var _loc3_:Boolean = this._enemyVehicleMarkersList.hasMultipleTierLevel() || this._allyVehicleMarkersList.hasMultipleTierLevel();
         if(_loc3_)
         {
            this._enemyVehicleMarkersList.setIsForcedTierGrouping(true);
            this._allyVehicleMarkersList.setIsForcedTierGrouping(true);
         }
      }
      
      public function as_updateTeamHealthValues(param1:String, param2:String, param3:int, param4:String, param5:int) : void
      {
         this.allyTeamHealthBar.setHealthValue(param1,param3);
         this.enemyTeamHealthBar.setHealthValue(param4,param5);
         this.allyTeamHealthBar.setDiffValues(param2);
      }
      
      public function as_updateViewSetting(param1:int) : void
      {
         this.allyTeamHealthBar.setViewSettings(param1);
         this.enemyTeamHealthBar.setViewSettings(param1);
         this._allyVehicleMarkersList.setViewSetting(param1);
         this._enemyVehicleMarkersList.setViewSetting(param1);
         var _loc2_:Boolean = FragCorrelationBarStatus.isHideVehicleIcons(param1);
         if(_loc2_ != this._isVehicleCounterShown)
         {
            this._isVehicleCounterShown = _loc2_;
            invalidate(VEHICLE_SHOWN_FLAG);
         }
      }
      
      public function resetFrags() : void
      {
      }
      
      public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setFrags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
         if(_loc2_.totalStats)
         {
            this.updateFrags(_loc2_.totalStats.leftScope,_loc2_.totalStats.rightScope);
         }
      }
      
      public function setPersonalStatus(param1:uint) : void
      {
      }
      
      public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         this._enemyVehicleMarkersList.updateMarkers(_loc2_.rightVehicleInfos,_loc2_.rightCorrelationIDs);
         this._allyVehicleMarkersList.updateMarkers(_loc2_.leftVehicleInfos,_loc2_.leftCorrelationIDs);
         var _loc3_:Boolean = this._enemyVehicleMarkersList.hasMultipleTierLevel() || this._allyVehicleMarkersList.hasMultipleTierLevel();
         if(_loc3_)
         {
            this._enemyVehicleMarkersList.setIsForcedTierGrouping(true);
            this._allyVehicleMarkersList.setIsForcedTierGrouping(true);
         }
      }
      
      public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.allyTeamHealthBar.updateStage(param1,param2);
         this.enemyTeamHealthBar.updateStage(param1,param2);
      }
      
      public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
         if(_loc2_.isEnemy)
         {
            this._enemyVehicleMarkersList.updateVehicleStatus(_loc2_.vehicleID,_loc2_.status,_loc2_.rightCorrelationIDs);
         }
         else
         {
            this._allyVehicleMarkersList.updateVehicleStatus(_loc2_.vehicleID,_loc2_.status,_loc2_.leftCorrelationIDs);
         }
         if(_loc2_.totalStats)
         {
            this.updateFrags(_loc2_.totalStats.leftScope,_loc2_.totalStats.rightScope);
         }
      }
      
      public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         if(_loc2_.leftVehicleInfos)
         {
            this._allyVehicleMarkersList.updateVehiclesInfo(_loc2_.leftVehicleInfos,_loc2_.leftCorrelationIDs);
         }
         if(_loc2_.rightVehicleInfos)
         {
            this._enemyVehicleMarkersList.updateVehiclesInfo(_loc2_.rightVehicleInfos,_loc2_.rightCorrelationIDs);
         }
      }
      
      public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      public function getAllyMarkersTotalWidth() : int
      {
         return this._allyVehicleMarkersList.getMarkersTotalWidth();
      }
      
      public function getAllyMarkersStartPosition() : int
      {
         return this._allyVehicleMarkersList.getMarkersStart();
      }
      
      public function getEnemyMarkersTotalWidth() : int
      {
         return this._enemyVehicleMarkersList.getMarkersTotalWidth();
      }
      
      public function getEnemyMarkersStartPosition() : int
      {
         return this._enemyVehicleMarkersList.getMarkersStart();
      }
      
      protected function createVehicleMarkersLists(param1:MovieClip, param2:Boolean, param3:String) : VehicleMarkersList
      {
         return new VehicleMarkersList(param1,param2,param3);
      }
      
      private function updateFrags(param1:int, param2:int) : void
      {
         this._allyTeamFragsStr = param1.toString();
         this._enemyTeamFragsStr = param2.toString();
         if(param1 == param2)
         {
            this._currentTeamSeparatorState = FRAG_EQUAL;
         }
         else if(param1 > param2)
         {
            this._currentTeamSeparatorState = FRAG_WIN;
         }
         else
         {
            this._currentTeamSeparatorState = FRAG_LOSE;
         }
         invalidate(INVALID_FRAGS);
      }
      
      protected function get enemyVehicleMarkersList() : VehicleMarkersList
      {
         return this._enemyVehicleMarkersList;
      }
      
      protected function get allyVehicleMarkersList() : VehicleMarkersList
      {
         return this._allyVehicleMarkersList;
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this._winColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_WIN);
         this._loseColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_LOSE);
         this._allyVehicleMarkersList.color = this._winColorScheme.aliasColor;
         this._enemyVehicleMarkersList.color = this._loseColorScheme.aliasColor;
         invalidate(INVALID_COLOR_SCHEME);
      }
   }
}
