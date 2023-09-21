package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.display.Sprite;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO.DAAPIEventBossBotInfoVO;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps.EventBotListInfo;
   
   public class EventBossBotList extends BattleUIComponent
   {
      
      private static const LIST_BOT_ITEM_LEFT_LINKAGE:String = "EventBossBotListItemLeftUI";
      
      private static const LIST_BOT_ITEM_RIGHT_LINKAGE:String = "EventBossBotListItemRightUI";
      
      private static const LIST_ITEM_HEIGHT:int = 26;
       
      
      public var info:EventBotListInfo = null;
      
      private var _isAlly:Boolean = false;
      
      private var _listItems:Vector.<EventBossBotListItem> = null;
      
      private var _rendererContainer:Sprite = null;
      
      private var _campIndex:int = -1;
      
      private var _isDestroyed:Boolean = false;
      
      public function EventBossBotList()
      {
         super();
         this._listItems = new Vector.<EventBossBotListItem>();
         this._rendererContainer = new Sprite();
         this._rendererContainer.y = LIST_ITEM_HEIGHT;
         addChild(this._rendererContainer);
      }
      
      override protected function onDispose() : void
      {
         this.info.dispose();
         this.info = null;
         this.clearRendererContainer();
         this.clearListItems();
         removeChild(this._rendererContainer);
         this._rendererContainer = null;
         this._listItems = null;
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
      
      public function setBotInfo(param1:DAAPIEventBossBotInfoVO) : void
      {
         var _loc3_:String = null;
         var _loc4_:EventBossBotListItem = null;
         if(this._isDestroyed)
         {
            this.clearListItems();
            this.clearRendererContainer();
            this._isDestroyed = false;
         }
         var _loc2_:int = this.getItemIndex(param1.vehID);
         if(_loc2_ >= 0)
         {
            this._listItems[_loc2_].setData(param1);
         }
         else
         {
            _loc3_ = !!this._isAlly ? LIST_BOT_ITEM_LEFT_LINKAGE : LIST_BOT_ITEM_RIGHT_LINKAGE;
            _loc4_ = App.utils.classFactory.getComponent(_loc3_,EventBossBotListItem);
            _loc4_.setData(param1);
            this._rendererContainer.addChild(_loc4_);
            this._listItems.push(_loc4_);
            this.updateLayout();
         }
         this.updateInfoStatus();
      }
      
      public function destroy() : void
      {
         this._isDestroyed = true;
      }
      
      public function updateInfoStatus() : void
      {
         this.info.updateIconStatus();
      }
      
      public function updateGeneratorCaptureTimer(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.info.updateGeneratorCaptureTimer(param1,param2,param3,param4);
      }
      
      public function setIsDestroyed(param1:Boolean) : void
      {
         this.info.setIsDestroyed(param1);
         this.setListItemsInvisible();
         invalidatePosition();
      }
      
      public function resetGeneratorTimer() : void
      {
         this.info.resetGeneratorCaptureTimer();
      }
      
      public function updateGeneratorDownTime(param1:Number, param2:Number, param3:String) : void
      {
         this.info.updateGeneratorDownTime(param1,param2,param3);
      }
      
      public function set isAlly(param1:Boolean) : void
      {
         this._isAlly = param1;
      }
      
      public function getItemByVehId(param1:int) : EventBossBotListItem
      {
         var _loc2_:int = this.getItemIndex(param1);
         if(_loc2_ >= 0 && _loc2_ < this._listItems.length)
         {
            return this._listItems[_loc2_];
         }
         return null;
      }
      
      public function set campIndex(param1:int) : void
      {
         if(param1 == this._campIndex)
         {
            return;
         }
         this._campIndex = param1;
         this.info.setData(this._campIndex,this._isAlly);
      }
      
      public function setOffline() : void
      {
         this.setIsDestroyed(true);
         this.info.updateGeneratorDownTime(0,0,"");
         this.collapse();
      }
      
      private function collapse() : void
      {
         this.clearListItems();
         this.clearRendererContainer();
         this.updateLayout();
      }
      
      private function getItemIndex(param1:int) : int
      {
         var _loc2_:int = this._listItems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._listItems[_loc3_].vehID == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function clearRendererContainer() : void
      {
         var _loc1_:int = this._rendererContainer.numChildren;
         while(_loc1_-- > 0)
         {
            this._rendererContainer.removeChildAt(0);
         }
      }
      
      private function clearListItems() : void
      {
         var _loc1_:EventBossBotListItem = null;
         for each(_loc1_ in this._listItems)
         {
            _loc1_.dispose();
         }
         this._listItems.length = 0;
      }
      
      private function setListItemsInvisible() : void
      {
         var _loc1_:EventBossBotListItem = null;
         for each(_loc1_ in this._listItems)
         {
            _loc1_.visible = false;
         }
      }
      
      private function updateLayout() : void
      {
         var _loc2_:EventBossBotListItem = null;
         this._listItems.sort(this.compare);
         var _loc1_:int = 0;
         for each(_loc2_ in this._listItems)
         {
            _loc2_.y = _loc1_;
            _loc1_ += LIST_ITEM_HEIGHT;
         }
      }
      
      private function compare(param1:EventBossBotListItem, param2:EventBossBotListItem) : int
      {
         if(param1.isDead != param2.isDead)
         {
            return !!param1.isDead ? int(1) : int(-1);
         }
         return 1;
      }
   }
}
