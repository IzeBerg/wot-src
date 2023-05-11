package net.wg.gui.battle.epicBattle.battleloading.renderers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.PlayerStatus;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.BattleLoadingHelper;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.gui.battle.epicRandom.battleloading.renderers.IEpicRandomBattleLoadingRenderer;
   import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.icons.PlayerActionMarker;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.InputEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class EpicBattleLoadingPlayerItemRenderer extends BattleUIComponent implements IEpicRandomBattleLoadingRenderer
   {
      
      private static const AVAILABLE_TEXT_COLOR:int = 16777215;
      
      private static const NOT_AVAILABLE_TEXT_COLOR:int = 5130300;
      
      private static const ACTION_MARKER_MYTEAM:String = "myteam";
      
      private static const ACTION_MARKER_ENEMY:String = "enemy";
      
      private static const DEF_PLAYER_ACTION:int = Values.ZERO;
      
      private static const FIELD_WIDTH_COMPENSATION:int = 2;
      
      private static const RANKED_BADGE_OFFSET:int = 1;
      
      private static const ALPHA_FULL:Number = 1;
      
      private static const ALPHA_DISABLED:Number = 0.7;
      
      private static const TEAM_KILLER_DEFAULT_VALUE:Boolean = false;
       
      
      public var textField:TextField = null;
      
      public var vehicleField:TextField = null;
      
      public var playerActionMarker:PlayerActionMarker = null;
      
      public var squad:BattleAtlasSprite = null;
      
      public var vehicleTypeIcon:BattleAtlasSprite = null;
      
      public var vehicleLevelIcon:BattleAtlasSprite = null;
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      public var icoIGR:BattleAtlasSprite = null;
      
      public var selfBg:MovieClip = null;
      
      public var deadBg:MovieClip = null;
      
      public var noLivesBg:MovieClip = null;
      
      public var rankBadge:BadgeComponent = null;
      
      public var testerIcon:BattleAtlasSprite = null;
      
      public var testerBG:BattleAtlasSprite = null;
      
      private var _model:DAAPIVehicleInfoVO;
      
      private var _epicData:EpicVehicleStatsVO;
      
      private var _isEnemy:Boolean = false;
      
      private var _defaultUsernameTFXPosition:int;
      
      private var _defaultUsernameTFWidth:int;
      
      private var _defaultVehicleFieldXPosition:int;
      
      private var _defaultVehicleFieldWidth:int;
      
      private var _colorMgr:IColorSchemeManager = null;
      
      public function EpicBattleLoadingPlayerItemRenderer()
      {
         this._colorMgr = App.colorSchemeMgr;
         super();
         TextFieldEx.setNoTranslate(this.textField,true);
         TextFieldEx.setNoTranslate(this.vehicleField,true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._defaultUsernameTFXPosition = this.textField.x;
         this._defaultUsernameTFWidth = this.textField.width;
         this._defaultVehicleFieldXPosition = this.vehicleField.x;
         this._defaultVehicleFieldWidth = this.vehicleField.width;
         this.selfBg.visible = false;
         this.deadBg.visible = false;
         this.noLivesBg.visible = false;
         this.testerIcon.visible = false;
         this.testerBG.visible = false;
         scaleX = scaleY = 1;
      }
      
      override protected function onDispose() : void
      {
         this.testerIcon = null;
         this.testerBG = null;
         this.selfBg = null;
         this.deadBg = null;
         this.noLivesBg = null;
         this.vehicleField = null;
         this.textField = null;
         this.vehicleTypeIcon = null;
         this.vehicleLevelIcon = null;
         this.vehicleIcon = null;
         this.squad = null;
         this.playerActionMarker.dispose();
         this.playerActionMarker = null;
         this.icoIGR = null;
         this._colorMgr = null;
         if(this._model)
         {
            this._model = null;
         }
         if(this._epicData)
         {
            this._epicData = null;
         }
         if(this.rankBadge)
         {
            this.rankBadge.dispose();
            this.rankBadge = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._model != null)
         {
            this.setSelfBG();
            this.setBadge();
            if(this._epicData != null && !this._epicData.hasRespawns)
            {
               this.vehicleIcon.visible = false;
               this.vehicleField.visible = false;
               this.vehicleTypeIcon.visible = false;
               this.vehicleLevelIcon.visible = false;
               this.noLivesBg.visible = true;
            }
            else
            {
               this.textField.visible = true;
               this.noLivesBg.visible = false;
               _loc1_ = UserTags.isCurrentPlayer(this._model.userTags);
               App.utils.commons.formatPlayerName(this.textField,App.utils.commons.getUserProps(this._model.playerName,this._model.clanAbbrev,this._model.region,Values.ZERO,this._model.userTags,this._model.playerFakeName),!_loc1_,_loc1_);
               this.vehicleField.visible = true;
               this.vehicleField.text = this._model.vehicleName;
               this.icoIGR.visible = this._model.isIGR;
               if(this.icoIGR.visible)
               {
                  this.icoIGR.imageName = BATTLEATLAS.ICO_IGR;
                  if(this._isEnemy)
                  {
                     this.icoIGR.x = this._defaultVehicleFieldXPosition;
                     this.vehicleField.x = this.icoIGR.x + this.icoIGR.width + FIELD_WIDTH_COMPENSATION >> 0;
                  }
                  else
                  {
                     this.icoIGR.x = this._defaultVehicleFieldXPosition + this._defaultVehicleFieldWidth - this.icoIGR.width >> 0;
                     this.vehicleField.x = this.icoIGR.x - this.vehicleField.width - FIELD_WIDTH_COMPENSATION >> 0;
                  }
               }
               else if(this._isEnemy)
               {
                  this.vehicleField.x = this._defaultVehicleFieldXPosition;
               }
               else
               {
                  this.vehicleField.x = this._defaultVehicleFieldXPosition + this._defaultVehicleFieldWidth - this.vehicleField.width >> 0;
               }
               this.setVehicleIcon();
               this.setVehicleType();
               this.setVehicleLevel();
            }
            this.updateState();
            this.setPlayerActionMarkerState();
            this.setSquadState();
            this.setSuffixBadge(this._model.suffixBadgeType,this._model.suffixBadgeStripType);
         }
         else
         {
            if(this.selfBg != null)
            {
               this.selfBg.visible = false;
            }
            this.icoIGR.visible = false;
            this.squad.visible = false;
            this.textField.visible = false;
            this.vehicleField.visible = false;
            this.vehicleIcon.visible = false;
            this.vehicleTypeIcon.visible = false;
            this.vehicleLevelIcon.visible = false;
            if(this.playerActionMarker != null)
            {
               this.playerActionMarker.action = DEF_PLAYER_ACTION;
            }
         }
      }
      
      public function getData() : Object
      {
         return this._model;
      }
      
      public function setData(param1:Object) : void
      {
         this._model = DAAPIVehicleInfoVO(param1);
         invalidate();
      }
      
      public function setEpicData(param1:EpicVehicleStatsVO) : void
      {
         this._epicData = param1;
         invalidate();
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      protected function setSelfBG() : void
      {
         this.selfBg.visible = PlayerStatus.isSelected(this._model.playerStatus);
      }
      
      private function setSuffixBadge(param1:String, param2:String) : void
      {
         var _loc3_:Boolean = StringUtils.isNotEmpty(param1);
         this.testerIcon.visible = this.testerBG.visible = _loc3_;
         if(_loc3_)
         {
            this.testerIcon.imageName = param1;
            this.testerBG.imageName = param2;
            if(this._isEnemy)
            {
               this.testerIcon.x = -FIELD_WIDTH_COMPENSATION - RANKED_BADGE_OFFSET - this.testerIcon.width + this.textField.x + (this.textField.width - this.textField.textWidth) >> 0;
               this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x + this.testerBG.width >> 0;
            }
            else
            {
               this.testerIcon.x = this.textField.x + this.textField.textWidth + FIELD_WIDTH_COMPENSATION >> 0;
               this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.width >> 0;
            }
         }
      }
      
      private function setPlayerActionMarkerState() : void
      {
         if(this.playerActionMarker != null && this._model.vehicleAction)
         {
            this.playerActionMarker.action = this._model.vehicleAction;
            this.playerActionMarker.team = !!this._isEnemy ? ACTION_MARKER_MYTEAM : ACTION_MARKER_ENEMY;
         }
      }
      
      private function setVehicleLevel() : void
      {
         if(this.vehicleLevelIcon != null)
         {
            this.vehicleLevelIcon.visible = this._model.vehicleLevel > 0;
            if(this.vehicleLevelIcon.visible)
            {
               this.vehicleLevelIcon.imageName = BATTLEATLAS.level(this._model.vehicleLevel.toString());
            }
         }
      }
      
      private function setVehicleType() : void
      {
         var _loc1_:String = null;
         if(this.vehicleTypeIcon != null)
         {
            _loc1_ = BattleLoadingHelper.instance.getVehicleTypeIconId(this._model);
            if(_loc1_)
            {
               this.vehicleTypeIcon.imageName = BATTLEATLAS.getFullStatsVehicleType(_loc1_);
               this.vehicleTypeIcon.visible = true;
            }
            else
            {
               this.vehicleTypeIcon.visible = false;
            }
         }
      }
      
      private function setVehicleIcon() : void
      {
         if(this.vehicleIcon != null)
         {
            this.vehicleIcon.visible = true;
            this.vehicleIcon.setImageNames(this._model.vehicleIconName,BATTLEATLAS.UNKNOWN);
         }
      }
      
      private function updateState() : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc1_:Boolean = this._model.isAlive();
         this.deadBg.visible = !_loc1_;
         var _loc2_:Boolean = UserTags.isCurrentPlayer(this._model.userTags);
         var _loc3_:String = PlayerStatusSchemeName.getSchemeNameForVehicle(_loc2_,this._model.isSquadPersonal(),TEAM_KILLER_DEFAULT_VALUE,!_loc1_,!this._model.isReady());
         var _loc4_:IColorScheme = this._colorMgr.getScheme(_loc3_);
         if(_loc4_)
         {
            this.vehicleIcon.transform.colorTransform = _loc4_.colorTransform;
         }
         _loc3_ = PlayerStatusSchemeName.getSchemeForVehicleLevel(!_loc1_);
         _loc4_ = this._colorMgr.getScheme(_loc3_);
         if(_loc4_)
         {
            this.vehicleLevelIcon.transform.colorTransform = _loc4_.colorTransform;
         }
         _loc3_ = PlayerStatusSchemeName.getSchemeNameForPlayer(_loc2_,this._model.isSquadPersonal(),TEAM_KILLER_DEFAULT_VALUE,!_loc1_,!this._model.isReady());
         _loc4_ = this._colorMgr.getScheme(_loc3_);
         if(_loc4_)
         {
            this.textField.textColor = _loc4_.rgb;
            this.vehicleField.textColor = _loc4_.rgb;
         }
         else
         {
            _loc5_ = true;
            if(!this._model.isNotAvailable())
            {
               _loc5_ = _loc1_ && this._model.isReady();
            }
            _loc6_ = !!_loc5_ ? Number(AVAILABLE_TEXT_COLOR) : Number(NOT_AVAILABLE_TEXT_COLOR);
            this.textField.textColor = _loc6_;
            this.vehicleField.textColor = _loc6_;
         }
      }
      
      private function setSquadState() : void
      {
         if(this.squad != null)
         {
            if(this._model.isSquadMan())
            {
               this.squad.visible = true;
               if(this._model.isSquadPersonal())
               {
                  this.squad.imageName = BATTLEATLAS.squad_gold(this._model.squadIndex.toString());
               }
               else
               {
                  this.squad.imageName = BATTLEATLAS.squad_silver(this._model.squadIndex.toString());
               }
            }
            else
            {
               this.squad.visible = false;
            }
         }
      }
      
      private function setBadge() : void
      {
         var _loc1_:int = 0;
         this.rankBadge.alpha = !!this._model.isAlive() ? Number(ALPHA_FULL) : Number(ALPHA_DISABLED);
         this.rankBadge.visible = this._model.hasSelectedBadge;
         if(this._model.hasSelectedBadge)
         {
            this.rankBadge.setData(this._model.badgeVO);
         }
         if(this.rankBadge.visible)
         {
            _loc1_ = this.rankBadge.x >> 0;
            if(this._isEnemy)
            {
               this.textField.x = _loc1_ - (this._defaultUsernameTFWidth - this.rankBadge.width >> 0);
            }
            else
            {
               this.textField.x = _loc1_ + (this.rankBadge.width + RANKED_BADGE_OFFSET >> 0);
            }
            this.textField.width = this._defaultUsernameTFWidth - (this.rankBadge.width + RANKED_BADGE_OFFSET);
         }
         else
         {
            this.textField.x = this._defaultUsernameTFXPosition;
            this.textField.width = this._defaultUsernameTFWidth;
         }
      }
      
      public function get displayFocus() : Boolean
      {
         return false;
      }
      
      public function set displayFocus(param1:Boolean) : void
      {
      }
      
      public function get focusTarget() : UIComponent
      {
         return null;
      }
      
      public function set focusTarget(param1:UIComponent) : void
      {
      }
      
      public function get UIID() : uint
      {
         return 0;
      }
      
      public function set UIID(param1:uint) : void
      {
      }
      
      public function get index() : uint
      {
         return 0;
      }
      
      public function set index(param1:uint) : void
      {
      }
      
      public function get owner() : UIComponent
      {
         return null;
      }
      
      public function set owner(param1:UIComponent) : void
      {
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function set isEnemy(param1:Boolean) : void
      {
         if(param1 == this._isEnemy)
         {
            return;
         }
         this._isEnemy = param1;
      }
      
      public function handleInput(param1:InputEvent) : void
      {
      }
   }
}
