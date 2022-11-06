package net.wg.gui.lobby.battleResults.components
{
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.UserVO;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import net.wg.gui.lobby.battleResults.data.VehicleStatsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IUserProps;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class TankStatsView extends UIComponentEx
   {
      
      private static const DEAD_NAME_TEXT_COLOR:uint = 8684674;
      
      private static const LIVING_PLAYER_TEXT_COLOR:uint = 8684674;
      
      private static const NO_OWNER_DEATH_REASON_TEXT_COLOR:uint = 15327935;
      
      public static const DEFAULT_COMPONENT_WIDTH:uint = 1009;
      
      public static const DEFAULT_COMPONENT_HEIGHT:uint = 235;
      
      private static const PLAYER_TANK_NAME_PADDING:uint = 20;
      
      private static const ALPHA:Number = 0.8;
       
      
      public var playerNameLbl:UserNameField = null;
      
      public var arenaCreateDateLbl:TextField = null;
      
      public var vehicleStateLbl:TextField = null;
      
      public var tankNameLbl:TextField = null;
      
      public var tankNameDashLbl:TextField = null;
      
      public var imageSwitcher:BattleResultImageSwitcherView = null;
      
      public var dropDown:DropdownMenu = null;
      
      private var _data:BattleResultsVO = null;
      
      private var _playerVehicles:Vector.<VehicleStatsVO> = null;
      
      private var _toolTip:String = "";
      
      private var _tankMaskObj:Sprite;
      
      public function TankStatsView()
      {
         this._tankMaskObj = new Sprite();
         super();
         if(this.imageSwitcher)
         {
            addChild(this._tankMaskObj);
            this._tankMaskObj.graphics.beginFill(0);
            this._tankMaskObj.graphics.drawRect(0,1,TankStatsView.DEFAULT_COMPONENT_WIDTH,TankStatsView.DEFAULT_COMPONENT_HEIGHT);
            this._tankMaskObj.graphics.endFill();
            this.imageSwitcher.mask = this._tankMaskObj;
         }
      }
      
      private static function onVehicleStateLblRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.dropDown.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         this.initTextFields();
      }
      
      protected function initTextFields() : void
      {
         this.playerNameLbl.alpha = ALPHA;
         this.playerNameLbl.blendMode = BlendMode.ADD;
         if(this.arenaCreateDateLbl)
         {
            this.arenaCreateDateLbl.alpha = ALPHA;
            this.arenaCreateDateLbl.blendMode = BlendMode.ADD;
         }
         this.vehicleStateLbl.alpha = ALPHA;
         this.vehicleStateLbl.blendMode = BlendMode.ADD;
         this.tankNameLbl.alpha = ALPHA;
         this.tankNameLbl.blendMode = BlendMode.ADD;
         this.tankNameDashLbl.alpha = ALPHA;
         this.tankNameDashLbl.blendMode = BlendMode.ADD;
      }
      
      override protected function draw() : void
      {
         var _loc1_:CommonStatsVO = null;
         var _loc2_:UserVO = null;
         var _loc3_:Boolean = false;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._data.common;
            if(this.imageSwitcher)
            {
               this.imageSwitcher.areaIcon.source = _loc1_.arenaIcon;
            }
            _loc2_ = new UserVO({
               "userName":_loc1_.playerRealNameStr,
               "clanAbbrev":_loc1_.clanNameStr,
               "fullName":_loc1_.playerFullNameStr,
               "region":_loc1_.regionNameStr,
               "isTeamKiller":this._data.personal.isTeamKiller
            });
            this.playerNameLbl.userVO = _loc2_;
            _loc2_ = null;
            _loc3_ = _loc1_.playerVehicles.length == 1;
            if(_loc3_)
            {
               this.tankNameLbl.htmlText = _loc1_.playerVehicleNames[0];
            }
            this.tankNameDashLbl.htmlText = BATTLE_RESULTS.FINISH_PLAYERTANK_SEPARATOR;
            App.utils.commons.updateTextFieldSize(this.tankNameLbl);
            App.utils.commons.updateTextFieldSize(this.tankNameDashLbl);
            if(_loc3_)
            {
               this.setVehicleStateLbl();
            }
            if(this.arenaCreateDateLbl)
            {
               this.arenaCreateDateLbl.text = _loc1_.arenaCreateTimeStr;
            }
            this.customizeByCountVehicles(_loc3_);
         }
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this._playerVehicles = null;
         this.playerNameLbl.dispose();
         this.playerNameLbl = null;
         this.arenaCreateDateLbl = null;
         this.tankNameLbl = null;
         this.tankNameDashLbl = null;
         this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OVER,this.onVehicleStateLblRollOverHandler);
         this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OUT,onVehicleStateLblRollOutHandler);
         this.vehicleStateLbl = null;
         if(this.imageSwitcher)
         {
            this.imageSwitcher.mask = null;
            this.imageSwitcher.dispose();
            this.imageSwitcher = null;
         }
         this.dropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         this.dropDown.dispose();
         this.dropDown = null;
         this._tankMaskObj = null;
         super.onDispose();
      }
      
      public function setData(param1:BattleResultsVO) : void
      {
         this._data = param1;
         this._playerVehicles = this._data.common.playerVehicles;
         var _loc2_:int = this._playerVehicles.length;
         if(_loc2_ > 1)
         {
            this.dropDown.dataProvider = new DataProvider(param1.common.playerVehicleNames);
         }
         this.setTankIcon(0);
         invalidateData();
      }
      
      public function setVehicleIdxInGarageDropdown(param1:int) : void
      {
         this.dropDown.selectedIndex = param1;
      }
      
      protected function getVehicleAliveStateColor(param1:VehicleStatsVO) : uint
      {
         if(param1.deathReason < 0)
         {
            return LIVING_PLAYER_TEXT_COLOR;
         }
         if(param1.killerID == 0 && !param1.isPrematureLeave)
         {
            return NO_OWNER_DEATH_REASON_TEXT_COLOR;
         }
         return DEAD_NAME_TEXT_COLOR;
      }
      
      private function setVehicleStateLbl() : void
      {
         var _loc2_:IUserProps = null;
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc1_:VehicleStatsVO = this._playerVehicles[0];
         if(_loc1_.isPrematureLeave || _loc1_.killerID <= 0)
         {
            this.vehicleStateLbl.text = _loc1_.vehicleStateStr;
            this.vehicleStateLbl.textColor = this.getVehicleAliveStateColor(_loc1_);
         }
         else if(_loc1_.killerID > 0)
         {
            _loc2_ = App.utils.commons.getUserProps(_loc1_.killerRealNameStr,_loc1_.killerClanNameStr,_loc1_.killerRegionNameStr);
            _loc2_.fakeName = _loc1_.killerFakeNameStr;
            _loc2_.prefix = _loc1_.vehicleStatePrefixStr;
            _loc2_.suffix = _loc1_.vehicleStateSuffixStr;
            _loc2_.isTeamKiller = _loc1_.isKilledByTeamKiller;
            _loc3_ = App.utils.commons.formatPlayerName(this.vehicleStateLbl,_loc2_,true);
            if(_loc3_)
            {
               _loc4_ = !!_loc2_.isAnonymized ? _loc1_.killerFakeNameStr : _loc1_.killerFullNameStr;
               this.toolTip = _loc1_.vehicleStatePrefixStr + _loc4_ + _loc1_.vehicleStateSuffixStr;
            }
         }
      }
      
      private function customizeByCountVehicles(param1:Boolean) : void
      {
         this.vehicleStateLbl.visible = param1;
         this.tankNameLbl.visible = param1;
         this.dropDown.visible = !param1;
         if(param1)
         {
            this.tankNameLbl.x = DEFAULT_COMPONENT_WIDTH - this.tankNameLbl.width - PLAYER_TANK_NAME_PADDING;
            this.tankNameDashLbl.x = this.tankNameLbl.x - this.tankNameDashLbl.width;
            this.playerNameLbl.x = this.tankNameDashLbl.x - this.playerNameLbl.width;
         }
         else
         {
            this.dropDown.x = DEFAULT_COMPONENT_WIDTH - this.dropDown.width - PLAYER_TANK_NAME_PADDING;
            this.tankNameDashLbl.x = this.dropDown.x - this.tankNameDashLbl.width;
            this.playerNameLbl.x = this.tankNameDashLbl.x - this.playerNameLbl.width;
         }
      }
      
      private function setTankIcon(param1:int) : void
      {
         if(!this.imageSwitcher)
         {
            return;
         }
         var _loc2_:VehicleStatsVO = this._playerVehicles[param1];
         this.imageSwitcher.setVehicleIcon(_loc2_.isNotObserver,_loc2_.tankIcon,_loc2_.tankLevel);
      }
      
      public function get toolTip() : String
      {
         return this._toolTip;
      }
      
      public function set toolTip(param1:String) : void
      {
         this._toolTip = param1;
         this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OVER,this.onVehicleStateLblRollOverHandler);
         this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OUT,onVehicleStateLblRollOutHandler);
      }
      
      private function onVehicleStateLblRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(this.toolTip);
      }
      
      private function onDropDownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:int = param1.index;
         this._data.selectedIdxInGarageDropdown = _loc2_;
         this.setTankIcon(_loc2_);
      }
   }
}
