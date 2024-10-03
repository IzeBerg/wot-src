package net.wg.gui.lobby.hangar
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.FUNRANDOM_ALIASES;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.lobby.battleRoyale.widget.data.BattleRoyaleHangarWidget;
   import net.wg.gui.lobby.battleRoyale.widget.data.BattleRoyaleTournamentWidget;
   import net.wg.gui.lobby.epicBattles.components.EpicBattlesWidget;
   import net.wg.gui.lobby.hangar.data.HangarHeaderVO;
   import net.wg.gui.lobby.hangar.interfaces.IHangarHeader;
   import net.wg.gui.lobby.hangar.interfaces.IHeaderQuestsContainer;
   import net.wg.gui.lobby.hangar.quests.BattleMattersEntryPoint;
   import net.wg.gui.lobby.hangar.quests.BattlePassEntryPoint;
   import net.wg.gui.lobby.hangar.quests.Comp7Widget;
   import net.wg.gui.lobby.hangar.quests.FunRandomHangarWidget;
   import net.wg.gui.lobby.hangar.quests.HeaderQuestsEvent;
   import net.wg.gui.lobby.hangar.quests.HeaderQuestsFlags;
   import net.wg.gui.lobby.hangar.quests.IHeaderEntryPoint;
   import net.wg.gui.lobby.hangar.quests.IHeaderSecondaryWidget;
   import net.wg.gui.lobby.hangar.quests.ResourceWellEntryPoint;
   import net.wg.gui.lobby.hangar.quests.SecondaryEntryPoint;
   import net.wg.gui.lobby.hangar.quests.WhiteTigerWidget;
   import net.wg.gui.lobby.hangar.quests.WinbackWidget;
   import net.wg.gui.lobby.rankedBattles19.components.widget.RankedBattlesHangarWidget;
   import net.wg.infrastructure.base.meta.IHangarHeaderMeta;
   import net.wg.infrastructure.base.meta.impl.HangarHeaderMeta;
   import net.wg.utils.IScheduler;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class HangarHeader extends HangarHeaderMeta implements IHangarHeaderMeta, IHelpLayoutComponent, IHangarHeader, IStageSizeDependComponent
   {
      
      private static const SEPARATOR:String = "_";
      
      private static const HELP_OFFSET_HEIGHT:int = -3;
      
      private static const HELP_OFFSET_X:int = -30;
      
      private static const SECONDARY_ENTRY_POINT_OFFSET:int = 7;
      
      private static const SECONDARY_ENTRY_POINT_X:int = 29;
      
      private static const SECONDARY_ENTRY_POINT_X_COMPACT:int = 24;
      
      private static const FUN_RANDOM_FLAGS_OFFSET_Y:uint = 39;
      
      private static const REGISTER_WIDGET_DELAY:uint = 300;
      
      private static const QUESTS_FLAGS_DEFAULT_X_OFFSET:int = 0;
      
      private static const QUESTS_FLAGS_NY_X_OFFSET_SMALL:int = -80;
      
      private static const QUESTS_FLAGS_NY_X_OFFSET_BIG:int = -135;
      
      private static const INVALIDATE_OBJECTS_OFFSET:String = "invalidateObjectOffset";
       
      
      public var mcBackground:Sprite;
      
      public var questsFlags:HeaderQuestsFlags;
      
      public var secondaryEntryPoint:SecondaryEntryPoint;
      
      private var _widget:IHeaderEntryPoint = null;
      
      private var _data:HangarHeaderVO;
      
      private var _scheduler:IScheduler;
      
      private var _secondaryPointX:int = 0;
      
      public function HangarHeader()
      {
         this._scheduler = App.utils.scheduler;
         super();
         this.secondaryEntryPoint.visible = false;
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
         App.stageSizeMgr.unregister(this);
         if(isFlashComponentRegisteredS(HANGAR_ALIASES.SECONDARY_ENTRY_POINT))
         {
            unregisterFlashComponentS(HANGAR_ALIASES.SECONDARY_ENTRY_POINT);
         }
         this._scheduler.cancelTask(this.registerWidget);
         this._scheduler.cancelTask(this.regWidget);
         this._scheduler = null;
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.secondaryEntryPoint = null;
         this.questsFlags.dispose();
         this.questsFlags = null;
         this._widget = null;
         this.mcBackground = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
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
               if(this._widget)
               {
                  _loc1_ = (this._widget.width >> 1) + this._widget.marginRight + this._secondaryPointX;
                  this.secondaryEntryPoint.x = _loc1_;
                  this.secondaryEntryPoint.y = this._widget.marginTop;
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
            if(this.hasWidget(FUNRANDOM_ALIASES.FUN_RANDOM_HANGAR_WIDGET))
            {
               this._widget.x = -(this._widget.width >> 1);
               this.questsFlags.flagsOffsetY = FUN_RANDOM_FLAGS_OFFSET_Y;
            }
            else
            {
               this.questsFlags.flagsOffsetY = HeaderQuestsFlags.DEFAULT_FLAGS_OFFSET_Y;
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
      
      public function as_addEntryPoint(param1:String) : void
      {
         this._scheduler.cancelTask(this.registerWidget);
         this._scheduler.cancelTask(this.regWidget);
         if(StringUtils.isEmpty(param1))
         {
            this.unregisterWidget();
         }
         else
         {
            this.unregisterWidget(true);
            this._scheduler.scheduleOnNextFrame(this.registerWidget,param1);
         }
      }
      
      public function as_addSecondaryEntryPoint(param1:String, param2:Boolean) : void
      {
         if(StringUtils.isEmpty(param1))
         {
            this.unregisterSecondaryWidget(param2);
         }
         else
         {
            this.unregisterSecondaryWidget(param2,true);
            this.registerSecondaryWidget(param1,param2);
         }
      }
      
      public function as_setCollectiveGoalEntryPoint(param1:Boolean) : void
      {
         this.setQuestFlagsEntryPoint(param1,Linkages.COLLECTIVE_GOAL_ENTRY_POINT,HANGAR_ALIASES.COLLECTIVE_GOAL_ENTRY_POINT,true);
      }
      
      public function as_setArmoryYardEntryPoint(param1:Boolean) : void
      {
         this.setQuestFlagsEntryPoint(param1,Linkages.ARMORY_YARD_ENTRY_POINT,HANGAR_ALIASES.ARMORY_YARD_ENTRY_POINT,false);
      }
      
      public function as_setEarlyAccessEntryPoint(param1:Boolean) : void
      {
         this.setQuestFlagsEntryPoint(param1,Linkages.EARLY_ACCESS_ENTRY_POINT,HANGAR_ALIASES.EARLY_ACCESS_SECONDARY_ENTRY_POINT,false);
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
         var _loc1_:HelpLayoutVO = null;
         var _loc2_:Rectangle = null;
         if(this.questsFlags.hasQuests)
         {
            _loc1_ = new HelpLayoutVO();
            _loc2_ = this.questsFlags.getHitRect();
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
         return new Vector.<HelpLayoutVO>(0);
      }
      
      public function getQuestGroupByType(param1:String) : IHeaderQuestsContainer
      {
         return this.questsFlags.getQuestGroupByID(param1);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this.questsFlags.isSmall = param1 < StageSizeBoundaries.WIDTH_1600 || param2 < StageSizeBoundaries.HEIGHT_900;
         this.updateSecondaryOffsets();
         invalidateLayout();
      }
      
      private function registerWidget(param1:String) : void
      {
         if(this.hasWidget(param1))
         {
            return;
         }
         var _loc2_:IHeaderEntryPoint = this.createWidget(param1);
         if(!_loc2_)
         {
            return;
         }
         _loc2_.alias = param1;
         _loc2_.name = param1;
         this.questsFlags.setEntryPoint(_loc2_);
         this._widget = _loc2_;
         invalidateLayout();
         this._scheduler.scheduleTask(this.regWidget,REGISTER_WIDGET_DELAY,_loc2_,param1);
      }
      
      private function setQuestFlagsEntryPoint(param1:Boolean, param2:String, param3:String, param4:Boolean) : void
      {
         if(param1)
         {
            this.addQuestFlagsEntryPoint(param2,param3,param4);
         }
         else
         {
            this.removeQuestFlagsEntryPoint(param3,param4);
         }
      }
      
      private function addQuestFlagsEntryPoint(param1:String, param2:String, param3:Boolean) : void
      {
         var _loc4_:IHeaderSecondaryWidget = this.questsFlags.getSecondaryEntryPoint(param3);
         if(_loc4_)
         {
            if(_loc4_.alias == param2)
            {
               return;
            }
            this.removeQuestFlagsEntryPoint(_loc4_.alias,param3);
         }
         _loc4_ = App.instance.utils.classFactory.getComponent(param1,IHeaderSecondaryWidget);
         _loc4_.alias = param2;
         this.questsFlags.addSecondaryEntryPoint(_loc4_,param3);
         registerFlashComponentS(_loc4_,param2);
      }
      
      private function removeQuestFlagsEntryPoint(param1:String, param2:Boolean) : void
      {
         var _loc3_:IHeaderSecondaryWidget = this.questsFlags.getSecondaryEntryPoint(param2);
         if(_loc3_ && _loc3_.alias == param1)
         {
            this.questsFlags.removeSecondaryEntryPoint(param2);
            unregisterFlashComponentS(param1);
         }
      }
      
      private function regWidget(param1:IHeaderEntryPoint, param2:String) : void
      {
         registerFlashComponentS(param1,param2);
      }
      
      private function registerSecondaryWidget(param1:String, param2:Boolean) : void
      {
         if(this.questsFlags.getSecondaryEntryPoint(param2))
         {
            return;
         }
         var _loc3_:IHeaderSecondaryWidget = this.createSecondaryWidget(param1);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.alias = param1;
         _loc3_.name = param1;
         this.questsFlags.addSecondaryEntryPoint(_loc3_,param2);
         registerFlashComponentS(_loc3_,param1);
         invalidateLayout();
      }
      
      private function unregisterWidget(param1:Boolean = false) : void
      {
         var _loc2_:String = null;
         if(this._widget)
         {
            _loc2_ = this._widget.alias;
            this.questsFlags.setEntryPoint(null);
            if(isFlashComponentRegisteredS(_loc2_))
            {
               unregisterFlashComponentS(_loc2_);
            }
            this._widget = null;
            if(!param1)
            {
               invalidateLayout();
            }
         }
      }
      
      private function unregisterSecondaryWidget(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc4_:String = null;
         var _loc3_:IHeaderSecondaryWidget = this.questsFlags.getSecondaryEntryPoint(param1);
         if(_loc3_)
         {
            _loc4_ = _loc3_.alias;
            this.questsFlags.removeSecondaryEntryPoint(param1);
            if(isFlashComponentRegisteredS(_loc4_))
            {
               unregisterFlashComponentS(_loc4_);
            }
            if(!param2)
            {
               invalidateLayout();
            }
         }
      }
      
      private function createWidget(param1:String) : IHeaderEntryPoint
      {
         switch(param1)
         {
            case HANGAR_ALIASES.WINBACK_WIDGET:
               return new WinbackWidget();
            case HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT:
               return new BattlePassEntryPoint();
            case HANGAR_ALIASES.BATTLE_ROYALE_ENTRY_POINT:
               return App.instance.utils.classFactory.getComponent(Linkages.BATTLE_ROYALE_WIDGET_UI,BattleRoyaleHangarWidget);
            case HANGAR_ALIASES.BATTLE_ROYALE_TOURNAMENT:
               return App.instance.utils.classFactory.getComponent(Linkages.BATTLE_ROYALE_TOURNAMENT_WIDGET_UI,BattleRoyaleTournamentWidget);
            case HANGAR_ALIASES.COMP7_WIDGET:
               return new Comp7Widget();
            case HANGAR_ALIASES.WHITE_TIGER_WIDGET:
               return new WhiteTigerWidget();
            case HANGAR_ALIASES.EPIC_WIDGET:
               return App.instance.utils.classFactory.getComponent(Linkages.EPIC_WIDGET,EpicBattlesWidget);
            case FUNRANDOM_ALIASES.FUN_RANDOM_HANGAR_WIDGET:
               return new FunRandomHangarWidget();
            case HANGAR_ALIASES.RANKED_WIDGET:
               return App.instance.utils.classFactory.getComponent(Linkages.RANKED_BATTLES_WIDGET_UI,RankedBattlesHangarWidget);
            default:
               return null;
         }
      }
      
      private function createSecondaryWidget(param1:String) : IHeaderSecondaryWidget
      {
         switch(param1)
         {
            case HANGAR_ALIASES.RESOURCE_WELL_ENTRY_POINT:
               return new ResourceWellEntryPoint();
            case HANGAR_ALIASES.BATTLE_MATTERS_ENTRY_POINT:
               return new BattleMattersEntryPoint();
            default:
               return null;
         }
      }
      
      private function hasWidget(param1:String) : Boolean
      {
         return this._widget && this._widget.alias == param1;
      }
      
      private function updateSecondaryOffsets() : void
      {
         var _loc1_:Boolean = false;
         if(this.hasWidget(HANGAR_ALIASES.EPIC_WIDGET))
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
