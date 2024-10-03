package net.wg.white_tiger.gui.battle.views.wtPlayersPanel
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.VO.BossBotInfoVO;
   
   public class BossPanelList extends BattleUIComponent
   {
       
      
      public var botList1:BossBotList = null;
      
      public var botList2:BossBotList = null;
      
      public var botList3:BossBotList = null;
      
      private var _campByVehId:Dictionary;
      
      public function BossPanelList()
      {
         this._campByVehId = new Dictionary();
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = undefined;
         this.botList1.dispose();
         this.botList1 = null;
         this.botList2.dispose();
         this.botList2 = null;
         this.botList3.dispose();
         this.botList3 = null;
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
      
      public function clearCamp(param1:int) : void
      {
         var _loc2_:BossBotList = this.getBotCamp(param1);
         if(_loc2_)
         {
            _loc2_.destroy();
            invalidatePosition();
         }
      }
      
      public function resetGeneratorIconTimer(param1:int) : void
      {
         var _loc2_:BossBotList = this.getBotCamp(param1);
         if(_loc2_)
         {
            _loc2_.resetGeneratorTimer();
         }
      }
      
      public function setAllCampsOffline() : void
      {
         if(this.botList1)
         {
            this.botList1.setOffline();
         }
         if(this.botList2)
         {
            this.botList2.setOffline();
         }
         if(this.botList3)
         {
            this.botList3.setOffline();
         }
         this.updateLayout();
      }
      
      public function setBotInfo(param1:BossBotInfoVO) : void
      {
         var _loc2_:BossBotList = this.getBotCamp(param1.campIndex);
         if(_loc2_)
         {
            _loc2_.campIndex = param1.campIndex;
            _loc2_.setBotInfo(param1);
            this._campByVehId[param1.vehID] = _loc2_;
            invalidatePosition();
         }
      }
      
      public function setBotSpotted(param1:int, param2:int) : void
      {
         var _loc3_:BossBotListItem = this.getBotItemByVehId(param1);
         if(_loc3_)
         {
            _loc3_.setSpotted(param2);
         }
      }
      
      public function setIsDestroyed(param1:int, param2:Boolean) : void
      {
         var _loc3_:BossBotList = this.getBotCamp(param1);
         if(_loc3_)
         {
            _loc3_.setIsDestroyed(param2);
         }
      }
      
      public function updateBotHp(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:BossBotList = null;
         var _loc4_:BossBotListItem = this.getBotItemByVehId(param1);
         if(_loc4_)
         {
            _loc4_.setHp(param2,param3);
            _loc5_ = this._campByVehId[param1];
            _loc5_.invalidatePosition();
         }
      }
      
      public function updateGeneratorCaptureTimer(param1:int, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:BossBotList = this.getBotCamp(param1);
         if(_loc6_)
         {
            _loc6_.updateGeneratorCaptureTimer(param2,param3,param4,param5);
         }
      }
      
      public function updateGeneratorDownTime(param1:int, param2:Number, param3:Number, param4:String) : void
      {
         var _loc5_:BossBotList = this.getBotCamp(param1);
         if(_loc5_)
         {
            _loc5_.updateGeneratorDownTime(param2,param3,param4);
         }
      }
      
      public function updateInfoStatus(param1:int) : void
      {
         var _loc2_:BossBotList = this.getBotCamp(param1);
         if(_loc2_)
         {
            _loc2_.updateInfoStatus();
         }
      }
      
      private function getBotCamp(param1:int) : BossBotList
      {
         switch(param1)
         {
            case 1:
               return this.botList1;
            case 2:
               return this.botList2;
            case 3:
               return this.botList3;
            default:
               return null;
         }
      }
      
      private function getBotItemByVehId(param1:int) : BossBotListItem
      {
         var _loc2_:BossBotList = this._campByVehId[param1];
         return Boolean(_loc2_) ? _loc2_.getItemByVehId(param1) : null;
      }
      
      private function updateLayout() : void
      {
         var _loc1_:int = 0;
         this.botList1.y = _loc1_;
         _loc1_ = this.botList1.y + this.botList1.height;
         this.botList2.y = _loc1_;
         this.botList3.y = this.botList2.y + this.botList2.height;
      }
      
      public function set isAlly(param1:Boolean) : void
      {
         this.botList1.isAlly = this.botList2.isAlly = this.botList3.isAlly = param1;
      }
   }
}
