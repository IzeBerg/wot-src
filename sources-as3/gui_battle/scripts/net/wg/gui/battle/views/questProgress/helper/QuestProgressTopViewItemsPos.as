package net.wg.gui.battle.views.questProgress.helper
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QuestProgressTopViewItemsPos implements IDisposable
   {
      
      private static const ITEMS_GAP:int = 18;
      
      private static const ITEMS_STATIC_WIDTH:int = 42;
      
      private static const WIDTH_BETWEEN_ITEMS:int = ITEMS_STATIC_WIDTH + ITEMS_GAP;
      
      private static const HALF_WIDTH_BETWEEN_ITEMS:int = WIDTH_BETWEEN_ITEMS >> 1;
      
      private static const SEPARATOR_WIDTH:int = 2;
      
      private static const SEPARATOR_PADDING:int = 8;
      
      private static const HALF_SEPARATOR_FULL_WIDTH:int = SEPARATOR_PADDING + SEPARATOR_WIDTH >> 1;
      
      private static const LOCK_WIDTH:int = 8;
       
      
      private var _flagToX:int = 0;
      
      private var _itemsToX:Array;
      
      private var _separatorToX:int = 0;
      
      private var _lockToX:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function QuestProgressTopViewItemsPos()
      {
         this._itemsToX = [];
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearItemsToX();
         this._itemsToX = null;
      }
      
      public function itemToX(param1:int) : int
      {
         return this._itemsToX[param1];
      }
      
      public function recalculate(param1:int, param2:int, param3:int) : void
      {
         var _loc7_:int = 0;
         this.clearItemsToX();
         var _loc4_:int = WIDTH_BETWEEN_ITEMS * param1 - ITEMS_GAP;
         var _loc5_:int = -(_loc4_ >> 1) + HALF_WIDTH_BETWEEN_ITEMS;
         if(param3 >= 0)
         {
            _loc5_ -= HALF_SEPARATOR_FULL_WIDTH >> 1;
         }
         if(param2 > 0)
         {
            this._flagToX = _loc5_ - param2;
            if(param1 > 0)
            {
               this._flagToX -= ITEMS_GAP;
            }
            _loc5_ += ITEMS_STATIC_WIDTH >> 1;
         }
         else
         {
            _loc5_ -= ITEMS_GAP - SEPARATOR_PADDING + SEPARATOR_WIDTH;
         }
         var _loc6_:int = 0;
         while(_loc6_ < param1)
         {
            this._itemsToX.push(_loc5_);
            if(param3 >= 0 && _loc6_ == param3)
            {
               this._separatorToX = _loc5_ + (WIDTH_BETWEEN_ITEMS + SEPARATOR_PADDING >> 1);
               _loc5_ += SEPARATOR_PADDING + SEPARATOR_WIDTH;
            }
            _loc5_ += WIDTH_BETWEEN_ITEMS;
            _loc6_++;
         }
         if(param3 >= 0)
         {
            _loc7_ = this._itemsToX[param3 + 1];
            this._lockToX = (this._itemsToX[param1 - 1] - _loc7_ >> 1) + _loc7_ - (LOCK_WIDTH >> 1);
         }
      }
      
      private function clearItemsToX() : void
      {
         if(this._itemsToX)
         {
            this._itemsToX.splice(0,this._itemsToX.length);
         }
      }
      
      public function get flagToX() : int
      {
         return this._flagToX;
      }
      
      public function get separatorToX() : int
      {
         return this._separatorToX;
      }
      
      public function get lockToX() : int
      {
         return this._lockToX;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
