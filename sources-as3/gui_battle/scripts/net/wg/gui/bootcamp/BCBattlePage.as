package net.wg.gui.bootcamp
{
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.bootcamp.controls.BCAppearMinimapHint;
   import net.wg.gui.bootcamp.events.AppearEvent;
   import net.wg.infrastructure.base.meta.IBCBattlePageMeta;
   import net.wg.infrastructure.base.meta.impl.BCBattlePageMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   
   public class BCBattlePage extends BCBattlePageMeta implements IBCBattlePageMeta
   {
      
      private static const SEC_HINT_OFFSET_Y:int = 30;
      
      private static const RIBBONS_CENTER_SCREEN_OFFSET_Y:int = 185;
      
      private static const MINIMAP_HINT_OFFSET_POS:int = 10;
      
      private static const MINIMAP_HINT_OFFSET_SIZE:int = 7;
      
      private static const PERKS_PANEL_OFFSET_Y:int = 145;
       
      
      public var secondaryHint:BCSecondaryHint;
      
      private var _appearMinimapHint:BCAppearMinimapHint = null;
      
      public function BCBattlePage()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.secondaryHint.y = ribbonsPanel.y - SEC_HINT_OFFSET_Y;
         this.secondaryHint.x = param1 >> 1;
         perksPanel.y = param2 - PERKS_PANEL_OFFSET_Y;
         playerMessageListPositionUpdate();
      }
      
      override protected function getRibbonsCenterOffset(param1:Number) : int
      {
         return RIBBONS_CENTER_SCREEN_OFFSET_Y;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.secondaryHint,BATTLE_VIEW_ALIASES.BOOTCAMP_SECONDARY_HINT);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stage.addEventListener(AppearEvent.PREPARE,this.onStagePrepareHandler);
         minimap.addEventListener(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE,this.onMinimapOnGraphicsRectanglesUpdateHandler);
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(AppearEvent.PREPARE,this.onStagePrepareHandler);
         minimap.removeEventListener(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE,this.onMinimapOnGraphicsRectanglesUpdateHandler);
         this.secondaryHint = null;
         this._appearMinimapHint = null;
         super.onDispose();
      }
      
      private function setMinimapHintsVisible() : void
      {
         if(this._appearMinimapHint)
         {
            this._appearMinimapHint.visible = minimap.visible;
         }
      }
      
      override protected function get prebattleAmmunitionPanelAvailable() : Boolean
      {
         return false;
      }
      
      override protected function get isQuestProgress() : Boolean
      {
         return false;
      }
      
      override protected function onMinimapSizeChangedHandler(param1:MinimapEvent) : void
      {
         super.onMinimapSizeChangedHandler(param1);
         this.setMinimapHintsVisible();
      }
      
      private function onStagePrepareHandler(param1:AppearEvent) : void
      {
         this._appearMinimapHint = BCAppearMinimapHint(param1.target);
         this.setMinimapHintsVisible();
      }
      
      private function onMinimapOnGraphicsRectanglesUpdateHandler(param1:Event) : void
      {
         var _loc2_:Vector.<Rectangle> = null;
         var _loc3_:Rectangle = null;
         if(this._appearMinimapHint)
         {
            _loc2_ = minimap.getRectangles();
            if(_loc2_)
            {
               _loc3_ = _loc2_[0];
               this._appearMinimapHint.x = _loc3_.x - MINIMAP_HINT_OFFSET_POS;
               this._appearMinimapHint.y = _loc3_.y - MINIMAP_HINT_OFFSET_POS;
               this._appearMinimapHint.setProperties(_loc3_.width + MINIMAP_HINT_OFFSET_SIZE,_loc3_.height + MINIMAP_HINT_OFFSET_SIZE,true);
            }
         }
      }
   }
}
