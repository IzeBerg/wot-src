package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO.DAAPIEventBossBotInfoVO;
   
   public class EventBossPanelList extends BattleUIComponent
   {
       
      
      public var bombList:EventBossBombList = null;
      
      public var botList1:EventBossBotList = null;
      
      public var botList2:EventBossBotList = null;
      
      private var _campByVehId:Dictionary;
      
      public function EventBossPanelList()
      {
         this._campByVehId = new Dictionary();
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = undefined;
         this.bombList.dispose();
         this.bombList = null;
         this.botList1.dispose();
         this.botList1 = null;
         this.botList2.dispose();
         this.botList2 = null;
         for(_loc1_ in this._campByVehId)
         {
            delete this._campByVehId[_loc1_];
         }
         this._campByVehId = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            this.updateLayout();
         }
      }
      
      public function set isAlly(param1:Boolean) : void
      {
         this.bombList.isAlly = this.botList1.isAlly = this.botList2.isAlly = param1;
      }
      
      public function setBotInfo(param1:DAAPIEventBossBotInfoVO) : void
      {
         var _loc2_:EventBossBotList = this.getBotCamp(param1.campIndex);
         if(_loc2_)
         {
            _loc2_.campIndex = param1.campIndex;
            _loc2_.setBotInfo(param1);
            this._campByVehId[param1.vehID] = _loc2_;
            invalidatePosition();
         }
      }
      
      public function updateBombTimer(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
         this.bombList.updateTimer(param1,param2,param3,param4);
         invalidatePosition();
      }
      
      public function updateBotHp(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:EventBossBotList = null;
         var _loc4_:EventBossBotListItem = this.getBotItemByVehId(param1);
         if(_loc4_)
         {
            _loc4_.setHp(param2,param3);
            _loc5_ = this._campByVehId[param1];
            _loc5_.invalidatePosition();
         }
      }
      
      public function setBotSpotted(param1:int, param2:int) : void
      {
         var _loc3_:EventBossBotListItem = this.getBotItemByVehId(param1);
         if(_loc3_)
         {
            _loc3_.setSpotted(param2);
         }
      }
      
      public function clearCamp(param1:int) : void
      {
         var _loc2_:EventBossBotList = this.getBotCamp(param1);
         if(_loc2_)
         {
            _loc2_.destroy();
            invalidatePosition();
         }
      }
      
      private function getBotCamp(param1:int) : EventBossBotList
      {
         switch(param1)
         {
            case 1:
               return this.botList1;
            case 2:
               return this.botList2;
            default:
               return null;
         }
      }
      
      private function getBotItemByVehId(param1:int) : EventBossBotListItem
      {
         var _loc2_:EventBossBotList = this._campByVehId[param1];
         return Boolean(_loc2_) ? _loc2_.getItemByVehId(param1) : null;
      }
      
      private function updateLayout() : void
      {
         var _loc1_:int = 0;
         if(this.bombList.isVisible)
         {
            _loc1_ += this.bombList.y + this.bombList.height | 0;
         }
         this.botList1.y = _loc1_;
         _loc1_ = this.botList1.y + this.botList1.height;
         this.botList2.y = _loc1_;
      }
   }
}
