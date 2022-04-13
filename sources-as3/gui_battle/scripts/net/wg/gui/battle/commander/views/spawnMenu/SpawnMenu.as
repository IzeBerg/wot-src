package net.wg.gui.battle.commander.views.spawnMenu
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.geom.Rectangle;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RTS_SPAWN_MENU_ENTRY_TYPES;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.RosterSupplyVO;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.RosterVehicleVO;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.SpawnMenuVO;
   import net.wg.gui.battle.commander.views.spawnMenu.containers.Footer;
   import net.wg.gui.battle.commander.views.spawnMenu.containers.Header;
   import net.wg.gui.battle.commander.views.spawnMenu.containers.Map;
   import net.wg.gui.battle.commander.views.spawnMenu.containers.RosterContainer;
   import net.wg.gui.battle.commander.views.spawnMenu.containers.SelectableRosterContainer;
   import net.wg.gui.battle.commander.views.spawnMenu.events.EntryEvent;
   import net.wg.gui.battle.commander.views.spawnMenu.events.SpawnMenuEvent;
   import net.wg.gui.battle.commander.views.spawnMenu.items.SelectableItem;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.MapVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.PlacePointEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.VehicleEntryVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.meta.ISpawnMenuMeta;
   import net.wg.infrastructure.base.meta.impl.SpawnMenuMeta;
   
   public class SpawnMenu extends SpawnMenuMeta implements ISpawnMenuMeta
   {
      
      private static const _SPAWN_BG_BLUR_RADIUS:Number = 10;
      
      private static const _COLOR_MULTIPLIER:Number = 0.6;
      
      private static const _STAGES:Array = ["extraSmall","small","medium","large"];
       
      
      public var spawnBg:UILoaderAlt = null;
      
      public var bodyBg:MovieClip = null;
      
      public var header:Header = null;
      
      public var left:SelectableRosterContainer = null;
      
      public var right:RosterContainer = null;
      
      public var map:Map = null;
      
      public var footer:Footer = null;
      
      private var _currentStage:String = null;
      
      private var _currentScreenRect:Rectangle;
      
      public function SpawnMenu()
      {
         this._currentScreenRect = new Rectangle();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.commons.setColorTransformMultipliers(this.spawnBg,1,_COLOR_MULTIPLIER,_COLOR_MULTIPLIER,_COLOR_MULTIPLIER);
         App.utils.commons.setBlur(this.spawnBg,_SPAWN_BG_BLUR_RADIUS,_SPAWN_BG_BLUR_RADIUS,BitmapFilterQuality.MEDIUM);
         addEventListener(SpawnMenuEvent.AUTOSET,this.onAutoSetHandler);
         addEventListener(SpawnMenuEvent.RESET,this.onResetHandler);
         addEventListener(SpawnMenuEvent.BATTLE,this.onBattleHandler);
         addEventListener(EntryEvent.FOCUS,this.onEntryEventHandler);
         addEventListener(EntryEvent.SELECT,this.onEntryEventHandler);
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.map.addEventListener(MouseEvent.CLICK,this.onMapClickHandler);
         this.right.setIsAllyContainer(false);
      }
      
      override protected function onDispose() : void
      {
         this.spawnBg.filters = [];
         removeEventListener(EntryEvent.FOCUS,this.onEntryEventHandler);
         removeEventListener(EntryEvent.SELECT,this.onEntryEventHandler);
         removeEventListener(SpawnMenuEvent.AUTOSET,this.onAutoSetHandler);
         removeEventListener(SpawnMenuEvent.RESET,this.onResetHandler);
         removeEventListener(SpawnMenuEvent.BATTLE,this.onBattleHandler);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.header.dispose();
         this.header = null;
         this.bodyBg = null;
         this.left.dispose();
         this.left = null;
         this.right.dispose();
         this.right = null;
         this.map.removeEventListener(MouseEvent.CLICK,this.onMapClickHandler);
         this.map.dispose();
         this.map = null;
         this.footer.dispose();
         this.footer = null;
         this.spawnBg.dispose();
         this.spawnBg = null;
         this._currentStage = null;
         this._currentScreenRect = null;
         super.onDispose();
      }
      
      override protected function setData(param1:SpawnMenuVO, param2:MapVO) : void
      {
         this.spawnBg.source = param2.bgPath;
         this.header.updateTextLabels(param2.name,param1.winConditionText);
         this.header.mapIconPath = param2.mapIconPath;
         this.map.setData(param2);
         this.left.setPlayerCommanderInfo(param1.playerName,param1.clanAbbrev,param1.region,param1.playerFakeName,param1.userTags);
         this.left.setPlayerBadgeInfo(param1.playerBadgeInfo);
         this.left.setSuffixBadge(param1.playerSuffixBadgeType);
         this.left.setSuffixBadgeStrip(param1.playerSuffixBadgeStripType);
         this.left.setButtonsLabels(param1.autoSetBtnText,param1.resetBtnText);
         this.setItemsData(param1.playerRosterVehicles,param1.playerRosterSupplies);
         if(param1.enemiesData != null && param1.enemiesData.length > 0)
         {
            this.right.setEnemies(param1.enemiesData);
         }
         else
         {
            this.right.setPlayerInfo(param1.enemyStrategistName);
            this.right.setPlayerBadgeInfo(param1.enemyStrategistBadgeInfo);
            this.right.setSuffixBadge(param1.enemySuffixBadgeType);
            this.right.setSuffixBadgeStrip(param1.enemySuffixBadgeStripType);
            this.right.setVehiclesAndSupplies(param1.enemyRosterVehicles,param1.enemyRosterSupplies);
         }
         this.footer.setBattleButtonText(param1.battleBtnText);
      }
      
      override protected function setItemsData(param1:Vector.<RosterVehicleVO>, param2:Vector.<RosterSupplyVO>) : void
      {
         var _loc4_:RosterVehicleVO = null;
         var _loc5_:RosterSupplyVO = null;
         var _loc3_:String = Values.EMPTY_STR;
         for each(_loc4_ in param1)
         {
            if(_loc4_.isSelected)
            {
               _loc3_ = _loc4_.vehicleID.toString();
               break;
            }
         }
         if(!_loc3_)
         {
            for each(_loc5_ in param2)
            {
               if(_loc5_.isSelected)
               {
                  _loc3_ = _loc5_.vehicleType;
                  break;
               }
            }
         }
         this.map.selectedItemID = _loc3_;
         this.left.setVehiclesAndSupplies(param1,param2);
      }
      
      override protected function updateEntriesData(param1:Vector.<PlacePointEntryVO>, param2:Vector.<VehicleEntryVO>, param3:Vector.<VehicleEntryVO>) : void
      {
         this.map.updateEntriesData(param1,param2,param3);
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Rectangle = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         super.draw();
         if(this._currentStage)
         {
            if(isInvalid(InvalidationType.SIZE))
            {
               this.header.updateStage(this._currentStage);
               this.map.updateStage(this._currentStage);
               this.left.updateStage(this._currentStage);
               this.right.updateStage(this._currentStage);
               this.footer.updateStage(this._currentStage);
               this.bodyBg.gotoAndStop(this._currentStage);
               this.header.validateNow();
               this.left.validateNow();
               this.right.validateNow();
               this.map.validateNow();
               this.footer.validateNow();
            }
            if(isInvalid(InvalidationType.SIZE | InvalidationType.POSITION))
            {
               _loc1_ = this._currentScreenRect.height >> 1;
               _loc2_ = SizeSettings.getStageSizeSettings(this._currentStage).map;
               _loc3_ = _loc2_.width >> 1;
               _loc4_ = _loc2_.height >> 1;
               this.map.x = 0;
               this.map.y = _loc1_;
               this.left.x = -_loc3_;
               this.right.x = _loc3_;
               this.left.y = this.right.y = this.header.y = this.bodyBg.y = _loc1_ - _loc4_;
               this.footer.y = _loc1_ + _loc4_;
               this.spawnBg.x = -(this._currentScreenRect.width >> 1) - _SPAWN_BG_BLUR_RADIUS;
               this.spawnBg.y = -_SPAWN_BG_BLUR_RADIUS;
               this.spawnBg.width = this._currentScreenRect.width + (_SPAWN_BG_BLUR_RADIUS << 1);
               this.spawnBg.height = this._currentScreenRect.height + (_SPAWN_BG_BLUR_RADIUS << 1);
            }
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function updateVisibility() : void
      {
         super.updateVisibility();
         this.left.setCompVisible(_isCompVisible);
      }
      
      public function as_setIsAutoSetBtnEnabled(param1:Boolean) : void
      {
         this.left.setIsAutoSetBtnEnabled(param1);
      }
      
      public function as_setIsBattleBtnEnabled(param1:Boolean) : void
      {
         this.footer.setIsBattleBtnEnabled(param1);
      }
      
      public function as_setIsResetBtnEnabled(param1:Boolean) : void
      {
         this.left.setIsResetBtnEnabled(param1);
      }
      
      public function as_setIsWaitingPlayers(param1:Boolean) : void
      {
         this.header.isWaitingPlayers = param1;
      }
      
      public function as_setIsBootcamp(param1:Boolean) : void
      {
         this.right.setIsBootcamp(param1);
      }
      
      public function as_showMapHint(param1:Boolean, param2:uint, param3:String) : void
      {
         this.map.isMapHintActive = param1;
         this.map.updateHintValues(param2,param3);
      }
      
      public function updateStageSize(param1:Number, param2:Number) : void
      {
         var _loc5_:String = null;
         var _loc6_:Rectangle = null;
         var _loc3_:String = null;
         var _loc4_:Rectangle = new Rectangle(0,0,param1,param2);
         for each(_loc5_ in _STAGES)
         {
            _loc6_ = SizeSettings.getStageSizeSettings(_loc5_).spawnMenu;
            if(_loc4_.containsRect(_loc6_))
            {
               _loc3_ = _loc5_;
            }
         }
         if(!_loc3_)
         {
            _loc3_ = _STAGES[_STAGES.length - 1];
         }
         if(_loc3_ != this._currentStage)
         {
            this._currentStage = _loc3_;
            invalidateSize();
         }
         if(_loc4_ != this._currentScreenRect)
         {
            this._currentScreenRect = _loc4_;
            invalidatePosition();
         }
      }
      
      public function get prebattleTimerY() : Number
      {
         return y + this.header.prebattleTimerY;
      }
      
      protected function isBGClicked(param1:MouseEvent) : Boolean
      {
         if(App.utils.commons.isRightButton(param1))
         {
            return true;
         }
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         while(_loc2_)
         {
            if(_loc2_ is SelectableItem || _loc2_ is Map)
            {
               return false;
            }
            _loc2_ = _loc2_.parent;
         }
         return true;
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this.isBGClicked(param1))
         {
            onBGClickS();
         }
      }
      
      private function onMapClickHandler(param1:MouseEvent) : void
      {
         this.processMapClickEvent(param1);
      }
      
      private function onAutoSetHandler(param1:SpawnMenuEvent) : void
      {
         onAutoSetBtnClickS();
      }
      
      private function onResetHandler(param1:SpawnMenuEvent) : void
      {
         onResetBtnClickS();
      }
      
      private function onBattleHandler(param1:SpawnMenuEvent) : void
      {
         onBattleBtnClickS();
      }
      
      private function onEntryEventHandler(param1:EntryEvent) : void
      {
         this.processEntryEvent(param1);
      }
      
      protected function processEntryEvent(param1:EntryEvent) : void
      {
         this.map.onEntryEvent(param1);
         this.left.onEntryEvent(param1);
         if(param1.type == EntryEvent.SELECT && param1.value)
         {
            if(param1.entryID)
            {
               onPointClickS(param1.entryID);
            }
            else if(param1.entryType == RTS_SPAWN_MENU_ENTRY_TYPES.ALLY_VEHICLE)
            {
               onVehicleSelectS(param1.vehicleID);
            }
            else if(param1.entryType == RTS_SPAWN_MENU_ENTRY_TYPES.SUPPLY)
            {
               onSupplySelectS(param1.itemID);
            }
         }
      }
      
      protected function processMapClickEvent(param1:MouseEvent) : void
      {
         this.map.isMapHintActive = false;
      }
   }
}
