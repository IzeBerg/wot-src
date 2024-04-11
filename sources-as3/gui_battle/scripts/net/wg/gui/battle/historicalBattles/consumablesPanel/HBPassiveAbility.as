package net.wg.gui.battle.historicalBattles.consumablesPanel
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.HBBATTLE_CONSUMABLES_PANEL_PASSIVE_STATES;
   import net.wg.gui.battle.historicalBattles.components.HBIconContainer;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class HBPassiveAbility extends MovieClip
   {
       
      
      public var iconLoader:HBIconContainer = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _tooltip:String = null;
      
      public function HBPassiveAbility()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
         stop();
      }
      
      public function dispose() : void
      {
         if(this.iconLoader)
         {
            this.iconLoader.dispose();
            this.iconLoader = null;
         }
         this._tooltipMgr = null;
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
      }
      
      public function setIcon(param1:String) : void
      {
         this.iconLoader.source = param1;
      }
      
      public function setState(param1:String) : void
      {
         var _loc2_:String = param1 || HBBATTLE_CONSUMABLES_PANEL_PASSIVE_STATES.GREEN;
         if(currentLabel != _loc2_)
         {
            gotoAndStop(_loc2_);
         }
      }
      
      public function setTooltip(param1:String) : void
      {
         this._tooltip = param1;
      }
      
      private function mouseRollOverHandler(param1:MouseEvent) : void
      {
         if(!StringUtils.isEmpty(this._tooltip))
         {
            this._tooltipMgr.showComplex(this._tooltip);
         }
      }
      
      private function mouseRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
