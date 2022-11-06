package net.wg.gui.components.tooltips.inblocks
{
   import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
   import net.wg.infrastructure.interfaces.pool.IPoolManager;
   
   public class TooltipInBlocksUtils
   {
      
      private static var _instance:TooltipInBlocksUtils;
       
      
      public function TooltipInBlocksUtils()
      {
         super();
      }
      
      public static function get instance() : TooltipInBlocksUtils
      {
         if(_instance == null)
         {
            _instance = new TooltipInBlocksUtils();
         }
         return _instance;
      }
      
      public function createBlock(param1:String) : ITooltipBlock
      {
         var _loc2_:IPoolManager = App.utils.poolManager;
         if(_loc2_.containsPool(param1))
         {
            return ITooltipBlock(_loc2_.getItem(param1));
         }
         return App.utils.classFactory.getComponent(param1,ITooltipBlock);
      }
   }
}
