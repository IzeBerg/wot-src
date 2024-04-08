package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.list
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.PveDAAPIVehicleInfoVO;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.pveBase.views.stats.components.playersPanel.interfaces.IPvePlayersPanelListItem;
   import net.wg.gui.battle.pveBase.views.stats.components.playersPanel.interfaces.IPvePlayersPanelListItemHolder;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItemHolder;
   
   public class PvePlayersPanelListItemHolder extends PlayersPanelListItemHolder implements IPvePlayersPanelListItemHolder
   {
       
      
      private var _hpBarVisibilityState:uint;
      
      private var _countLivesVisibility:Boolean = true;
      
      public function PvePlayersPanelListItemHolder(param1:IPvePlayersPanelListItem)
      {
         super(param1);
      }
      
      public function setPanelHPBarVisibilityState(param1:uint) : void
      {
         if(this._hpBarVisibilityState == param1)
         {
            return;
         }
         this._hpBarVisibilityState = param1;
         this.resolveHpBarVisibility();
      }
      
      public function setCountLivesVisibility(param1:Boolean) : void
      {
         if(this._countLivesVisibility == param1)
         {
            return;
         }
         this._countLivesVisibility = param1;
         var _loc2_:IPvePlayersPanelListItem = getListItem() as IPvePlayersPanelListItem;
         if(_loc2_)
         {
            _loc2_.setCountLivesVisibility(param1);
         }
      }
      
      override public function setVehicleData(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc3_:PveDAAPIVehicleInfoVO = null;
         super.setVehicleData(param1);
         var _loc2_:IPvePlayersPanelListItem = getListItem() as IPvePlayersPanelListItem;
         if(_loc2_)
         {
            _loc2_.setVehicleType(param1.vehicleType);
            _loc2_.setTeamColor(param1.teamColor);
            _loc3_ = param1 as PveDAAPIVehicleInfoVO;
            if(_loc3_)
            {
               _loc2_.setHighlighted(_loc3_.highlight);
               _loc2_.setShowFrags(_loc3_.showFrags);
               _loc2_.setShowVehicleTypeIcon(_loc3_.showVehicleTypeIcon);
               _loc2_.setCountLives(_loc3_.countLives);
            }
         }
         this.resolveHpBarVisibility();
      }
      
      private function resolveHpBarVisibility() : void
      {
         var _loc1_:uint = this._hpBarVisibilityState;
         var _loc2_:PveDAAPIVehicleInfoVO = vehicleData as PveDAAPIVehicleInfoVO;
         if(_loc2_ != null)
         {
            if(_loc2_.teamPanelMode == PveDAAPIVehicleInfoVO.SHOW_WITH_HP)
            {
               _loc1_ = PLAYERS_PANEL_STATE.ALWAYS_SHOW_HP;
            }
         }
         getListItem().setPanelHPBarVisibilityState(_loc1_);
      }
   }
}
