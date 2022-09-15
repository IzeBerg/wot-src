package net.wg.gui.bootcamp.battleResult.containers.base
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.gui.bootcamp.battleResult.BCBattleResult;
   import net.wg.gui.bootcamp.battleResult.containers.bottomReward.BottomRewardContainer;
   import net.wg.gui.bootcamp.battleResult.containers.stats.StatsContainer;
   import net.wg.gui.bootcamp.battleResult.containers.tapeReward.TapeRewardContainer;
   import net.wg.gui.bootcamp.battleResult.data.BCBattleViewVO;
   import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleResultContent extends UIComponentEx
   {
      
      private static const TAPE_MARGIN_Y:int = 27;
      
      private static const TAPE_SHADOW_MARGIN_Y:int = 7;
      
      private static const TAPE_MARGIN_SMALL_Y:int = 15;
      
      private static const TAPE_SHADOW_MARGIN_SMALL_Y:int = 7;
      
      private static const REWARDS_HEIGHT:int = 127;
      
      private static const REWARDS_OFFSET:int = 4;
       
      
      public var stats:StatsContainer = null;
      
      public var tapeOuterMC:MovieClip = null;
      
      public var tapeShadowMC:MovieClip = null;
      
      public var tapeReward:TapeRewardContainer = null;
      
      public var bottomReward:BottomRewardContainer = null;
      
      private var _data:BCBattleViewVO = null;
      
      private var _stageDimensions:Point;
      
      public function BattleResultContent()
      {
         this._stageDimensions = new Point();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.stats.visible = false;
         this.tapeReward.visible = false;
         addEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onAllRenderersLoadedHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.validateLayout();
         }
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.validateData();
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onAllRenderersLoadedHandler);
         this.stats.dispose();
         this.stats = null;
         this.tapeReward.dispose();
         this.tapeReward = null;
         this.bottomReward.dispose();
         this.bottomReward = null;
         this.tapeOuterMC = null;
         this.tapeShadowMC = null;
         this._data = null;
         this._stageDimensions = null;
         super.onDispose();
      }
      
      public function centerReward(param1:int) : void
      {
         this.bottomReward.y = this.tapeYBottomPos + (param1 - REWARDS_HEIGHT >> 1) - REWARDS_OFFSET;
      }
      
      public function setData(param1:BCBattleViewVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageDimensions.x = param1;
         this._stageDimensions.y = param2;
         this.tapeShadowMC.width = param1;
         var _loc3_:String = param2 <= BCBattleResult.STAGE_SMALL_SIZE ? BCBattleResult.SMALL : BCBattleResult.BIG;
         this.tapeOuterMC.tapeMC.gotoAndStop(_loc3_);
         invalidateLayout();
      }
      
      private function validateLayout() : void
      {
         this.tapeShadowMC.x = -this.tapeShadowMC.width >> 1;
         if(this._stageDimensions.y <= BCBattleResult.STAGE_SMALL_SIZE)
         {
            this.tapeReward.y = this.tapeOuterMC.y = this.stats.y + this.stats.height + (this.tapeOuterMC.height >> 1) + TAPE_MARGIN_SMALL_Y >> 0;
            this.tapeShadowMC.y = this.tapeOuterMC.y - (this.tapeOuterMC.height >> 1) + TAPE_SHADOW_MARGIN_SMALL_Y >> 0;
         }
         else
         {
            this.tapeReward.y = this.tapeOuterMC.y = this.stats.y + this.stats.height + (this.tapeOuterMC.height >> 1) + TAPE_MARGIN_Y >> 0;
            this.tapeShadowMC.y = this.tapeOuterMC.y - (this.tapeOuterMC.height >> 1) + TAPE_SHADOW_MARGIN_Y >> 0;
         }
      }
      
      private function validateData() : void
      {
         this.stats.setData(this._data.stats);
         this.stats.visible = this._data.stats.length > 0;
         this.tapeReward.visible = this.tapeShadowMC.visible = this.tapeOuterMC.visible = !(!this._data.showRewards && this._data.ribbons.length == 0 && this._data.medals.length == 0);
         this.tapeReward.setData(this._data);
         this.bottomReward.animate();
         invalidateLayout();
      }
      
      override public function get height() : Number
      {
         return this.bottomReward.y + this.bottomReward.height;
      }
      
      public function get tapeYPos() : Number
      {
         return this.tapeOuterMC.y;
      }
      
      public function get tapeYBottomPos() : int
      {
         return this.tapeOuterMC.y + (this.tapeOuterMC.height >> 1);
      }
      
      private function onAllRenderersLoadedHandler(param1:BattleViewEvent) : void
      {
         this.validateLayout();
      }
   }
}
