package net.wg.gui.lobby.epicBattles.components
{
   import flash.events.Event;
   import net.wg.data.constants.generated.EVENTPROGRESSION_ALIASES;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetEvent;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.BaseMetaLevel;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicBattlesWidgetComponent extends UIComponentEx
   {
      
      private static const OFFSET_Y_SMALL:uint = 65;
      
      private static const OFFSET_Y_BIG:uint = 75;
      
      private static const META_LEVEL_ELEMENT_NAME:String = "metaLevelElement";
       
      
      public var ribbon:Image = null;
      
      private var _data:EpicBattlesWidgetVO = null;
      
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
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               if(this._metaLevelElement != null)
               {
                  this.cleanMetaLevel();
               }
               this._metaLevelElement = App.utils.classFactory.getComponent(EVENTPROGRESSION_ALIASES.EPIC_BATTLE_META_LEVEL_UI,BaseMetaLevel);
               addChild(this._metaLevelElement);
               this._metaLevelElement.name = META_LEVEL_ELEMENT_NAME;
               this._metaLevelElement.mouseEnabled = this._metaLevelElement.mouseChildren = false;
               this._metaLevelElement.setData(this._data.epicMetaLevelIconData);
               invalidateSize();
               invalidateLayout();
            }
            _loc1_ = App.appHeight <= StageSizeBoundaries.HEIGHT_900;
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc2_ = !!_loc1_ ? BaseMetaLevel.EXTRA_SMALL : BaseMetaLevel.SMALL;
               this._metaLevelElement.setIconSize(_loc2_);
               this.ribbon.source = !!_loc1_ ? RES_ICONS.MAPS_ICONS_EPICBATTLES_RIBBON_MEDIUM : RES_ICONS.MAPS_ICONS_EPICBATTLES_RIBBON_BIG;
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.ribbon.x = -this.ribbon.width >> 1;
               this._metaLevelElement.y = !!_loc1_ ? Number(OFFSET_Y_SMALL) : Number(OFFSET_Y_BIG);
               dispatchEvent(new EpicBattlesWidgetEvent(EpicBattlesWidgetEvent.LAYOUT_CHANGE));
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
      
      public function get ribbonWidth() : Number
      {
         return this.ribbon.width;
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
