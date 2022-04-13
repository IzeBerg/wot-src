package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SupplyIconMarker extends MovieClip implements IDisposable
   {
      
      private static const SUPPLY_ICONS_MAP:Object = {
         "supply_Pillbox":1,
         "supply_WatchTower":2,
         "supply_Bunker":3,
         "supply_ATgun":4,
         "supply_Barricades":5,
         "supply_Flamer":6,
         "supply_Mortar":7
      };
      
      private static const MARKER_STATES_TO_FRAME:Object = {
         "ally_default":1,
         "ally_spotted":2,
         "ally_dead":3,
         "enemy_default":4,
         "enemy_dead":5
      };
       
      
      public var iconState:MovieClip = null;
      
      private var _isDisposed:Boolean = false;
      
      public function SupplyIconMarker()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.iconState = null;
         this._isDisposed = true;
      }
      
      public function setState(param1:String) : void
      {
         if(MARKER_STATES_TO_FRAME.hasOwnProperty(param1))
         {
            if(this.iconState != null)
            {
               this.iconState.gotoAndStop(MARKER_STATES_TO_FRAME[param1]);
            }
         }
      }
      
      public function setSupplyType(param1:String) : void
      {
         if(SUPPLY_ICONS_MAP.hasOwnProperty(param1))
         {
            gotoAndStop(SUPPLY_ICONS_MAP[param1]);
         }
      }
      
      public final function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
