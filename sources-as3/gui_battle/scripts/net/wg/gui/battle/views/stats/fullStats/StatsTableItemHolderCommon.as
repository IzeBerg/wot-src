package net.wg.gui.battle.views.stats.fullStats
{
   import net.wg.data.constants.UserTags;
   import net.wg.gui.battle.random.views.stats.constants.VehicleActions;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   
   public class StatsTableItemHolderCommon extends StatsTableItemHolderBase
   {
       
      
      private var _dogTagCtrl:DogTagCtrl = null;
      
      private var _isEnemy:Boolean = false;
      
      public function StatsTableItemHolderCommon(param1:StatsTableItemBase, param2:DogTagCtrl, param3:Boolean)
      {
         super(param1);
         this._dogTagCtrl = param2;
         this._isEnemy = param3;
      }
      
      override public function showDogTag(param1:DogTagVO) : void
      {
         super.showDogTag(param1);
         this._dogTagCtrl.setDogTag(param1);
      }
      
      override protected function vehicleDataSync() : void
      {
         var _loc1_:StatsTableItemCommon = null;
         var _loc2_:uint = 0;
         super.vehicleDataSync();
         if(data)
         {
            _loc1_ = this.getStatsItem;
            _loc1_.setVehicleLevel(data.vehicleLevel);
            _loc1_.setVehicleIcon(data.vehicleIconName);
            _loc1_.setPrestige(data.prestigeMarkId,data.prestigeLevel);
            _loc1_.setIsSpeaking(data.isSpeaking);
            _loc2_ = data.vehicleAction;
            if(_loc2_)
            {
               _loc1_.setVehicleAction(VehicleActions.getActionName(data.vehicleAction));
            }
            else
            {
               _loc1_.clearVehicleAction();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._dogTagCtrl.dispose();
         this._dogTagCtrl = null;
         super.onDispose();
      }
      
      override protected function applyUserTags() : void
      {
         super.applyUserTags();
         var _loc1_:Array = data.userTags;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:StatsTableItemCommon = this.getStatsItem;
         _loc2_.setIsMute(UserTags.isMuted(_loc1_));
         _loc2_.setDisableCommunication(UserTags.isIgnored(_loc1_));
      }
      
      public function get isEnemy() : Boolean
      {
         return this._isEnemy;
      }
      
      private function get getStatsItem() : StatsTableItemCommon
      {
         return StatsTableItemCommon(statsItem);
      }
   }
}
