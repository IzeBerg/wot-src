package net.wg.gui.battle.battleRoyale.views.components.fullStats
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.battleRoyale.BattleRoyalePage;
   import net.wg.gui.battle.battleRoyale.data.BattleRoyaleFullStatsVO;
   import net.wg.gui.battle.battleRoyale.views.components.EventViewHeader;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.BattleRoyaleNationsVehiclesCounter;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data.BattleRoyaleNationsVehiclesCounterVO;
   import net.wg.infrastructure.base.meta.IBattleRoyaleFullStatsMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleFullStatsMeta;
   import scaleform.clik.data.DataProvider;
   
   public class BattleRoyaleFullStats extends BattleRoyaleFullStatsMeta implements IBattleRoyaleFullStatsMeta
   {
      
      private static const SCORE_X:uint = 48;
      
      private static const SCORE_X_BIG:uint = 87;
      
      private static const VEHICLES_COUNTER_BOTTOM_OFFSET:int = 8;
      
      private static const VEHICLES_COUNTER_BOTTOM_OFFSET_BIG:int = 23;
      
      private static const MINIMAP_ITEMS_BOTTOM_OFFSET:int = 213;
      
      private static const MINIMAP_ITEMS_BOTTOM_OFFSET_BIG:int = 399;
      
      private static const CONTENT_SMALL_SIZE:int = 507;
      
      private static const CONTENT_BIG_SIZE:int = 725;
       
      
      public var bg:Sprite = null;
      
      public var header:EventViewHeader = null;
      
      public var minimapItems:MinimapItemsInfo = null;
      
      public var score:ScoreBlock = null;
      
      public var vehiclesCounter:BattleRoyaleNationsVehiclesCounter = null;
      
      private var _isSmallScreenSize:Boolean = false;
      
      public function BattleRoyaleFullStats()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.layoutElements();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.vehiclesCounter.addEventListener(Event.RESIZE,this.onResizeHandler);
         this.minimapItems.addEventListener(Event.RESIZE,this.onResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.vehiclesCounter.removeEventListener(Event.RESIZE,this.onResizeHandler);
         this.vehiclesCounter.dispose();
         this.vehiclesCounter = null;
         this.minimapItems.removeEventListener(Event.RESIZE,this.onResizeHandler);
         this.minimapItems.dispose();
         this.minimapItems = null;
         this.score.dispose();
         this.score = null;
         this.header.dispose();
         this.header = null;
         this.bg = null;
         super.onDispose();
      }
      
      override protected function setData(param1:BattleRoyaleFullStatsVO) : void
      {
         this.header.setData(param1.header);
         this.score.setData(param1);
         this.minimapItems.dataProvider = new DataProvider(param1.minimapItems);
      }
      
      override protected function updateVehiclesCounter(param1:BattleRoyaleNationsVehiclesCounterVO) : void
      {
         this.vehiclesCounter.setData(param1);
         invalidateSize();
      }
      
      public function as_updateScore(param1:int, param2:int, param3:String) : void
      {
         this.score.update(param1,param2,param3);
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.header.updateStage(param1,param2);
         this.bg.width = param1;
         this.bg.height = param2;
         this.bg.x = -param1 >> 1;
         this._isSmallScreenSize = BattleRoyalePage.isSmallScreenSize(param1,param2);
         this.score.useSmallLayout = this._isSmallScreenSize;
         this.minimapItems.useSmallLayout = this._isSmallScreenSize;
         this.vehiclesCounter.useSmallLayout = this._isSmallScreenSize;
         var _loc3_:Number = this.header.getContentHeight();
         var _loc4_:int = !!this._isSmallScreenSize ? int(CONTENT_SMALL_SIZE) : int(CONTENT_BIG_SIZE);
         var _loc5_:int = param2 + _loc3_ - _loc4_ >> 1;
         this.score.x = !!this._isSmallScreenSize ? Number(SCORE_X) : Number(SCORE_X_BIG);
         this.score.y = _loc5_;
         invalidateSize();
      }
      
      private function layoutElements() : void
      {
         this.vehiclesCounter.x = this.score.x + this.score.width - this.vehiclesCounter.width | 0;
         this.vehiclesCounter.y = this.score.y + this.score.height + (!!this._isSmallScreenSize ? VEHICLES_COUNTER_BOTTOM_OFFSET : VEHICLES_COUNTER_BOTTOM_OFFSET_BIG) | 0;
         this.minimapItems.x = this.score.x;
         this.minimapItems.y = this.score.y + (!!this._isSmallScreenSize ? MINIMAP_ITEMS_BOTTOM_OFFSET : MINIMAP_ITEMS_BOTTOM_OFFSET_BIG);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1 != visible)
         {
            dispatchEvent(new Event(!!param1 ? Event.OPEN : Event.CLOSE));
         }
         super.visible = param1;
      }
      
      private function onResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
