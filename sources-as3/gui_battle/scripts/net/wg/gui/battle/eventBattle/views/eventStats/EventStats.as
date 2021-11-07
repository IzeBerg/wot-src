package net.wg.gui.battle.eventBattle.views.eventStats
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.battle.components.FullStatsTitle;
   import net.wg.gui.battle.eventBattle.views.eventStats.VO.EventStatsBuffsVO;
   import net.wg.gui.battle.eventBattle.views.eventStats.VO.EventStatsPlayerVO;
   import net.wg.gui.battle.eventBattle.views.eventStats.renderers.StatsPlayerRenderer;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.infrastructure.base.meta.IEventStatsMeta;
   import net.wg.infrastructure.base.meta.impl.EventStatsMeta;
   
   public class EventStats extends EventStatsMeta implements IEventStatsMeta
   {
      
      protected static const INVALID_STATS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const BUFF_RENDERER:String = "BuffStatsRendererUI";
      
      private static const BUFF_GAP:int = 10;
      
      private static const BUFFS_Y:int = 55;
      
      private static const HEADER_GAP_SMALL:int = 121;
      
      private static const HEADER_GAP_BIG:int = 214;
      
      private static const STATE_BIG:String = "big";
      
      private static const STATE_SMALL:String = "small";
      
      private static const SMALL_HEIGHT:int = 900;
       
      
      public var player0:StatsPlayerRenderer = null;
      
      public var player1:StatsPlayerRenderer = null;
      
      public var player2:StatsPlayerRenderer = null;
      
      public var player3:StatsPlayerRenderer = null;
      
      public var player4:StatsPlayerRenderer = null;
      
      public var titleTF:TextField = null;
      
      public var eventStatsHeader:EventStatsHeader = null;
      
      public var teamVehiclesHeader:FullStatsTitle = null;
      
      public var buffsHeader:FullStatsTitle = null;
      
      public var header:EventStatsBuddiesHeader = null;
      
      public var dimmer:MovieClip = null;
      
      public var buffs:GroupEx = null;
      
      private var _players:Vector.<StatsPlayerRenderer> = null;
      
      private var _title:String = "";
      
      private var _desc:String = "";
      
      private var _difficultyLevel:int = 3;
      
      private var _goal:String = "";
      
      public function EventStats()
      {
         super();
         this._players = new <StatsPlayerRenderer>[this.player0,this.player1,this.player2,this.player3,this.player4];
      }
      
      public function updateStageSize(param1:Number, param2:Number) : void
      {
         var _loc3_:Boolean = param2 < SMALL_HEIGHT;
         var _loc4_:String = !!_loc3_ ? STATE_SMALL : STATE_BIG;
         var _loc5_:int = param2 >> 1;
         this.dimmer.width = param1;
         this.dimmer.height = param2;
         this.eventStatsHeader.gotoAndStop(_loc4_);
         this.eventStatsHeader.y = -_loc5_;
         this.titleTF.y = !!_loc3_ ? Number(HEADER_GAP_SMALL - _loc5_) : Number(HEADER_GAP_BIG - _loc5_);
         this.buffsPosition();
         invalidate(INVALID_STATS);
      }
      
      public function as_updateData(param1:String, param2:String, param3:int, param4:String) : void
      {
         this._title = param1;
         this._desc = param2;
         this._difficultyLevel = param3;
         this._goal = param4;
         invalidate(INVALID_STATS);
      }
      
      override protected function updatePlayerStats(param1:Vector.<EventStatsPlayerVO>) : void
      {
         var _loc2_:uint = Math.min(param1.length,this._players.length);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this._players[_loc3_].update(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      override protected function updateBuffs(param1:EventStatsBuffsVO) : void
      {
         this.buffs.dataProvider = param1.buffs;
         this.buffsHeader.visible = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:DAAPIQuestStatusVO = new DAAPIQuestStatusVO({"status":Values.EMPTY_STR});
         this.teamVehiclesHeader.setStatus(_loc1_);
         this.teamVehiclesHeader.setTitle(App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE,App.utils.locale.makeString(EVENT.RESULTSCREEN_STATS_HEADER)));
         this.buffsHeader.setStatus(_loc1_);
         this.buffsHeader.setTitle(App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE,App.utils.locale.makeString(INGAME_GUI.STATISTICS_TAB_EVENT_TITLE)));
         this.buffsHeader.visible = false;
         this.buffs.layout = new HorizontalGroupLayout(BUFF_GAP);
         this.buffs.itemRendererLinkage = BUFF_RENDERER;
         this.buffs.addEventListener(Event.RESIZE,this.onBuffsResizeHandler);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(INVALID_STATS))
         {
            this.eventStatsHeader.setData(this._title,this._desc,this._difficultyLevel);
            this.titleTF.text = this._goal;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:StatsPlayerRenderer = null;
         for each(_loc1_ in this._players)
         {
            _loc1_.dispose();
         }
         this.player0 = null;
         this.player1 = null;
         this.player2 = null;
         this.player3 = null;
         this.player4 = null;
         this._players.splice(0,this._players.length);
         this._players = null;
         this.teamVehiclesHeader.dispose();
         this.teamVehiclesHeader = null;
         this.buffsHeader.dispose();
         this.buffsHeader = null;
         this.buffs.removeEventListener(Event.RESIZE,this.onBuffsResizeHandler);
         this.buffs.dispose();
         this.buffs = null;
         this.header.dispose();
         this.header = null;
         this.dimmer = null;
         this.titleTF = null;
         this.eventStatsHeader.dispose();
         this.eventStatsHeader = null;
         super.onDispose();
      }
      
      private function buffsPosition() : void
      {
         if(this.buffs.dataProvider && this.buffs.dataProvider.length > 0)
         {
            this.buffs.y = this.buffsHeader.y + BUFFS_Y;
            this.buffs.x = -this.buffs.width >> 1;
         }
      }
      
      private function onBuffsResizeHandler(param1:Event) : void
      {
         this.buffsPosition();
      }
   }
}
