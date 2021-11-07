package net.wg.gui.bootcamp.battleResult.containers.stats
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BOOTCAMP_BATTLE_RESULT_CONSTANTS;
   import net.wg.gui.bootcamp.battleResult.containers.base.BattleResultsGroup;
   import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   
   public class StatsContainer extends UIComponentEx
   {
      
      private static const STATS_SPACING:int = 52;
      
      private static const RENDERER_WIDTH:int = 100;
       
      
      public var statList:BattleResultsGroup = null;
      
      public var lightAnimationMC:MovieClip = null;
      
      private var _data:DataProvider = null;
      
      public function StatsContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.statList.addEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onStatListAllRenderersLoadedHandler);
      }
      
      override protected function onDispose() : void
      {
         this.statList.removeEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onStatListAllRenderersLoadedHandler);
         this.statList.dispose();
         this.statList = null;
         this._data = null;
         this.lightAnimationMC = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.validateLayout();
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.validateData();
         }
      }
      
      public function setData(param1:DataProvider) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function validateData() : void
      {
         this.statList.layout = new StatsGroupLayout(RENDERER_WIDTH,STATS_SPACING);
         this.statList.elementId = BOOTCAMP_BATTLE_RESULT_CONSTANTS.STATS_LIST;
         this.statList.itemRendererLinkage = Linkages.BC_STAT_RENDERER;
         this.statList.dataProvider = this._data;
         invalidateLayout();
      }
      
      private function validateLayout() : void
      {
         this.statList.x = -this.statList.width >> 1;
      }
      
      override public function get height() : Number
      {
         return this.statList.actualHeight;
      }
      
      private function onStatListAllRenderersLoadedHandler(param1:BattleViewEvent) : void
      {
         this.validateLayout();
         this.lightAnimationMC.gotoAndPlay(1);
         this.statList.showAppearAnimation();
      }
   }
}
