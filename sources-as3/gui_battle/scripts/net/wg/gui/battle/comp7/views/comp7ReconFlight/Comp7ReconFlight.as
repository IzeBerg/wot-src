package net.wg.gui.battle.comp7.views.comp7ReconFlight
{
   import flash.events.Event;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.infrastructure.base.meta.IComp7ReconFlightMeta;
   import net.wg.infrastructure.base.meta.impl.Comp7ReconFlightMeta;
   
   public class Comp7ReconFlight extends Comp7ReconFlightMeta implements IComp7ReconFlightMeta
   {
       
      
      private var _isHidden:Boolean = true;
      
      public function Comp7ReconFlight()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function as_hide() : void
      {
         gotoAndPlay(DAMAGE_INFO_PANEL_CONSTS.HIDE_RECON_FLIGHT);
         this._isHidden = true;
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function as_show() : void
      {
         gotoAndPlay(DAMAGE_INFO_PANEL_CONSTS.SHOW_RECON_FLIGHT);
         this._isHidden = false;
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get isHidden() : Boolean
      {
         return this._isHidden;
      }
   }
}
