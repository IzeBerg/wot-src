package net.wg.white_tiger.gui.battle.views.wtTeleportView
{
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.white_tiger.infrastructure.base.meta.IWTBossTeleportViewMeta;
   import net.wg.white_tiger.infrastructure.base.meta.impl.WTBossTeleportViewMeta;
   
   public class WTBossTeleportView extends WTBossTeleportViewMeta implements IWTBossTeleportViewMeta
   {
      
      private static const MINIMAP_OFFSET_Y_BIG:int = 20;
      
      private static const MINIMAP_OFFSET_Y_SMALL:int = 10;
       
      
      public function WTBossTeleportView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Rectangle = null;
         var _loc3_:Point = null;
         super.draw();
         if(minimap && isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = !!isSmallScreen ? int(MINIMAP_OFFSET_Y_SMALL) : int(MINIMAP_OFFSET_Y_BIG);
            _loc2_ = minimap.getMinimapRectBySizeIndex(minimap.currentSizeIndex);
            _loc3_ = minimap.currentTopLeftPoint;
            minimap.x = (stageWidth - _loc2_.width >> 1) - _loc3_.x;
            minimap.y = (stageHeight - _loc2_.height >> 1) - _loc3_.y + _loc1_;
            minimap.dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
         }
      }
      
      override protected function onMinimapDeploymentPointSelect(param1:String) : void
      {
         onTeleportPointClickS(param1);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(param1.target == this)
         {
            onCancelS();
         }
      }
   }
}
