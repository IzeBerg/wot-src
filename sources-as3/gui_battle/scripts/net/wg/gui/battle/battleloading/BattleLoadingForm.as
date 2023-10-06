package net.wg.gui.battle.battleloading
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_TYPES;
   import net.wg.gui.battle.battleloading.data.VehiclesDataProvider;
   import net.wg.gui.battle.battleloading.interfaces.IVehiclesDataProvider;
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.battleloading.renderers.IBattleLoadingRenderer;
   import net.wg.gui.battle.battleloading.renderers.TablePlayerItemRenderer;
   import net.wg.gui.battle.battleloading.renderers.TipPlayerItemRenderer;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.minimap.MinimapPresentation;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleLoadingForm extends BaseLoadingForm implements IStageSizeDependComponent
   {
      
      private static const RENDERERS_COUNT:uint = 15;
      
      private static const MAP_SIZE:int = 360;
      
      private static const LOADING_BAR_MIN:int = 0;
      
      private static const LOADING_BAR_MAX:int = 1;
      
      private static const LOADING_BAR_DEF_VALUE:int = 0;
      
      private static const RENDERER_CONTAINER_LEFT_OFFSET:int = -506;
      
      private static const RENDERER_CONTAINER_TOP_OFFSET:int = 112;
      
      private static const TANK_ICON_SHIFT:int = 172;
      
      private static const SQUAD_ICON_SHIFT:int = 57;
      
      private static const RENDERERS_CONTAINER_NAME:String = "container";
      
      private static const EXTENDED_LAYOUT_OFFSET_X:int = 30;
       
      
      public var team1Text:TextField;
      
      public var team2Text:TextField;
      
      public var tipImage:UILoaderAlt;
      
      public var map:MinimapPresentation;
      
      public var mapBorder:MovieClip;
      
      public var tipBackground:BattleAtlasSprite;
      
      public var mapBackground:BattleAtlasSprite;
      
      public var formBackgroundTable:BattleAtlasSprite;
      
      public var leftSquad:BattleAtlasSprite = null;
      
      public var leftTank:BattleAtlasSprite = null;
      
      public var rightTank:BattleAtlasSprite = null;
      
      public var rightSquad:BattleAtlasSprite = null;
      
      private var _team1TextInitX:int;
      
      private var _team2TextInitX:int;
      
      private var _leftSquadInitX:int;
      
      private var _leftTankInitX:int;
      
      private var _rightTankInitX:int;
      
      private var _rightSquadInitX:int;
      
      private var _teamDP:VehiclesDataProvider;
      
      private var _enemyDP:VehiclesDataProvider;
      
      private var _leftTeamName:String = "";
      
      private var _rightTeamName:String = "";
      
      private var _allyRenderers:Vector.<IBattleLoadingRenderer>;
      
      private var _enemyRenderers:Vector.<IBattleLoadingRenderer>;
      
      private var _renderersContainer:BaseRendererContainer;
      
      public function BattleLoadingForm()
      {
         super();
      }
      
      override public function addVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         if(_loc4_.addVehiclesInfo(param2,param3))
         {
            _loc4_.invalidate();
         }
      }
      
      override public function getMapComponent() : MinimapPresentation
      {
         return this.map;
      }
      
      override public function setFormDisplayData(param1:VisualTipInfoVO) : void
      {
         if(param1.showTableBackground)
         {
            this.formBackgroundTable.imageName = BATTLEATLAS.BATTLE_LOADING_FORM_BG_TABLE;
            this.team1Text.x = param1.leftTeamTitleLeft;
            this.team2Text.x = param1.rightTeamTitleLeft;
         }
         if(param1.showTipsBackground)
         {
            this._team1TextInitX = param1.leftTeamTitleLeft;
            this._team2TextInitX = param1.rightTeamTitleLeft;
            this.formBackgroundTable.imageName = BATTLEATLAS.BATTLE_LOADING_FORM_BG_TIPS;
         }
         if(param1.showMinimap)
         {
            this.showMap(param1.arenaTypeID,param1.minimapTeam);
         }
         this.configureTip(param1.tipTitleTop,param1.tipBodyTop,param1.tipIcon);
         if(this._renderersContainer)
         {
            this._renderersContainer.dispose();
            removeChild(this._renderersContainer);
         }
         this._renderersContainer = this.getRenderersContainerInstance(param1);
         this._renderersContainer.name = RENDERERS_CONTAINER_NAME;
         this._renderersContainer.mouseEnabled = false;
         this._renderersContainer.mouseChildren = false;
         this._renderersContainer.x = RENDERER_CONTAINER_LEFT_OFFSET;
         this._renderersContainer.y = RENDERER_CONTAINER_TOP_OFFSET;
         var _loc2_:Class = this.getRendererClass(param1);
         var _loc3_:int = this.getRenderersCount();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._allyRenderers.push(new _loc2_(this._renderersContainer,_loc4_,false));
            this._enemyRenderers.push(new _loc2_(this._renderersContainer,_loc4_,true));
            _loc4_++;
         }
         addChild(this._renderersContainer);
         if(param1.showTipsBackground)
         {
            App.stageSizeMgr.register(this);
         }
      }
      
      override public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         if(_loc4_.setPlayerStatus(param2,param3))
         {
            _loc4_.invalidate();
         }
      }
      
      override public function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>) : void
      {
         var _loc3_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         if(_loc3_.setUserTags(param2))
         {
            _loc3_.invalidate();
         }
      }
      
      override public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Vector.<Number>) : void
      {
         var _loc5_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         var _loc6_:Boolean = _loc5_.setVehicleStatus(param2,param3);
         _loc6_ = _loc5_.setSorting(param4) || _loc6_;
         if(_loc6_)
         {
            _loc5_.invalidate();
         }
      }
      
      override public function setVehiclesData(param1:Boolean, param2:Array, param3:Vector.<Number>) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         _loc4_.setSource(param2);
         _loc4_.setSorting(param3);
         _loc4_.invalidate();
      }
      
      override public function toString() : String
      {
         return "[WG BattleLoadingForm " + name + "]";
      }
      
      override public function updateTeamsHeaders(param1:String, param2:String) : void
      {
         this._leftTeamName = param1;
         this._rightTeamName = param2;
         invalidateData();
      }
      
      override public function updateVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         var _loc5_:Boolean = _loc4_.updateVehiclesInfo(param2);
         _loc5_ = _loc4_.setSorting(param3) || _loc5_;
         if(_loc5_)
         {
            _loc4_.invalidate();
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc4_:IBattleLoadingRenderer = null;
         var _loc3_:Boolean = param1 >= StageSizeBoundaries.WIDTH_1366;
         this.team1Text.x = this._team1TextInitX;
         this.team2Text.x = this._team2TextInitX;
         this.leftSquad.x = this._leftSquadInitX - SQUAD_ICON_SHIFT;
         this.rightSquad.x = this._rightSquadInitX + SQUAD_ICON_SHIFT;
         if(this.leftTank)
         {
            this.leftTank.x = this._leftTankInitX - TANK_ICON_SHIFT;
         }
         if(this.rightTank)
         {
            this.rightTank.x = this._rightTankInitX + TANK_ICON_SHIFT;
         }
         if(_loc3_)
         {
            this.team1Text.x -= EXTENDED_LAYOUT_OFFSET_X;
            this.team2Text.x += EXTENDED_LAYOUT_OFFSET_X;
            this.leftSquad.x -= EXTENDED_LAYOUT_OFFSET_X;
            this.rightSquad.x += EXTENDED_LAYOUT_OFFSET_X;
            if(this.leftTank)
            {
               this.leftTank.x -= EXTENDED_LAYOUT_OFFSET_X;
            }
            if(this.rightTank)
            {
               this.rightTank.x += EXTENDED_LAYOUT_OFFSET_X;
            }
         }
         for each(_loc4_ in this._allyRenderers)
         {
            _loc4_.isExtendedLayout = _loc3_;
         }
         for each(_loc4_ in this._enemyRenderers)
         {
            _loc4_.isExtendedLayout = _loc3_;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IBattleLoadingRenderer = null;
         App.stageSizeMgr.unregister(this);
         this.leftSquad = null;
         this.leftTank = null;
         this.rightTank = null;
         this.rightSquad = null;
         this.team1Text = null;
         this.team2Text = null;
         this.tipBackground = null;
         this.mapBackground = null;
         this.formBackgroundTable = null;
         this.mapBorder = null;
         this._teamDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onAllyDataProviderUpdateItemHandler);
         this._teamDP.cleanUp();
         this._teamDP = null;
         this._enemyDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onEnemyDataProviderUpdateItemHandler);
         this._enemyDP.cleanUp();
         this._enemyDP = null;
         this.tipImage.dispose();
         this.tipImage = null;
         this.map = null;
         if(this._renderersContainer)
         {
            this._renderersContainer.dispose();
            this._renderersContainer = null;
         }
         for each(_loc1_ in this._allyRenderers)
         {
            _loc1_.dispose();
         }
         this._allyRenderers.splice(0,this._allyRenderers.length);
         this._allyRenderers = null;
         for each(_loc1_ in this._enemyRenderers)
         {
            _loc1_.dispose();
         }
         this._enemyRenderers.splice(0,this._enemyRenderers.length);
         this._enemyRenderers = null;
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
         battleIcon.visible = false;
         this.formBackgroundTable.mouseChildren = this.formBackgroundTable.mouseEnabled = false;
         this.leftSquad.imageName = BATTLEATLAS.ICON_PLATOON;
         this.rightSquad.imageName = BATTLEATLAS.ICON_PLATOON;
         this._leftSquadInitX = this.leftSquad.x;
         this._rightSquadInitX = this.rightSquad.x;
         if(this.leftTank)
         {
            this.leftTank.imageName = BATTLEATLAS.ICON_TANK;
            this._leftTankInitX = this.leftTank.x;
         }
         if(this.rightTank)
         {
            this.rightTank.imageName = BATTLEATLAS.ICON_TANK;
            App.utils.commons.flipHorizontal(this.rightTank);
            this._rightTankInitX = this.rightTank.x;
         }
         this.hideMap();
         this.map.size = MAP_SIZE;
         this._teamDP = new VehiclesDataProvider();
         this._teamDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onAllyDataProviderUpdateItemHandler);
         this._enemyDP = new VehiclesDataProvider();
         this._enemyDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onEnemyDataProviderUpdateItemHandler);
         mapIcon.autoSize = false;
         loadingBar.minimum = LOADING_BAR_MIN;
         loadingBar.maximum = LOADING_BAR_MAX;
         loadingBar.value = LOADING_BAR_DEF_VALUE;
         this._allyRenderers = new Vector.<IBattleLoadingRenderer>(0);
         this._enemyRenderers = new Vector.<IBattleLoadingRenderer>(0);
      }
      
      override protected function getBattleTypeName() : String
      {
         return BATTLE_TYPES.RANDOM;
      }
      
      protected function getRendererClass(param1:VisualTipInfoVO) : Class
      {
         return param1.settingID == BattleLoadingHelper.SETTING_TEXT ? TablePlayerItemRenderer : TipPlayerItemRenderer;
      }
      
      protected function getRenderersContainerInstance(param1:VisualTipInfoVO) : BaseRendererContainer
      {
         var _loc2_:IClassFactory = App.utils.classFactory;
         var _loc3_:String = param1.settingID == BattleLoadingHelper.SETTING_TEXT ? Linkages.BATTLE_LOADING_TABLE_RENDERERS : Linkages.BATTLE_LOADING_TIPS_RENDERERS;
         return _loc2_.getComponent(_loc3_,BaseRendererContainer);
      }
      
      protected function getRenderersCount() : uint
      {
         return RENDERERS_COUNT;
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
         var _loc4_:Boolean = false;
         _loc4_ = StringUtils.isNotEmpty(param3);
         this.tipBackground.visible = this.tipImage.visible = _loc4_;
         if(_loc4_)
         {
            helpTip.y = param1;
            tipText.y = param2;
            this.tipBackground.imageName = BATTLEATLAS.BATTLE_LOADING_FORM_TIP_BACKGROUND;
            this.tipImage.source = param3;
         }
      }
      
      private function onAllyDataProviderUpdateItemHandler(param1:ListDataProviderEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:uint = this._allyRenderers.length - 1;
         var _loc3_:Vector.<int> = Vector.<int>(param1.data);
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_ <= _loc2_)
            {
               this._allyRenderers[_loc4_].setData(this._teamDP.requestItemAt(_loc4_));
            }
         }
      }
      
      private function onEnemyDataProviderUpdateItemHandler(param1:ListDataProviderEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:uint = this._enemyRenderers.length - 1;
         var _loc3_:Vector.<int> = Vector.<int>(param1.data);
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_ <= _loc2_)
            {
               this._enemyRenderers[_loc4_].setData(this._enemyDP.requestItemAt(_loc4_));
            }
         }
      }
   }
}
