package net.wg.gui.battle.eventBattle.views.shared
{
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.eventBattle.views.minimap.entries.EventDeploymentPointMinimapEntry;
   import net.wg.gui.battle.views.minimap.BaseMinimap;
   import net.wg.utils.StageSizeBoundaries;
   
   public class EventDeploymentMapView extends BattleDisplayable
   {
      
      public static const OVERLAY_ALPHA:Number = 0.3;
       
      
      protected var minimap:BaseMinimap = null;
      
      protected var stageWidth:int = 0;
      
      protected var stageHeight:int = 0;
      
      public function EventDeploymentMapView()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.detachMinimap();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            graphics.clear();
            graphics.beginFill(0,OVERLAY_ALPHA);
            graphics.drawRect(0,0,this.stageWidth,this.stageHeight);
            graphics.endFill();
            if(this.minimap)
            {
               this.minimap.updateSizeIndex(false);
            }
         }
      }
      
      public function attachMinimap(param1:BaseMinimap) : void
      {
         this.minimap = param1;
         this.minimap.addEventListener(EventDeploymentPointMinimapEntry.EVENT_DEPLOYMENT_SELECTED,this.onMinimapDeploymentSelectedHandler);
         addChild(this.minimap);
         invalidateSize();
      }
      
      public function detachMinimap() : void
      {
         if(this.minimap)
         {
            this.minimap.removeEventListener(EventDeploymentPointMinimapEntry.EVENT_DEPLOYMENT_SELECTED,this.onMinimapDeploymentSelectedHandler);
            this.minimap = null;
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.stageWidth = param1;
         this.stageHeight = param2;
         invalidateSize();
      }
      
      protected function onMinimapDeploymentPointSelect(param1:String) : void
      {
      }
      
      protected function get isSmallScreen() : Boolean
      {
         return this.stageHeight < StageSizeBoundaries.HEIGHT_1080 || this.stageWidth < StageSizeBoundaries.WIDTH_1920;
      }
      
      private function onMinimapDeploymentSelectedHandler(param1:Event) : void
      {
         var _loc2_:EventDeploymentPointMinimapEntry = param1.target as EventDeploymentPointMinimapEntry;
         if(_loc2_)
         {
            this.onMinimapDeploymentPointSelect(_loc2_.id);
         }
         else
         {
            App.utils.asserter.assertNotNull(_loc2_,_loc2_ + Errors.CANT_NULL);
         }
      }
   }
}
