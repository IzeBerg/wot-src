package net.wg.gui.bootcamp.battleResult.containers.tapeReward
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BOOTCAMP_BATTLE_RESULT_CONSTANTS;
   import net.wg.gui.bootcamp.battleResult.containers.base.BattleResultGroupLayout;
   import net.wg.gui.bootcamp.battleResult.containers.base.BattleResultsGroup;
   import net.wg.gui.bootcamp.battleResult.data.BCBattleViewVO;
   import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class TapeRewardContainer extends UIComponentEx
   {
      
      private static const RENDERER_WIDTH:int = 100;
      
      private static const SPACING_RIBBONS:int = -20;
      
      private static const SPACING_MEDALS:int = 0;
      
      private static const RIBBONS_MARGIN_X:int = 38;
      
      private static const MEDALS_MARGIN_X:int = 58;
       
      
      public var values:ValuesContainer = null;
      
      public var ribbons:BattleResultsGroup = null;
      
      public var medals:BattleResultsGroup = null;
      
      private var _data:BCBattleViewVO = null;
      
      public function TapeRewardContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.values.addEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onValuesAllRenderersLoadedHandler);
         this.ribbons.addEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onRibbonsAllRenderersLoadedHandler);
         this.medals.addEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onMedalsAllRenderersLoadedHandler);
         this.ribbons.layout = new BattleResultGroupLayout(RENDERER_WIDTH,SPACING_RIBBONS);
         this.ribbons.elementId = BOOTCAMP_BATTLE_RESULT_CONSTANTS.MEDAlS_LIST;
         this.ribbons.itemRendererLinkage = Linkages.BC_BASE_RENDERER;
         this.medals.layout = new BattleResultGroupLayout(RENDERER_WIDTH,SPACING_MEDALS);
         this.medals.elementId = BOOTCAMP_BATTLE_RESULT_CONSTANTS.MEDAlS_LIST;
         this.medals.itemRendererLinkage = Linkages.BC_BASE_RENDERER;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.validateLayout();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.validateData();
         }
      }
      
      override protected function onDispose() : void
      {
         this.values.removeEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onValuesAllRenderersLoadedHandler);
         this.ribbons.removeEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onRibbonsAllRenderersLoadedHandler);
         this.medals.removeEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onMedalsAllRenderersLoadedHandler);
         this.medals.dispose();
         this.medals = null;
         this.ribbons.dispose();
         this.ribbons = null;
         this.values.dispose();
         this.values = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:BCBattleViewVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function validateData() : void
      {
         this.ribbons.dataProvider = this._data.ribbons;
         this.ribbons.visible = this._data.ribbons.length > 0;
         this.values.setAwardValues(this._data.credits,this._data.xp);
         this.values.visible = this._data.showRewards;
         this.medals.dataProvider = this._data.medals;
         this.medals.visible = this._data.medals.length > 0;
         invalidateLayout();
      }
      
      private function validateLayout() : void
      {
         var _loc1_:Boolean = this.values.visible;
         var _loc2_:Boolean = this.medals.visible;
         var _loc3_:Boolean = this.ribbons.visible;
         if(_loc1_)
         {
            this.values.x = -this.values.actualWidth >> 1;
            this.values.y = -this.values.actualHeight >> 1;
         }
         if(_loc2_)
         {
            this.medals.y = 0;
            if(_loc1_)
            {
               this.medals.x = (this.values.actualWidth >> 1) + MEDALS_MARGIN_X;
            }
            else
            {
               this.medals.x = -this.medals.width >> 1;
            }
         }
         if(_loc3_)
         {
            this.ribbons.y = 0;
            if(_loc1_)
            {
               this.ribbons.x = -(this.values.actualWidth >> 1) - this.ribbons.width - RIBBONS_MARGIN_X >> 0;
            }
            else if(_loc2_)
            {
               this.medals.x = 0;
               this.ribbons.x = -this.ribbons.width >> 0;
            }
            else
            {
               this.ribbons.x = -this.ribbons.width >> 1;
            }
         }
      }
      
      private function onRibbonsAllRenderersLoadedHandler(param1:BattleViewEvent) : void
      {
         invalidateLayout();
         this.ribbons.showAppearAnimation();
      }
      
      private function onMedalsAllRenderersLoadedHandler(param1:BattleViewEvent) : void
      {
         invalidateLayout();
         this.medals.showAppearAnimation();
      }
      
      private function onValuesAllRenderersLoadedHandler(param1:BattleViewEvent) : void
      {
         invalidateLayout();
      }
   }
}
