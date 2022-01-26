package net.wg.gui.lobby.hangar
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
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
      
      public static const WINDOW_SIZE_SMALL:String = "small";
      
      public static const WINDOW_SIZE_BIG:String = "big";
      
      public static const WINDOW_SIZE_MEDIUM:String = "medium";
      
      private static const SEPARATOR:String = "_";
      
      private static const INVALIDATE_OBJECTS_OFFSET:String = "invalidateObjectOffset";
      
      private static const HELP_OFFSET_HEIGHT:int = -3;
      
      private static const HELP_OFFSET_X:int = -30;
      
      private static const SECONDARY_ENTRY_POINT_OFFSET:int = 7;
      
      private static const SECONDARY_ENTRY_POINT_X:int = 29;
      
      private static const SECONDARY_ENTRY_POINT_X_COMPACT:int = 24;
      
      private static const QUESTS_FLAGS_DEFAULT_X_OFFSET:int = 0;
      
      private static const QUESTS_FLAGS_NY_X_OFFSET_SMALL:int = -100;
      
      private static const QUESTS_FLAGS_NY_X_OFFSET_BIG:int = -135;
      
      private static const QUESTS_FLAGS_LUNAR_NY_X_OFFSET_SMALL:int = -108;
      
      private static const QUESTS_FLAGS_LUNAR_NY_X_OFFSET_MEDIUM:int = -153;
      
      private static const QUESTS_FLAGS_LUNAR_NY_X_OFFSET_BIG:int = -205;
      
      private static const LUNAR_NY_WIDGET_X_OFFSET_BIG:int = -136;
      
      private static const LUNAR_NY_WIDGET_X_OFFSET_SMALL:int = -105;
      
      private static const LUNAR_NY_WIDGET_X_OFFSET_MEDIUM:int = -128;
      
      private static const POSITION_NY_BONUS_CREDIT_WIDGET:Object = {
         "small":{
            "x":-40,
            "y":30
         },
         "big":{
            "x":0,
            "y":30
         }
      };
      
      private static const POSITION_NY_BONUS_CREDIT_POST_NY:Object = {
         "small":{
            "x":-30,
            "y":18
         },
         "big":{
            "x":-20,
            "y":18
         }
      };
      
      private static const BG_LBL_NY:String = "ny";
      
      private static const BG_LBL_USUAL:String = "usual";
       
      
      public var mcBackground:MovieClip;
      
      public var questsFlags:HeaderQuestsFlags;
      
      public var secondaryEntryPoint:SecondaryEntryPoint;
      
      public var lunarNYWidget:LunarNYWidget = null;
      
      public var nyCreditBonus:NYCreditBonus = null;
      
      private var _data:HangarHeaderVO;
      
      private var _isSmallScreen:Boolean = false;
      
      private var _isMediumScreen:Boolean = false;
      
      private var _size:String = "big";
      
      private var _battlePassEntryPoint:BattlePassEntryPoint = null;
      
      private var _rankedBattlesWidget:RankedBattlesHangarWidget = null;
      
      private var _battleRoyaleHangarWidget:BattleRoyaleHangarWidget = null;
      
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
         registerFlashComponentS(this.lunarNYWidget,HANGAR_ALIASES.LUNAR_NY_MAIN_WIDGET_UI);
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
         this._battleRoyaleTournamentWidget = null;
         this._epicBattlesWidget = null;
         this.mcBackground = null;
         this.lunarNYWidget = null;
         this._data = null;
         this._scheduler.cancelTask(this.createBattlePass);
         this._scheduler = null;
         this.nyCreditBonus.dispose();
         this.nyCreditBonus = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:IHeaderFlagsEntryPoint = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = Boolean(this._data) ? Boolean(this._data.isNYWidgetVisible) : Boolean(false);
            _loc2_ = Boolean(this._data) ? Boolean(this._data.isPostNYEnabled) : Boolean(false);
            visible = this._data.isVisible;
            if(this._data.isVisible)
            {
               _loc3_ = this._data.isLunarNYWidgetVisible;
               this.questsFlags.setData(this._data.questsGroups);
               this.lunarNYWidget.visible = _loc3_;
               this.questsFlags.useLeftSideOffset = _loc1_ || _loc2_ || _loc3_;
               this.nyCreditBonus.bonusAmount = this._data.nyCreditBonus;
               this.nyCreditBonus.visible = _loc1_ || _loc2_;
            }
            this.mcBackground.gotoAndStop(!!_loc1_ ? BG_LBL_NY : BG_LBL_USUAL);
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            _loc4_ = 0;
            if(this.secondaryEntryPoint.visible)
            {
               _loc5_ = this._battlePassEntryPoint || this._rankedBattlesWidget || this._battleRoyaleHangarWidget || this._epicBattlesWidget;
               if(_loc5_)
               {
                  _loc4_ = (_loc5_.width >> 1) + _loc5_.marginRight + this._secondaryPointX;
                  this.secondaryEntryPoint.x = _loc4_;
                  this.secondaryEntryPoint.y = _loc5_.marginTop;
                  this.questsFlags.offsetRightSideX = _loc4_ + this.secondaryEntryPoint.width + SECONDARY_ENTRY_POINT_OFFSET >> 0;
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
         if(isInvalid(INVALIDATE_OBJECTS_OFFSET))
         {
            if(this._data)
            {
               _loc3_ = this._data.isLunarNYWidgetVisible;
               _loc1_ = this._data.isNYWidgetVisible;
               _loc2_ = this._data.isPostNYEnabled;
            }
            else
            {
               _loc3_ = _loc1_ = _loc2_ = false;
            }
            _loc6_ = QUESTS_FLAGS_DEFAULT_X_OFFSET;
            if(_loc3_)
            {
               _loc6_ = !!this._isSmallScreen ? int(QUESTS_FLAGS_LUNAR_NY_X_OFFSET_SMALL) : (!!this._isMediumScreen ? int(QUESTS_FLAGS_LUNAR_NY_X_OFFSET_MEDIUM) : int(QUESTS_FLAGS_LUNAR_NY_X_OFFSET_BIG));
            }
            else if(_loc1_)
            {
               _loc6_ = !!this._isSmallScreen ? int(QUESTS_FLAGS_NY_X_OFFSET_SMALL) : int(QUESTS_FLAGS_NY_X_OFFSET_BIG);
            }
            this.questsFlags.x = _loc6_;
            if(_loc3_)
            {
               _loc7_ = !!this._isSmallScreen ? int(LUNAR_NY_WIDGET_X_OFFSET_SMALL) : (!!this._isMediumScreen ? int(LUNAR_NY_WIDGET_X_OFFSET_MEDIUM) : int(LUNAR_NY_WIDGET_X_OFFSET_BIG));
               this.lunarNYWidget.x = _loc7_;
               this.lunarNYWidget.y = 0;
               this.lunarNYWidget.updateSize(this._size);
            }
            else if(_loc1_ || _loc2_)
            {
               _loc8_ = !!this._isSmallScreen ? WINDOW_SIZE_SMALL : WINDOW_SIZE_BIG;
               _loc9_ = !!_loc1_ ? Number(POSITION_NY_BONUS_CREDIT_WIDGET[_loc8_].x) : Number(POSITION_NY_BONUS_CREDIT_POST_NY[_loc8_].x);
               this.nyCreditBonus.x = !!_loc1_ ? Number(this.questsFlags.x + this.questsFlags.width - _loc6_ + _loc9_) : Number(_loc9_);
               this.nyCreditBonus.y = !!_loc1_ ? Number(POSITION_NY_BONUS_CREDIT_WIDGET[_loc8_].y) : Number(POSITION_NY_BONUS_CREDIT_POST_NY[_loc8_].y);
               this.nyCreditBonus.updateSize(this._isSmallScreen);
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
         invalidate(INVALIDATE_OBJECTS_OFFSET);
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
      
      public function updateStage() : void
      {
         if(App.appWidth < StageSizeBoundaries.WIDTH_1366 || App.appHeight < StageSizeBoundaries.HEIGHT_768)
         {
            this._size = WINDOW_SIZE_SMALL;
         }
         else if(App.appWidth < StageSizeBoundaries.WIDTH_1600 || App.appHeight < StageSizeBoundaries.HEIGHT_900)
         {
            this._size = WINDOW_SIZE_MEDIUM;
         }
         else
         {
            this._size = WINDOW_SIZE_BIG;
         }
         this._isSmallScreen = this._size == WINDOW_SIZE_SMALL;
         this._isMediumScreen = this._size == WINDOW_SIZE_MEDIUM;
         invalidate(INVALIDATE_OBJECTS_OFFSET);
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
      
      private function onBtnHeaderQuestClickHandler(param1:HeaderQuestsEvent) : void
      {
         onQuestBtnClickS(param1.questType,param1.questID);
      }
   }
}
