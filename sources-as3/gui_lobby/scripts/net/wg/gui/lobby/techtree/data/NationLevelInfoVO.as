package net.wg.gui.lobby.techtree.data
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NationLevelInfoVO implements IDisposable
   {
       
      
      public var levelIdx:int = -1;
      
      protected var _itemsCount:int = 0;
      
      protected var _columns:Vector.<int>;
      
      protected var _columnsItems:Vector.<int>;
      
      public function NationLevelInfoVO(param1:int = -1)
      {
         this._columns = new Vector.<int>();
         this._columnsItems = new Vector.<int>();
         super();
         this.levelIdx = param1;
      }
      
      public function addItem(param1:int) : void
      {
         var _loc2_:int = this._columns.indexOf(param1);
         if(_loc2_ > -1)
         {
            ++this._columnsItems[_loc2_];
         }
         else
         {
            this._columns.push(param1);
            this._columnsItems[this._columns.length - 1] = 1;
         }
         ++this._itemsCount;
      }
      
      public function dispose() : void
      {
         this._columns.splice(0,this._columns.length);
         this._columns = null;
         this._columnsItems.splice(0,this._columnsItems.length);
         this._columnsItems = null;
      }
      
      public function getColumnNumChild(param1:int) : int
      {
         var _loc2_:int = this._columns.indexOf(param1);
         return _loc2_ > -1 ? int(this._columnsItems[_loc2_]) : int(0);
      }
      
      public function get columnCount() : int
      {
         return this._columns.length;
      }
      
      public function get columns() : Vector.<int>
      {
         return this._columns;
      }
      
      public function get itemsCount() : int
      {
         return this._itemsCount;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "Level: " + this.levelIdx + "\n";
         var _loc2_:int = 0;
         while(_loc2_ < this._columns.length)
         {
            _loc1_ += "Column: " + this._columns[_loc2_] + "; items: " + this._columnsItems[_loc2_] + "\n";
            _loc2_++;
         }
         return _loc1_;
      }
   }
}
