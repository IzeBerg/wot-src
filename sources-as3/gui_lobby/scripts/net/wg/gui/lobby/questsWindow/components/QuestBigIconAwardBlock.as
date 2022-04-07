package net.wg.gui.lobby.questsWindow.components
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.QUEST_AWARD_BLOCK_ALIASES;
   
   public class QuestBigIconAwardBlock extends AbstractResizableContent
   {
      
      private static const BLOCK_HEIGHT:int = 80;
      
      private static const GAP:int = 10;
       
      
      private var _items:Vector.<QuestBigIconAwardItem>;
      
      public function QuestBigIconAwardBlock()
      {
         super();
         height = BLOCK_HEIGHT;
         this._items = new Vector.<QuestBigIconAwardItem>(0);
      }
      
      override public function setData(param1:Object) : void
      {
         var _loc2_:QuestBigIconAwardItem = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.linkage == QUEST_AWARD_BLOCK_ALIASES.QUEST_BIG_ICON_AWARD_BLOCK)
         {
            _loc3_ = param1.items.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = App.utils.classFactory.getComponent(Linkages.QUEST_BIG_ICON_AWARD_ITEM_LINKAGE,QuestBigIconAwardItem);
               _loc2_.populateData(param1.items[_loc4_]);
               addChild(_loc2_);
               this._items.push(_loc2_);
               _loc4_++;
            }
         }
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         this.updatePositions();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:QuestBigIconAwardItem = null;
         if(this._items)
         {
            for each(_loc1_ in this._items)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this._items = null;
         }
         super.onDispose();
      }
      
      private function updatePositions() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:QuestBigIconAwardItem = null;
         _loc1_ = 0;
         var _loc3_:int = this._items.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this._items[_loc4_];
            _loc2_.x = _loc1_;
            _loc1_ += _loc2_.width + GAP;
            _loc4_++;
         }
      }
   }
}
