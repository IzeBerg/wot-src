package net.wg.gui.battle.epicRandom.battleloading
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_TYPES;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.epicRandom.battleloading.components.EpicRandomStatsTable;
   import net.wg.gui.battle.epicRandom.battleloading.components.EpicRandomStatsTableCtrl;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.minimap.MinimapPresentation;
   import net.wg.gui.tutorial.controls.BaseTipLoadingForm;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicRandomBattleLoadingForm extends BaseTipLoadingForm
   {
      
      private static const MAP_SIZE:int = 360;
      
      private static const LOADING_BAR_MIN:int = 0;
      
      private static const LOADING_BAR_MAX:int = 1;
      
      private static const LOADING_BAR_DEF_VALUE:int = 0;
      
      private static const BETA_ICON_OFFSET_X:int = -62;
      
      private static const BETA_ICON_OFFSET_Y:int = -46;
      
      private static const TANK_ICON_SHIFT:int = 187;
      
      private static const SQUAD_ICON_SHIFT:int = 57;
       
      
      public var team1Text:TextField = null;
      
      public var team2Text:TextField = null;
      
      public var tipImage:UILoaderAlt = null;
      
      public var map:MinimapPresentation = null;
      
      public var mapBorder:MovieClip = null;
      
      public var tipBackground:BattleAtlasSprite = null;
      
      public var mapBackground:BattleAtlasSprite = null;
      
      public var formBackgroundTable:BattleAtlasSprite = null;
      
      public var betaIcon:BattleAtlasSprite = null;
      
      public var table:EpicRandomStatsTable = null;
      
      public var leftSquad:BattleAtlasSprite = null;
      
      public var leftTank:BattleAtlasSprite = null;
      
      public var rightTank:BattleAtlasSprite = null;
      
      public var rightSquad:BattleAtlasSprite = null;
      
      private var _leftSquadInitX:int;
      
      private var _leftTankInitX:int;
      
      private var _rightTankInitX:int;
      
      private var _rightSquadInitX:int;
      
      private var _tableCtrl:EpicRandomStatsTableCtrl = null;
      
      private var _leftTeamName:String = "";
      
      private var _rightTeamName:String = "";
      
      public function EpicRandomBattleLoadingForm()
      {
         super();
         this._tableCtrl = new EpicRandomStatsTableCtrl(this.table);
      }
      
      override public function addVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         this._tableCtrl.addVehiclesInfo(param1,param2,param3);
      }
      
      override public function getMapComponent() : MinimapPresentation
      {
         return this.map;
      }
      
      override public function setFormDisplayData(param1:VisualTipInfoVO) : void
      {
         if(param1.showTableBackground)
         {
            this.leftSquad.x = this._leftSquadInitX;
            this.leftTank.x = this._leftTankInitX;
            this.rightTank.x = this._rightTankInitX;
            this.rightSquad.x = this._rightSquadInitX;
            this.formBackgroundTable.imageName = BATTLEATLAS.BATTLE_LOADING_FORM_BG_TABLE;
         }
         if(param1.showTipsBackground)
         {
            this.leftSquad.x = this._leftSquadInitX - SQUAD_ICON_SHIFT;
            this.leftTank.x = this._leftTankInitX - TANK_ICON_SHIFT;
            this.rightTank.x = this._rightTankInitX + TANK_ICON_SHIFT;
            this.rightSquad.x = this._rightSquadInitX + SQUAD_ICON_SHIFT;
            this.formBackgroundTable.imageName = BATTLEATLAS.BATTLE_LOADING_FORM_BG_TIPS;
         }
         this.team1Text.x = param1.leftTeamTitleLeft;
         this.team2Text.x = param1.rightTeamTitleLeft;
         if(param1.showMinimap)
         {
            this.showMap(param1.arenaTypeID,param1.minimapTeam);
         }
         else if(param1.tipIcon != null)
         {
            this.configureTip(param1.tipTitleTop,param1.tipBodyTop,param1.tipIcon);
         }
         this.configureTip(param1.tipTitleTop,param1.tipBodyTop,param1.tipIcon);
         if(param1.showTableBackground)
         {
            this.table.team1PlayerList.itemRendererName = Linkages.ER_TABLE_LEFT_RENDERER_UI;
            this.table.team2PlayerList.itemRendererName = Linkages.ER_TABLE_RIGHT_RENDERER_UI;
         }
         else if(param1.showTipsBackground)
         {
            this.table.team1PlayerList.itemRendererName = Linkages.ER_TIP_LEFT_RENDERER_UI;
            this.table.team2PlayerList.itemRendererName = Linkages.ER_TIP_RIGHT_RENDERER_UI;
         }
      }
      
      override public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void
      {
         this._tableCtrl.setPlayerStatus(param1,param2,param3);
      }
      
      override public function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>) : void
      {
         this._tableCtrl.setUserTags(param1,param2);
      }
      
      override public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Vector.<Number>) : void
      {
         this._tableCtrl.setVehicleStatus(param1,param2,param3,param4);
      }
      
      override public function setVehiclesData(param1:Boolean, param2:Array, param3:Vector.<Number>) : void
      {
         this._tableCtrl.setVehiclesData(param1,param2,param3);
      }
      
      override public function toString() : String
      {
         return "[WG EpicRandomBattleLoadingForm " + name + "]";
      }
      
      override public function updateTeamsHeaders(param1:String, param2:String) : void
      {
         this._leftTeamName = param1;
         this._rightTeamName = param2;
         invalidateData();
      }
      
      override public function updateVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         this._tableCtrl.updateVehiclesInfo(param1,param2,param3);
      }
      
      override protected function onDispose() : void
      {
         if(this._tableCtrl)
         {
            this._tableCtrl.dispose();
            this._tableCtrl = null;
         }
         this.leftSquad = null;
         this.leftTank = null;
         this.rightTank = null;
         this.rightSquad = null;
         this.table = null;
         this.team1Text = null;
         this.team2Text = null;
         this.tipBackground = null;
         this.mapBackground = null;
         this.formBackgroundTable = null;
         this.mapBorder = null;
         this.betaIcon = null;
         this.tipImage.dispose();
         this.tipImage = null;
         this.map = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.team1Text.text = this._leftTeamName;
            this.team2Text.text = this._rightTeamName;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.formBackgroundTable.mouseChildren = this.formBackgroundTable.mouseEnabled = false;
         this.leftSquad.imageName = BATTLEATLAS.ICON_PLATOON;
         this.leftTank.imageName = BATTLEATLAS.ICON_TANK;
         this.rightTank.imageName = BATTLEATLAS.ICON_TANK;
         App.utils.commons.flipHorizontal(this.rightTank);
         this.rightSquad.imageName = BATTLEATLAS.ICON_PLATOON;
         this._leftSquadInitX = this.leftSquad.x;
         this._leftTankInitX = this.leftTank.x;
         this._rightTankInitX = this.rightTank.x;
         this._rightSquadInitX = this.rightSquad.x;
         this.hideMap();
         this.map.size = MAP_SIZE;
         mapIcon.autoSize = false;
         loadingBar.minimum = LOADING_BAR_MIN;
         loadingBar.maximum = LOADING_BAR_MAX;
         loadingBar.value = LOADING_BAR_DEF_VALUE;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.betaIcon.visible = true;
         this.betaIcon.imageName = BATTLEATLAS.EPIC_RANDOMBETA_ICON;
      }
      
      override protected function onBattleTextUpdated() : void
      {
         super.onBattleTextUpdated();
         this.betaIcon.x = battleText.x + battleText.textWidth + BETA_ICON_OFFSET_X | 0;
         this.betaIcon.y = battleText.y + BETA_ICON_OFFSET_Y | 0;
      }
      
      override protected function getBattleTypeName() : String
      {
         return BATTLE_TYPES.EPIC_RANDOM;
      }
      
      private function hideMap() : void
      {
         this.map.visible = false;
         this.mapBackground.visible = false;
         this.mapBorder.visible = false;
      }
      
      private function showMap(param1:int, param2:int) : void
      {
         this.mapBackground.visible = true;
         this.mapBackground.imageName = BATTLEATLAS.BATTLE_LOADING_FORM_MAP_BACKGROUND;
         this.mapBorder.visible = true;
         this.map.setMinimapDataS(param1,param2,MAP_SIZE);
         this.map.border.visible = false;
         this.map.grid.visible = true;
         this.map.visible = true;
      }
      
      private function configureTip(param1:int, param2:int, param3:String = null) : void
      {
         var _loc4_:Boolean = StringUtils.isNotEmpty(param3);
         this.tipBackground.visible = this.tipImage.visible = _loc4_;
         if(_loc4_)
         {
            helpTip.y = param1;
            tipText.y = param2;
            this.tipBackground.imageName = BATTLEATLAS.BATTLE_LOADING_FORM_TIP_BACKGROUND;
            this.tipImage.source = param3;
         }
      }
   }
}
