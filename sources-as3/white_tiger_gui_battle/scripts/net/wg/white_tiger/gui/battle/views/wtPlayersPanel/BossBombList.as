package net.wg.white_tiger.gui.battle.views.wtPlayersPanel
{
   import flash.display.Sprite;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class BossBombList extends BattleUIComponent
   {
      
      private static const LIST_BOMB_ITEM_LEFT_LINKAGE:String = "EventBossBombListItemLeftUI";
      
      private static const LIST_BOMB_ITEM_RIGHT_LINKAGE:String = "EventBossBombListItemRightUI";
      
      private static const LIST_ITEM_HEIGHT:int = 26;
       
      
      private var _isAlly:Boolean = false;
      
      private var _listItems:Vector.<BossBombListItem> = null;
      
      private var _rendererContainer:Sprite = null;
      
      public function BossBombList()
      {
         super();
         this._listItems = new Vector.<BossBombListItem>();
         this._rendererContainer = new Sprite();
         addChild(this._rendererContainer);
      }
      
      override protected function onDispose() : void
      {
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
      
      public function updateTimer(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc6_:BossBombListItem = null;
         var _loc7_:String = null;
         var _loc5_:int = this.getItemIndex(param1);
         if(_loc5_ < 0)
         {
            if(param2 > 0)
            {
               _loc7_ = !!this._isAlly ? LIST_BOMB_ITEM_LEFT_LINKAGE : LIST_BOMB_ITEM_RIGHT_LINKAGE;
               _loc6_ = App.utils.classFactory.getComponent(_loc7_,BossBombListItem);
               _loc6_.id = param1;
               _loc6_.updateTime(param2,param3,param4);
               this._rendererContainer.addChild(_loc6_);
               this._listItems.push(_loc6_);
               this.updateLayout();
            }
         }
         else
         {
            _loc6_ = this._listItems[_loc5_];
            if(param2 > 0)
            {
               _loc6_.updateTime(param2,param3,param4);
            }
            else
            {
               this._rendererContainer.removeChild(_loc6_);
               _loc6_.dispose();
               this._listItems.splice(_loc5_,1);
               this.updateLayout();
            }
         }
      }
      
      private function getItemIndex(param1:int) : int
      {
         var _loc2_:int = this._listItems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._listItems[_loc3_].id == param1)
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
         var _loc1_:BossBombListItem = null;
         for each(_loc1_ in this._listItems)
         {
            _loc1_.dispose();
         }
         this._listItems.length = 0;
      }
      
      private function updateLayout() : void
      {
         var _loc2_:BossBombListItem = null;
         this._listItems.sort(this.compare);
         var _loc1_:int = 0;
         for each(_loc2_ in this._listItems)
         {
            _loc2_.y = _loc1_;
            _loc1_ += LIST_ITEM_HEIGHT;
         }
      }
      
      private function compare(param1:BossBombListItem, param2:BossBombListItem) : int
      {
         if(param1.id < param2.id)
         {
            return -1;
         }
         return 1;
      }
      
      public function set isAlly(param1:Boolean) : void
      {
         this._isAlly = param1;
      }
      
      public function get isVisible() : Boolean
      {
         return this._listItems.length > 0;
      }
   }
}
