package net.wg.gui.lobby.hangar
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.lobby.battleRoyale.widget.data.BattleRoyaleHangarWidget;
   import net.wg.gui.lobby.battleRoyale.widget.data.BattleRoyaleTournamentWidget;
   import net.wg.gui.lobby.epicBattles.components.EpicBattlesWidget;
   import net.wg.gui.lobby.hangar.data.HangarHeaderVO;
   import net.wg.gui.lobby.hangar.interfaces.IHangarHeader;
   import net.wg.gui.lobby.hangar.interfaces.IHeaderQuestsContainer;
   import net.wg.gui.lobby.hangar.quests.BattlePassEntryPoint;
   import net.wg.gui.lobby.hangar.quests.HeaderQuestsEvent;
   import net.wg.gui.lobby.hangar.quests.HeaderQuestsFlags;
   import net.wg.gui.lobby.hangar.quests.IHeaderFlagsEntryPoint;
   import net.wg.gui.lobby.hangar.quests.SecondaryEntryPoint;
   import net.wg.gui.lobby.hangar.quests.WhiteTigerWidget;
   import net.wg.gui.lobby.rankedBattles19.components.widget.RankedBattlesHangarWidget;
   import net.wg.infrastructure.base.meta.IHangarHeaderMeta;
   import net.wg.infrastructure.base.meta.impl.HangarHeaderMeta;
   import net.wg.utils.IScheduler;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   import scaleform.clik.constants.InvalidationType;
   
   public class HangarHeader extends HangarHeaderMeta implements IHangarHeaderMeta, IHelpLayoutComponent, IHangarHeader, IStageSizeDependComponent
   {
      
      private static const SEPARATOR:String = "_";
      
      private static const HELP_OFFSET_HEIGHT:int = -3;
      
      private static const HELP_OFFSET_X:int = -30;
      
      private static const SECONDARY_ENTRY_POINT_OFFSET:int = 7;
      
      private static const SECONDARY_ENTRY_POINT_X:int = 29;
      
      private static const SECONDARY_ENTRY_POINT_X_COMPACT:int = 24;
       
      
      public var mcBackground:Sprite;
      
      public var questsFlags:HeaderQuestsFlags;
      
      public var secondaryEntryPoint:SecondaryEntryPoint;
      
      private var _data:HangarHeaderVO;
      
      private var _battlePassEntryPoint:BattlePassEntryPoint = null;
      
      private var _rankedBattlesWidget:RankedBattlesHangarWidget = null;
      
      private var _battleRoyaleHangarWidget:BattleRoyaleHangarWidget = null;
      
      private var _whiteTigerWidget:WhiteTigerWidget = null;
      
      private var _battleRoyaleTournamentWidget:BattleRoyaleTournamentWidget = null;
      
      private var _epicBattlesWidget:EpicBattlesWidget = null;
      
      private var _scheduler:IScheduler = null;
      
      private var _secondaryPointX:int = 0;
      
      public function HangarHeader()
      {
         super();
         this.secondaryEntryPoint.visible = false;
         this._scheduler = App.utils.scheduler;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.secondaryEntryPoint,HANGAR_ALIASES.SECONDARY_ENTRY_POINT);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stageSizeMgr.register(this);
         mouseEnabled = false;
         this.mcBackground.mouseEnabled = this.mcBackground.mouseChildren = false;
         this.questsFlags.addEventListener(HeaderQuestsEvent.HEADER_QUEST_CLICK,this.onBtnHeaderQuestClickHandler);
         this.questsFlags.addEventListener(HeaderQuestsFlags.ENTRY_POINT_RESIZE,this.onEntryPointResizeHandler);
         App.utils.helpLayout.registerComponent(this);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.questsFlags.removeEventListener(HeaderQuestsEvent.HEADER_QUEST_CLICK,this.onBtnHeaderQuestClickHandler);
         this.questsFlags.removeEventListener(HeaderQuestsFlags.ENTRY_POINT_RESIZE,this.onEntryPointResizeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         if(isFlashComponentRegisteredS(HANGAR_ALIASES.SECONDARY_ENTRY_POINT))
         {
            unregisterFlashComponent(HANGAR_ALIASES.SECONDARY_ENTRY_POINT);
         }
         this.secondaryEntryPoint = null;
         this.questsFlags.dispose();
         this.questsFlags = null;
         this._battlePassEntryPoint = null;
         this._rankedBattlesWidget = null;
         this._battleRoyaleHangarWidget = null;
         this._whiteTigerWidget = null;
         this._battleRoyaleTournamentWidget = null;
         this._epicBattlesWidget = null;
         this.mcBackground = null;
         this._data = null;
         this._scheduler.cancelTask(this.createBattlePass);
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IHeaderFlagsEntryPoint = null;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            visible = this._data.isVisible;
            if(this._data.isVisible)
            {
               this.questsFlags.setData(this._data.questsGroups);
            }
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            _loc1_ = 0;
            if(this.secondaryEntryPoint.visible)
            {
               _loc2_ = this._battlePassEntryPoint || this._rankedBattlesWidget || this._battleRoyaleHangarWidget || this._epicBattlesWidget || this._whiteTigerWidget;
               if(_loc2_)
               {
                  _loc1_ = (_loc2_.width >> 1) + _loc2_.marginRight + this._secondaryPointX;
                  this.secondaryEntryPoint.x = _loc1_;
                  this.secondaryEntryPoint.y = _loc2_.marginTop;
                  this.questsFlags.offsetRightSideX = _loc1_ + this.secondaryEntryPoint.width + SECONDARY_ENTRY_POINT_OFFSET >> 0;
               }
               else
               {
                  this.secondaryEntryPoint.x = 0;
                  this.questsFlags.offsetRightSideX = this.secondaryEntryPoint.width - SECONDARY_ENTRY_POINT_OFFSET;
               }
            }
            else
            {
               this.secondaryEntryPoint.x = 0;
               this.questsFlags.offsetRightSideX = 0;
            }
         }
      }
      
      override protected function setData(param1:HangarHeaderVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._data = param1;
         invalidateState();
         invalidateData();
      }
      
      public function as_createBattlePass() : void
      {
         if(this._battlePassEntryPoint == null)
         {
            this._scheduler.cancelTask(this.createBattlePass);
            this._scheduler.scheduleOnNextFrame(this.createBattlePass);
         }
      }
      
      public function as_createBattleRoyale() : void
      {
         if(this._battleRoyaleHangarWidget == null)
         {
            this._battleRoyaleHangarWidget = App.instance.utils.classFactory.getComponent(Linkages.BATTLE_ROYALE_WIDGET_UI,BattleRoyaleHangarWidget);
            this.questsFlags.setEntryPoint(this._battleRoyaleHangarWidget);
            registerFlashComponentS(this._battleRoyaleHangarWidget,HANGAR_ALIASES.BATTLE_ROYALE_ENTRY_POINT);
            invalidateLayout();
         }
      }
      
      public function as_createEventWidget() : void
      {
         if(this._whiteTigerWidget == null)
         {
            this._scheduler.cancelTask(this.createWhiteTiger);
            this._scheduler.scheduleOnNextFrame(this.createWhiteTiger);
         }
      }
      
      public function as_createBattleRoyaleTournament() : void
      {
         if(this._battleRoyaleTournamentWidget == null)
         {
            this._battleRoyaleTournamentWidget = App.instance.utils.classFactory.getComponent(Linkages.BATTLE_ROYALE_TOURNAMENT_WIDGET_UI,BattleRoyaleTournamentWidget);
            registerFlashComponentS(this._battleRoyaleTournamentWidget,HANGAR_ALIASES.BATTLE_ROYALE_TOURNAMENT);
            addChild(this._battleRoyaleTournamentWidget);
         }
      }
      
      public function as_createEpicWidget() : void
      {
         if(this._epicBattlesWidget == null)
         {
            this._epicBattlesWidget = App.instance.utils.classFactory.getComponent(Linkages.EPIC_WIDGET,EpicBattlesWidget);
            this._epicBattlesWidget.name = HANGAR_ALIASES.EPIC_WIDGET;
            registerFlashComponentS(this._epicBattlesWidget,HANGAR_ALIASES.EPIC_WIDGET);
            addChildAt(this._epicBattlesWidget,getChildIndex(this.mcBackground) + 1);
            this.updateSecondaryOffsets();
            invalidateLayout();
         }
      }
      
      public function as_createRankedBattles() : void
      {
         if(this._rankedBattlesWidget == null)
         {
            this._rankedBattlesWidget = App.instance.utils.classFactory.getComponent(Linkages.RANKED_BATTLES_WIDGET_UI,RankedBattlesHangarWidget);
            this.questsFlags.setEntryPoint(this._rankedBattlesWidget);
            registerFlashComponentS(this._rankedBattlesWidget,HANGAR_ALIASES.RANKED_WIDGET);
            invalidateLayout();
         }
      }
      
      public function as_removeBattlePass() : void
      {
         if(this._battlePassEntryPoint != null)
         {
            if(this.questsFlags.getEntryPoint() is BattlePassEntryPoint)
            {
               this.questsFlags.setEntryPoint(null);
            }
            if(isFlashComponentRegisteredS(HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT))
            {
               unregisterFlashComponentS(HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT);
            }
            this._battlePassEntryPoint = null;
            invalidateLayout();
         }
      }
      
      public function as_removeBattleRoyale() : void
      {
         if(this._battleRoyaleHangarWidget != null)
         {
            if(this.questsFlags.getEntryPoint() is BattleRoyaleHangarWidget)
            {
               this.questsFlags.setEntryPoint(null);
            }
            if(isFlashComponentRegisteredS(HANGAR_ALIASES.BATTLE_ROYALE_ENTRY_POINT))
            {
               unregisterFlashComponentS(HANGAR_ALIASES.BATTLE_ROYALE_ENTRY_POINT);
            }
            this._battleRoyaleHangarWidget = null;
            invalidateLayout();
         }
      }
      
      public function as_removeEventWidget() : void
      {
         if(this._whiteTigerWidget != null)
         {
            if(this.questsFlags.getEntryPoint() is WhiteTigerWidget)
            {
               this.questsFlags.setEntryPoint(null);
            }
            if(isFlashComponentRegisteredS(HANGAR_ALIASES.WHITE_TIGER_WIDGET))
            {
               unregisterFlashComponentS(HANGAR_ALIASES.WHITE_TIGER_WIDGET);
            }
            this._whiteTigerWidget = null;
            invalidateLayout();
         }
      }
      
      public function as_removeBattleRoyaleTournament() : void
      {
         if(this._battleRoyaleTournamentWidget != null)
         {
            if(isFlashComponentRegisteredS(HANGAR_ALIASES.BATTLE_ROYALE_TOURNAMENT))
            {
               unregisterFlashComponentS(HANGAR_ALIASES.BATTLE_ROYALE_TOURNAMENT);
            }
            removeChild(DisplayObject(this._battleRoyaleTournamentWidget));
            this._battleRoyaleTournamentWidget = null;
         }
      }
      
      public function as_removeEpicWidget() : void
      {
         if(this._epicBattlesWidget != null)
         {
            if(isFlashComponentRegisteredS(HANGAR_ALIASES.EPIC_WIDGET))
            {
               unregisterFlashComponentS(HANGAR_ALIASES.EPIC_WIDGET);
            }
            removeChild(this._epicBattlesWidget);
            this._epicBattlesWidget = null;
            this.updateSecondaryOffsets();
            invalidateLayout();
         }
      }
      
      public function as_removeRankedBattles() : void
      {
         if(this._rankedBattlesWidget != null)
         {
            if(this.questsFlags.getEntryPoint() is RankedBattlesHangarWidget)
            {
               this.questsFlags.setEntryPoint(null);
            }
            if(isFlashComponentRegisteredS(HANGAR_ALIASES.RANKED_WIDGET))
            {
               unregisterFlashComponentS(HANGAR_ALIASES.RANKED_WIDGET);
            }
            this._rankedBattlesWidget = null;
            invalidateLayout();
         }
      }
      
      public function as_setSecondaryEntryPointVisible(param1:Boolean) : void
      {
         if(this.secondaryEntryPoint.visible == param1)
         {
            return;
         }
         this.secondaryEntryPoint.visible = param1;
         invalidateLayout();
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         var _loc1_:HelpLayoutVO = new HelpLayoutVO();
         var _loc2_:Rectangle = this.questsFlags.getHitRect();
         _loc1_.x = this.questsFlags.x + _loc2_.x + HELP_OFFSET_X;
         _loc1_.y = this.questsFlags.y;
         _loc1_.width = _loc2_.width;
         _loc1_.height = _loc2_.height + HELP_OFFSET_HEIGHT;
         _loc1_.message = LOBBY_HELP.HANGAR_HEADER_QUESTS;
         _loc1_.extensibilityDirection = Directions.RIGHT;
         _loc1_.id = name + SEPARATOR + Math.random();
         _loc1_.scope = this;
         return new <HelpLayoutVO>[_loc1_];
      }
      
      public function getQuestGroupByType(param1:String) : IHeaderQuestsContainer
      {
         return this.questsFlags.getQuestGroupByID(param1);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this.updateSecondaryOffsets();
         invalidateLayout();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.questsFlags.updateStage(param1,param2);
      }
      
      private function createBattlePass() : void
      {
         this._battlePassEntryPoint = new BattlePassEntryPoint();
         this.questsFlags.setEntryPoint(this._battlePassEntryPoint);
         registerFlashComponentS(this._battlePassEntryPoint,HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT);
         invalidateLayout();
      }
      
      private function updateSecondaryOffsets() : void
      {
         var _loc1_:Boolean = false;
         if(this._epicBattlesWidget != null)
         {
            this._secondaryPointX = Values.ZERO;
         }
         else
         {
            _loc1_ = width <= StageSizeBoundaries.WIDTH_1024 || height <= StageSizeBoundaries.HEIGHT_800;
            this._secondaryPointX = !!_loc1_ ? int(SECONDARY_ENTRY_POINT_X_COMPACT) : int(SECONDARY_ENTRY_POINT_X);
         }
      }
      
      private function onEntryPointResizeHandler(param1:Event) : void
      {
         invalidateLayout();
         validateNow();
      }
      
      private function createWhiteTiger() : void
      {
         this._whiteTigerWidget = new WhiteTigerWidget();
         this.questsFlags.setEntryPoint(this._whiteTigerWidget);
         registerFlashComponentS(this._whiteTigerWidget,HANGAR_ALIASES.WHITE_TIGER_WIDGET);
      }
      
      private function onBtnHeaderQuestClickHandler(param1:HeaderQuestsEvent) : void
      {
         onQuestBtnClickS(param1.questType,param1.questID);
      }
   }
}
