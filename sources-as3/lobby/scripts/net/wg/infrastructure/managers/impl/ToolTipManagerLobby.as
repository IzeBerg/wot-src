package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObjectContainer;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BLOCKS_TOOLTIP_TYPES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.tooltips.Separator;
   import net.wg.gui.components.tooltips.inblocks.TooltipInBlocks;
   import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
   import net.wg.infrastructure.events.LibraryLoaderEvent;
   import net.wg.infrastructure.interfaces.pool.IPoolManager;
   import net.wg.infrastructure.managers.ILoaderManager;
   import net.wg.infrastructure.managers.impl.TooltipMgr.ToolTipManagerBase;
   import net.wg.infrastructure.managers.pool.ComponentsPool;
   
   public class ToolTipManagerLobby extends ToolTipManagerBase
   {
      
      private static const NUM_TEXT_BLOCK_POOL_ITEMS:int = 20;
      
      private static const NUM_BUILD_UP_BLOCK_POOL_ITEMS:int = 20;
      
      private static const NUM_SEPARATOR_POOL_ITEMS:int = 20;
      
      private static const NUM_IMAGE_TEXT_BLOCK_POOL_ITEMS:int = 15;
      
      private static const NUM_TEXT_PARAMETER_BLOCK_POOL_ITEMS:int = 20;
      
      private static const NUM_TEXT_PARAMETER_BLOCK_WITH_ICON_POOL_ITEMS:int = 15;
      
      private static const NUM_STATUS_DELTA_BLOCK_POOL_ITEMS:int = 7;
      
      private static const NUM_META_LEVEL_PROGRESS_BLOCK_POOL_ITEMS:int = 1;
      
      private static const NUM_COMPOUND_PRICE_BLOCK_POOL_ITEMS:int = 4;
      
      private static const NUM_BUILD_UP_BLOCK_WT_RENT_POOL_ITEMS:int = 1;
      
      private static const REQUIRED_LIB:String = "guiControlsLobbyBattleDynamic.swf";
       
      
      public function ToolTipManagerLobby(param1:DisplayObjectContainer)
      {
         super(param1);
         App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED,this.onLoaderManagerLoadedHandler);
      }
      
      override protected function getRedrawProps() : ITooltipProps
      {
         return TooltipProps.ADVANCED;
      }
      
      override public function getDefaultTooltipProps() : ITooltipProps
      {
         return TooltipProps.DEFAULT;
      }
      
      override protected function onDispose() : void
      {
         App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED,this.onLoaderManagerLoadedHandler);
         super.onDispose();
      }
      
      private function createPools() : void
      {
         var _loc1_:IPoolManager = App.utils.poolManager;
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_TEXT_BLOCK_LINKAGE,NUM_TEXT_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_IMAGETEXT_BLOCK_LINKAGE,NUM_IMAGE_TEXT_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_TEXT_PARAMETER_BLOCK_LINKAGE,NUM_TEXT_PARAMETER_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_TEXT_PARAMETER_WITH_ICON_BLOCK_LINKAGE,NUM_TEXT_PARAMETER_BLOCK_WITH_ICON_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_WHITE_BG_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_NORMAL_VEHICLE_BG_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_EARLY_ACCESS_VEHICLE_BG_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_ELITE_VEHICLE_BG_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILD_BLOCK_VIOLET_BIG_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILD_BLOCK_VIOLET_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILD_BLOCK_GOLD_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILD_BLOCK_GRAY_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILD_BLOCK_YELLOW_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILD_BLOCK_YELLOW_LIGHT_LINKAGE,NUM_BUILD_UP_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_STATUS_DELTA_PARAMETER_BLOCK_LINKAGE,NUM_STATUS_DELTA_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_META_LEVEL_PROGRESS_BLOCK_LINKAGE,NUM_META_LEVEL_PROGRESS_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_COMPOUND_PRICE_BLOCK_LINKAGE,NUM_COMPOUND_PRICE_BLOCK_POOL_ITEMS);
         this.addTooltipBlocksPool(_loc1_,BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILD_BLOCK_WT_RENT_LINKAGE,NUM_BUILD_UP_BLOCK_WT_RENT_POOL_ITEMS);
         _loc1_.addPool(Linkages.TOOLTIP_SEPARATOR_UI,new ComponentsPool(NUM_SEPARATOR_POOL_ITEMS,Linkages.TOOLTIP_SEPARATOR_UI,Separator));
      }
      
      private function addTooltipBlocksPool(param1:IPoolManager, param2:String, param3:uint) : void
      {
         param1.addPool(param2,new ComponentsPool(param3,param2,ITooltipBlock));
      }
      
      private function onLoaderManagerLoadedHandler(param1:LibraryLoaderEvent) : void
      {
         var _loc2_:ILoaderManager = null;
         var _loc3_:String = null;
         if(param1.requestedUrl == REQUIRED_LIB)
         {
            _loc2_ = App.instance.loaderMgr;
            _loc2_.removeEventListener(LibraryLoaderEvent.LOADED,this.onLoaderManagerLoadedHandler);
            _loc3_ = TOOLTIPS_CONSTANTS.INBLOCKS_DEFAULT_UI;
            cacheComponent(_loc3_,App.utils.classFactory.getComponent(_loc3_,TooltipInBlocks));
            this.createPools();
         }
      }
   }
}
