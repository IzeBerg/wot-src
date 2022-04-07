package net.wg.gui.battle.commander.views.spawnMenu.containers
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.commander.views.spawnMenu.SizeSettings;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.BaseRosterVO;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.EnemyVehicleItemVO;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.RosterSupplyVO;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.RosterVehicleVO;
   import net.wg.gui.battle.commander.views.spawnMenu.items.SelectableItem;
   import net.wg.gui.battle.commander.views.spawnMenu.items.StagedItem;
   import net.wg.gui.battle.commander.views.spawnMenu.renderers.BaseRosterRenderer;
   import net.wg.gui.battle.commander.views.spawnMenu.renderers.EnemyVehicleRenderer;
   import net.wg.gui.battle.commander.views.spawnMenu.renderers.RosterSupplyRenderer;
   import net.wg.gui.battle.commander.views.spawnMenu.renderers.RosterVehicleRenderer;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RosterContainer extends StagedItem
   {
      
      private static const FIELD_WIDTH_COMPENSATION:int = 2;
      
      private static const RANKED_BADGE_OFFSET:int = 1;
      
      protected static const INVALID_SUFFIXBAGE:uint = 1 << 16;
      
      private static const NAME_PADDING:int = 10;
      
      private static const BADGE_PADDING_X:int = 2;
      
      private static const BADGE_OFFSET_Y:int = 2;
      
      private static const BADGE_VEHICLES_OFFSET_Y:int = 1;
       
      
      public var tanksHeaderTF:TextField = null;
      
      public var tanksMC:MovieClip = null;
      
      public var mainHeaderTitleTF:TextField = null;
      
      public var playerBadge:BadgeComponent = null;
      
      public var playerNameTF:TextField = null;
      
      public var playerBadgeVehicles:BadgeComponent = null;
      
      public var playerNameVehiclesTF:TextField = null;
      
      public var suppliesMC:MovieClip = null;
      
      public var detailsTF:TextField = null;
      
      public var supplySeparator:MovieClip = null;
      
      protected var classFactory:IClassFactory;
      
      protected var tanksData:Vector.<RosterVehicleVO> = null;
      
      protected var suppliesData:Vector.<RosterSupplyVO> = null;
      
      protected var tankRenderers:Object;
      
      protected var supplyRenderers:Object;
      
      private var _areNamesVisible:Boolean = true;
      
      private var _toolTipString:String;
      
      private var _playerName:String = "";
      
      private var _playerBadgeInfo:BadgeVisualVO = null;
      
      private var _isAllyRenderer:Boolean = true;
      
      private var _isStrategist:Boolean = false;
      
      private var _isBootcamp:Boolean = false;
      
      private var _vehiclesData:Vector.<EnemyVehicleItemVO> = null;
      
      private var _vehicleSeparators:Vector.<MovieClip>;
      
      public var icoTester:BattleAtlasSprite = null;
      
      public var testerBack:BattleAtlasSprite = null;
      
      private var _suffixBadgeType:String;
      
      private var _suffixBadgeStripType:String = null;
      
      public function RosterContainer()
      {
         this.classFactory = App.utils.classFactory;
         this.tankRenderers = {};
         this.supplyRenderers = {};
         this._vehicleSeparators = new Vector.<MovieClip>();
         super();
      }
      
      private static function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SelectableItem = null;
         var _loc2_:MovieClip = null;
         this.playerNameTF.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.playerNameTF.removeEventListener(MouseEvent.ROLL_OUT,onMouseRollOutHandler);
         this.playerNameVehiclesTF.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.playerNameVehiclesTF.removeEventListener(MouseEvent.ROLL_OUT,onMouseRollOutHandler);
         for each(_loc1_ in this.tankRenderers)
         {
            this.tanksMC.removeChild(_loc1_);
            _loc1_.dispose();
         }
         for each(_loc1_ in this.supplyRenderers)
         {
            this.suppliesMC.removeChild(_loc1_);
            _loc1_.dispose();
         }
         for each(_loc2_ in this._vehicleSeparators)
         {
            this.tanksMC.removeChild(_loc2_);
         }
         App.utils.data.cleanupDynamicObject(this.tankRenderers);
         App.utils.data.cleanupDynamicObject(this.supplyRenderers);
         this.tankRenderers = this.supplyRenderers = null;
         this._vehiclesData = null;
         this._vehicleSeparators.length = 0;
         this._vehicleSeparators = null;
         this.tanksData = null;
         this.suppliesData = null;
         this.classFactory = null;
         this.tanksHeaderTF = null;
         this.mainHeaderTitleTF = null;
         this.playerNameTF = null;
         this.playerNameVehiclesTF = null;
         this.detailsTF = null;
         this.playerBadge.dispose();
         this.playerBadgeVehicles.dispose();
         this.playerBadge = null;
         this.testerBack = null;
         this.icoTester = null;
         this.playerBadgeVehicles = null;
         this.tanksMC = null;
         this.suppliesMC = null;
         this.supplySeparator = null;
         this._toolTipString = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.playerNameTF.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler,false,0,true);
         this.playerNameTF.addEventListener(MouseEvent.ROLL_OUT,onMouseRollOutHandler,false,0,true);
         this.playerNameVehiclesTF.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler,false,0,true);
         this.playerNameVehiclesTF.addEventListener(MouseEvent.ROLL_OUT,onMouseRollOutHandler,false,0,true);
         this.icoTester.visible = false;
         this.testerBack.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.mainHeaderTitleTF.text = !!this._isAllyRenderer ? RTS_BATTLES.SPAWNMENU_BODY_PLAYERHEADER : RTS_BATTLES.SPAWNMENU_BODY_ENEMYSTRATEGISTHEADER;
            this.detailsTF.text = !!this._isBootcamp ? RTS_BATTLES.SPAWNMENU_BODY_ENEMYDETAILSTUTORIAL : RTS_BATTLES.SPAWNMENU_BODY_ENEMYDETAILS;
            this.setPlayerInfo(this._playerName);
            this.setPlayerBadgeInfo(this._playerBadgeInfo);
         }
         if(isInvalid(InvalidationType.SIZE | InvalidationType.DATA))
         {
            this.updateRoosterVehicles();
            this.updateSupplies();
            this.updateVehicles();
            this.tanksHeaderTF.text = !!this._isAllyRenderer ? RTS_BATTLES.SPAWNMENU_BODY_ALLIESHEADER : (!!this._isStrategist ? RTS_BATTLES.SPAWNMENU_BODY_COMMANDERENEMIESHEADER : RTS_BATTLES.SPAWNMENU_BODY_TANKMENENEMIESHEADER);
            this.playerBadge.x = this.mainHeaderTitleTF.x + this.mainHeaderTitleTF.textWidth + NAME_PADDING;
            this.playerBadgeVehicles.x = this.tanksHeaderTF.x + this.tanksHeaderTF.textWidth + NAME_PADDING;
            this.playerBadge.y = this.mainHeaderTitleTF.y - BADGE_OFFSET_Y;
            this.playerBadgeVehicles.y = this.tanksHeaderTF.y - BADGE_VEHICLES_OFFSET_Y;
            this.playerNameTF.x = this.playerBadge.icon == null ? Number(this.playerBadge.x) : Number(this.playerBadge.x + this.playerBadge.width + BADGE_PADDING_X);
            this.playerNameVehiclesTF.x = this.playerBadgeVehicles.icon == null ? Number(this.playerBadgeVehicles.x) : Number(this.playerBadgeVehicles.x + this.playerBadgeVehicles.width + BADGE_PADDING_X);
            this.mainHeaderTitleTF.visible = this._isStrategist;
            this.detailsTF.visible = !this._isStrategist;
            this.supplySeparator.visible = this._isStrategist && !this._isAllyRenderer;
         }
         if(isInvalid(INVALID_SUFFIXBAGE))
         {
            this.icoTester.visible = this.testerBack.visible = Boolean(this._suffixBadgeType);
            if(this.icoTester.visible)
            {
               this.icoTester.y = this.testerBack.y = this.playerNameTF.y;
               this.icoTester.imageName = this._suffixBadgeType;
               this.testerBack.imageName = this._suffixBadgeStripType;
               this.icoTester.x = this.playerNameTF.x + this.playerNameTF.textWidth + RANKED_BADGE_OFFSET >> 0;
               this.testerBack.x = -FIELD_WIDTH_COMPENSATION + ((this.icoTester.width >> 1) + this.icoTester.x - this.testerBack.width) >> 0;
            }
         }
      }
      
      public function setVehiclesAndSupplies(param1:Vector.<RosterVehicleVO>, param2:Vector.<RosterSupplyVO>) : void
      {
         this._isStrategist = true;
         this.tanksData = param1;
         this.suppliesData = param2;
         invalidateData();
      }
      
      public function setPlayerCommanderInfo(param1:String, param2:String, param3:String, param4:String, param5:Array) : void
      {
         this._playerName = param1;
         this.playerNameVehiclesTF.text = param1;
         var _loc6_:Boolean = true;
         var _loc7_:IUserProps = App.utils.commons.getUserProps(param1,param2,param3,Values.ZERO,param5,param4);
         App.utils.commons.formatPlayerName(this.playerNameTF,_loc7_,!_loc6_,_loc6_);
         App.utils.commons.formatPlayerName(this.playerNameVehiclesTF,_loc7_,!_loc6_,_loc6_);
         if(_loc6_ && StringUtils.isNotEmpty(_loc7_.fakeName) && _loc7_.isAnonymized)
         {
            this._toolTipString = _loc7_.clanAbbrev != Values.EMPTY_STR ? App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_CLAN,{"fakeName":_loc7_.fakeName}) : App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_NOCLAN,{"fakeName":_loc7_.fakeName});
         }
      }
      
      public function setPlayerInfo(param1:String) : void
      {
         this._playerName = param1;
         this.playerNameTF.text = param1;
         this.playerNameVehiclesTF.text = param1;
      }
      
      public function setPlayerBadgeInfo(param1:BadgeVisualVO) : void
      {
         this._playerBadgeInfo = param1;
         if(param1)
         {
            this.playerBadge.setData(param1);
            this.playerBadgeVehicles.setData(param1);
         }
      }
      
      public function setSuffixBadge(param1:String) : void
      {
         if(this._suffixBadgeType == param1)
         {
            return;
         }
         this._suffixBadgeType = param1;
         invalidate(INVALID_SUFFIXBAGE);
      }
      
      public function setSuffixBadgeStrip(param1:String) : void
      {
         if(this._suffixBadgeStripType == param1)
         {
            return;
         }
         this._suffixBadgeStripType = param1;
         invalidate(INVALID_SUFFIXBAGE);
      }
      
      private function addOrUpdateRoosterRenderer(param1:int, param2:String, param3:BaseRosterVO) : BaseRosterRenderer
      {
         var _loc4_:BaseRosterRenderer = null;
         var _loc5_:String = null;
         if(param1 != 0)
         {
            _loc4_ = this.tankRenderers[param1];
            if(!_loc4_)
            {
               _loc5_ = !!this._isAllyRenderer ? Linkages.SPAWN_MENU_ROOSTER_VEHICLE_RENDERER : Linkages.SPAWN_MENU_ENEMY_ROOSTER_VEHICLE_RENDERER;
               _loc4_ = this.classFactory.getComponent(_loc5_,RosterVehicleRenderer);
               this.tanksMC.addChild(_loc4_);
               this.tankRenderers[param1] = _loc4_;
            }
         }
         else
         {
            _loc4_ = this.supplyRenderers[param2];
            if(!_loc4_)
            {
               _loc4_ = this.classFactory.getComponent(Linkages.SPAWN_MENU_ROOSTER_SUPPLY_RENDERER,RosterSupplyRenderer);
               this.suppliesMC.addChild(_loc4_);
               this.supplyRenderers[param2] = _loc4_;
            }
         }
         _loc4_.setIsAllyRenderer(this._isAllyRenderer);
         _loc4_.updateStage(_currentStage);
         _loc4_.setData(param3);
         _loc4_.setNameVisibility(this._areNamesVisible);
         return _loc4_;
      }
      
      private function updateRoosterVehicles() : void
      {
         var _loc4_:RosterVehicleVO = null;
         var _loc5_:BaseRosterRenderer = null;
         if(!this.tanksData)
         {
            return;
         }
         var _loc1_:int = !!this._isAllyRenderer ? int(SizeSettings.getStageSizeSettings(_currentStage).allyItem.height) : int(SizeSettings.getStageSizeSettings(_currentStage).enemyItem.height);
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < this.tanksData.length)
         {
            if(!this._isAllyRenderer)
            {
               this.addOrUpdateEnemySeparator(_loc3_,_loc2_);
            }
            _loc4_ = this.tanksData[_loc3_];
            _loc5_ = this.addOrUpdateRoosterRenderer(_loc4_.vehicleID,"",_loc4_);
            _loc5_.y = _loc2_;
            _loc2_ += _loc1_;
            _loc3_++;
         }
         if(this.tanksData.length > 0 && !this._isAllyRenderer)
         {
            this.addOrUpdateEnemySeparator(this.tanksData.length,_loc2_);
         }
      }
      
      private function updateSupplies() : void
      {
         var _loc4_:RosterSupplyVO = null;
         var _loc5_:BaseRosterRenderer = null;
         var _loc6_:int = 0;
         if(!this.suppliesData)
         {
            return;
         }
         var _loc1_:Vector.<RosterSupplyVO> = this.suppliesData.reverse();
         var _loc2_:int = SizeSettings.getStageSizeSettings(_currentStage).supplyItem.width;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc5_ = this.addOrUpdateRoosterRenderer(0,_loc4_.vehicleType,_loc4_);
            _loc6_ = !!this._isAllyRenderer ? int(_loc3_) : int(_loc1_.length - 1 - _loc3_);
            _loc5_.x = -(_loc6_ * _loc2_);
            _loc3_++;
         }
      }
      
      private function addOrUpdateEnemySeparator(param1:int, param2:int) : void
      {
         var _loc3_:MovieClip = null;
         if(this._vehicleSeparators.length <= param1)
         {
            _loc3_ = this.classFactory.getComponent(Linkages.SPAWN_MENU_ENEMY_VEHICLE_ITEM_SEPARATOR,MovieClip);
            this.tanksMC.addChild(_loc3_);
            this._vehicleSeparators.push(_loc3_);
         }
         else
         {
            _loc3_ = this._vehicleSeparators[param1];
         }
         _loc3_.y = param2;
         _loc3_.gotoAndStop(_currentStage);
      }
      
      private function updateVehicles() : void
      {
         if(!this._vehiclesData)
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:EnemyVehicleItemVO = null;
         var _loc3_:EnemyVehicleRenderer = null;
         var _loc4_:uint = 0;
         while(_loc4_ < this._vehiclesData.length)
         {
            this.addOrUpdateEnemySeparator(_loc4_,_loc1_);
            _loc2_ = this._vehiclesData[_loc4_];
            _loc3_ = this.tankRenderers[_loc2_.vehicleID];
            if(!_loc3_)
            {
               _loc3_ = this.classFactory.getComponent(Linkages.SPAWN_MENU_ENEMY_VEHICLE_RENDERER,EnemyVehicleRenderer);
               this.tanksMC.addChild(_loc3_);
               this.tankRenderers[_loc2_.vehicleID] = _loc3_;
            }
            _loc3_.y = _loc1_;
            _loc3_.setData(_loc2_);
            _loc3_.updateStage(_currentStage);
            _loc3_.setNameVisibility(this._areNamesVisible);
            _loc1_ += SizeSettings.getStageSizeSettings(_currentStage).enemyItem.height;
            _loc4_++;
         }
         if(this._vehiclesData.length)
         {
            this.addOrUpdateEnemySeparator(this._vehiclesData.length,_loc1_);
         }
      }
      
      public function setEnemies(param1:Vector.<EnemyVehicleItemVO>) : void
      {
         this._isStrategist = false;
         this._vehiclesData = param1;
         invalidateData();
      }
      
      public function setIsAllyContainer(param1:Boolean) : void
      {
         if(this._isAllyRenderer == param1)
         {
            return;
         }
         this._isAllyRenderer = param1;
         invalidateData();
      }
      
      public function setEnemyNameVisibility(param1:Boolean) : void
      {
         if(this._areNamesVisible == param1)
         {
            return;
         }
         this._areNamesVisible = param1;
         invalidateData();
      }
      
      public function setIsBootcamp(param1:Boolean) : void
      {
         if(this._isBootcamp == param1)
         {
            return;
         }
         this._isBootcamp = param1;
      }
      
      override public function updateStage(param1:String) : void
      {
         super.updateStage(param1);
         this.supplySeparator.gotoAndStop(_currentStage);
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(this._toolTipString)
         {
            App.toolTipMgr.show(this._toolTipString);
         }
      }
   }
}
