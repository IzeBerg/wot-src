package net.wg.gui.lobby.battleRoyale
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class ProxyCurrencyPanel extends GFInjectComponent
   {
      
      private static const PANEL_WIDTH:int = 312;
      
      private static const PANEL_HEIGHT:int = 74;
       
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function ProxyCurrencyPanel()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         width = PANEL_WIDTH;
         height = PANEL_HEIGHT;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.BATTLE_ROYALE_PROXY_CURRENCY);
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
