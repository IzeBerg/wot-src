package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObjectContainer;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.infrastructure.managers.impl.TooltipMgr.ToolTipManagerBase;
   
   public class ToolTipManagerBattle extends ToolTipManagerBase
   {
       
      
      public function ToolTipManagerBattle(param1:DisplayObjectContainer)
      {
         super(param1);
      }
      
      override public function getDefaultTooltipProps() : ITooltipProps
      {
         return TooltipProps.DEFAULT;
      }
   }
}
