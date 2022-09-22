package net.wg.gui.lobby.battleRoyale
{
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.lobby.hangar.tcarousel.TankCarouselItemRenderer;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class BattleRoyaleTankCarouselItemRenderer extends TankCarouselItemRenderer
   {
       
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      public function BattleRoyaleTankCarouselItemRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function onShowTooltip() : void
      {
         if(StringUtils.isNotEmpty(dataVO.lockedTooltip))
         {
            this._toolTipMgr.showComplex(dataVO.lockedTooltip);
         }
         else
         {
            this._toolTipMgr.showWulfTooltip(dataVO.tooltip,dataVO.intCD);
            if(isInteractive)
            {
               content.handleRollOver(dataVO);
            }
         }
      }
      
      override public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
         super.tooltipDecorator = param1;
         this._toolTipMgr = param1;
      }
      
      override protected function showContextMenu() : void
      {
         App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BATTLE_ROYALE_VEHICLE,this,{"inventoryId":dataVO.id});
      }
   }
}
