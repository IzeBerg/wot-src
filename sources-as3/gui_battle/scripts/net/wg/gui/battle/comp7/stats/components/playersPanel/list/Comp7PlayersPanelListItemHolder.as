package net.wg.gui.battle.comp7.stats.components.playersPanel.list
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehicleInfoVO;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.interfaces.IComp7PlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersListItemHolder;
   
   public class Comp7PlayersPanelListItemHolder extends BasePlayersListItemHolder
   {
       
      
      private var _listItem:IComp7PlayersPanelListItem = null;
      
      public function Comp7PlayersPanelListItemHolder(param1:Comp7PlayersPanelListItem)
      {
         this._listItem = param1;
         super(param1);
      }
      
      override public function setVehicleData(param1:DAAPIVehicleInfoVO) : void
      {
         super.setVehicleData(param1);
         var _loc2_:Comp7DAAPIVehicleInfoVO = param1 as Comp7DAAPIVehicleInfoVO;
         if(_loc2_)
         {
            this._listItem.setRank(_loc2_.rank,_loc2_.rankDivision);
            this._listItem.setVoiceChatConnected(_loc2_.voiceChatConnected);
         }
      }
      
      override protected function onDispose() : void
      {
         this._listItem = null;
         super.onDispose();
      }
      
      override protected function applyPlayerStatusValues() : void
      {
         this._listItem.setSquad(vehicleData.isSquadPersonal(),vehicleData.squadIndex);
      }
      
      public function removePointOfInterest(param1:uint) : void
      {
         this._listItem.removePointOfInterest(param1);
      }
      
      public function updatePointOfInterest(param1:uint, param2:Number) : void
      {
         this._listItem.updatePointOfInterest(param1,param2);
      }
   }
}
