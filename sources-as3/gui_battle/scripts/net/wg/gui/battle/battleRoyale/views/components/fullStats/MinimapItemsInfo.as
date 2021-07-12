package net.wg.gui.battle.battleRoyale.views.components.fullStats
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   
   public class MinimapItemsInfo extends GroupEx
   {
      
      private static const MINIMAP_ITEMS_LIST_GAP:int = -25;
      
      private static const MINIMAP_ITEMS_LIST_GAP_SMALL:int = -7;
       
      
      private var _minimapItemsLayout:VerticalGroupLayout = null;
      
      private var _minimapItemsLayoutSmall:VerticalGroupLayout = null;
      
      public function MinimapItemsInfo()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._minimapItemsLayout = new VerticalGroupLayout();
         this._minimapItemsLayout.gap = MINIMAP_ITEMS_LIST_GAP;
         this._minimapItemsLayoutSmall = new VerticalGroupLayout();
         this._minimapItemsLayoutSmall.gap = MINIMAP_ITEMS_LIST_GAP_SMALL;
      }
      
      override protected function onDispose() : void
      {
         this._minimapItemsLayout.dispose();
         this._minimapItemsLayout = null;
         this._minimapItemsLayoutSmall.dispose();
         this._minimapItemsLayoutSmall = null;
         super.onDispose();
      }
      
      private function cleanUpRenderers() : void
      {
         removeAllChildren(true);
         if(renderers)
         {
            renderers.splice(0,renderers.length);
         }
      }
      
      public function set useSmallLayout(param1:Boolean) : void
      {
         this.cleanUpRenderers();
         if(param1)
         {
            itemRendererLinkage = Linkages.MINIMAP_LEGEND_ITEM_RENDERER_SMALL;
            layout = this._minimapItemsLayoutSmall;
         }
         else
         {
            itemRendererLinkage = Linkages.MINIMAP_LEGEND_ITEM_RENDERER;
            layout = this._minimapItemsLayout;
         }
         invalidateData();
      }
   }
}
