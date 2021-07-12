package net.wg.gui.lobby.epicBattles.components
{
   import flash.events.Event;
   import net.wg.data.constants.generated.EVENTPROGRESSION_ALIASES;
   import net.wg.data.constants.generated.EVENTPROGRESSION_CONSTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.BaseMetaLevel;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicBattlesWidgetComponent extends UIComponentEx
   {
      
      private static const RIBBON_MEDIUM_BY_MODE:Object = {};
      
      private static const RIBBON_BIG_BY_MODE:Object = {};
      
      {
         RIBBON_MEDIUM_BY_MODE[EVENTPROGRESSION_CONSTS.FRONT_LINE_MODE] = RES_ICONS.MAPS_ICONS_EPICBATTLES_RIBBON_MEDIUM;
         RIBBON_MEDIUM_BY_MODE[EVENTPROGRESSION_CONSTS.STEEL_HUNTER_MODE] = RES_ICONS.MAPS_ICONS_BATTLEROYALE_RIBBON_MEDIUM;
         RIBBON_BIG_BY_MODE[EVENTPROGRESSION_CONSTS.FRONT_LINE_MODE] = RES_ICONS.MAPS_ICONS_EPICBATTLES_RIBBON_BIG;
         RIBBON_BIG_BY_MODE[EVENTPROGRESSION_CONSTS.STEEL_HUNTER_MODE] = RES_ICONS.MAPS_ICONS_BATTLEROYALE_RIBBON_BIG;
      }
      
      public var ribbon:Image = null;
      
      private var _data:EpicBattlesWidgetVO = null;
      
      private var _eventMode:String = null;
      
      private var _metaLevelElement:BaseMetaLevel = null;
      
      public function EpicBattlesWidgetComponent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ribbon.mouseEnabled = this.ribbon.mouseChildren = false;
         this.ribbon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               if(this._eventMode != this._data.eventMode)
               {
                  this._eventMode = this._data.eventMode;
                  this.cleanMetaLevel();
                  _loc1_ = this._eventMode == EVENTPROGRESSION_CONSTS.FRONT_LINE_MODE ? EVENTPROGRESSION_ALIASES.EPIC_BATTLE_META_LEVEL_UI : EVENTPROGRESSION_ALIASES.BATTLE_ROYALE_META_LEVEL_UI;
                  this._metaLevelElement = App.utils.classFactory.getComponent(_loc1_,BaseMetaLevel);
                  addChild(this._metaLevelElement);
                  this._metaLevelElement.mouseEnabled = this._metaLevelElement.mouseChildren = false;
               }
               this._metaLevelElement.setData(this._data.epicMetaLevelIconData);
               invalidateSize();
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc2_ = App.appHeight <= StageSizeBoundaries.HEIGHT_900;
               _loc3_ = !!_loc2_ ? BaseMetaLevel.EXTRA_SMALL : BaseMetaLevel.SMALL;
               this._metaLevelElement.setIconSize(_loc3_);
               this.ribbon.source = !!_loc2_ ? RIBBON_MEDIUM_BY_MODE[this._data.eventMode] : RIBBON_BIG_BY_MODE[this._data.eventMode];
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.ribbon.x = -this.ribbon.width >> 1;
               this._metaLevelElement.y = this.ribbon.height >> 1;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.ribbon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.ribbon.dispose();
         this.ribbon = null;
         this.cleanMetaLevel();
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:EpicBattlesWidgetVO) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      private function cleanMetaLevel() : void
      {
         if(this._metaLevelElement)
         {
            removeChild(this._metaLevelElement);
            this._metaLevelElement.dispose();
            this._metaLevelElement = null;
         }
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
