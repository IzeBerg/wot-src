package net.wg.gui.battle.eventBattle.views.eventStats
{
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps.EventHunterBombTimer;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps.EventHunterResurrectTimer;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItem;
   import net.wg.gui.battle.views.stats.constants.FullStatsValidationType;
   
   public class EventStatsTableItem extends StatsTableItem
   {
      
      private static const ITEM_INDEX_SEPARATOR:String = "_";
      
      private static const INDEX_COLUMN_PREFIX:String = "c";
      
      private static const INDEX_ROW_PREFIX:String = "r";
      
      private static const BOMBTIMER_ITEM_NAME:String = "bombTimer";
      
      private static const RESURRECTTIMER_ITEM_NAME:String = "resurrectTimer";
      
      private static const CARRIERBG_ITEM_NAME:String = "carrierBg";
      
      private static const CARRIER_TEXT_COLOR:uint = 0;
      
      private static const VEHICLE_ICON_RESURRECT_COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.5,0.5,0.5,1,179,0,0,0);
       
      
      private var _bombTimer:EventHunterBombTimer = null;
      
      private var _resurrectTimer:EventHunterResurrectTimer = null;
      
      private var _carrierBg:Sprite = null;
      
      private var _isCarrier:Boolean = false;
      
      private var _isResurrect:Boolean = false;
      
      public function EventStatsTableItem(param1:EventFullStatsTable, param2:int, param3:int)
      {
         super(param1,param2,param3);
         var _loc4_:String = ITEM_INDEX_SEPARATOR + INDEX_COLUMN_PREFIX + ++param2 + INDEX_ROW_PREFIX + ++param3;
         this._bombTimer = param1[BOMBTIMER_ITEM_NAME + _loc4_];
         this._resurrectTimer = param1[RESURRECTTIMER_ITEM_NAME + _loc4_];
         this._carrierBg = param1[CARRIERBG_ITEM_NAME + _loc4_];
         this._bombTimer.visible = this._resurrectTimer.visible = this._carrierBg.visible = playerStatus.visible = false;
         this._resurrectTimer.finishCallback = this.onRespawnTimerFinished;
      }
      
      override protected function onDispose() : void
      {
         this._resurrectTimer = null;
         this._carrierBg = null;
         this._bombTimer = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(FullStatsValidationType.COLORS))
         {
            if(this._isCarrier && !isCurrentPlayer)
            {
               this.applyTextColor(CARRIER_TEXT_COLOR);
            }
            if(this._isResurrect)
            {
               vehicleIcon.transform.colorTransform = VEHICLE_ICON_RESURRECT_COLOR_TRANSFORM;
            }
         }
      }
      
      public function set isCarrier(param1:Boolean) : void
      {
         if(param1 == this._isCarrier)
         {
            return;
         }
         this._isCarrier = param1;
         invalidate(FullStatsValidationType.COLORS);
      }
      
      public function set isResurrect(param1:Boolean) : void
      {
         if(param1 == this._isResurrect)
         {
            return;
         }
         this._isResurrect = this._resurrectTimer.visible = param1;
         invalidate(FullStatsValidationType.COLORS);
         if(this._isResurrect)
         {
            super.setIsDead(false);
         }
      }
      
      public function setBombTimer(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
         this._bombTimer.visible = this._carrierBg.visible = param2 > 0;
         this._bombTimer.updateTime(param1,param2,param3,param4,this._bombTimer.visible);
      }
      
      public function setResurrectTimer(param1:Number, param2:Number, param3:Number) : void
      {
         this._resurrectTimer.updateTime(param1,param2,param3);
      }
      
      override public function reset() : void
      {
         this._isResurrect = false;
         super.reset();
      }
      
      override public function setIsDead(param1:Boolean) : void
      {
         super.setIsDead(param1 && !this._isResurrect);
      }
      
      override public function setIsSquadPersonal(param1:Boolean) : void
      {
      }
      
      override protected function applyTextColor(param1:uint) : void
      {
         super.applyTextColor(param1);
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.color = param1;
         vehicleTypeIcon.transform.colorTransform = _loc2_;
      }
      
      private function onRespawnTimerFinished() : void
      {
         this.isResurrect = false;
      }
   }
}
