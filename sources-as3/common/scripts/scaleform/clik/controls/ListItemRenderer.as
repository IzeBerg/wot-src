package scaleform.clik.controls
{
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class ListItemRenderer extends Button implements IListItemRenderer
   {
       
      
      protected var _index:uint = 0;
      
      protected var _selectable:Boolean = true;
      
      public function ListItemRenderer()
      {
         super();
      }
      
      override public function get focusable() : Boolean
      {
         return _focusable;
      }
      
      override public function set focusable(param1:Boolean) : void
      {
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get selectable() : Boolean
      {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this._selectable = param1;
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
         selected = param1.selected;
         label = param1.label || "";
      }
      
      public function setData(param1:Object) : void
      {
         this.data = param1;
      }
      
      public function getData() : Object
      {
         return this.data;
      }
      
      override public function toString() : String
      {
         return "[CLIK ListItemRenderer " + this.index + ", " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         focusTarget = owner;
         _focusable = tabEnabled = tabChildren = mouseChildren = false;
      }
      
      override protected function canLog() : Boolean
      {
         return false;
      }
   }
}
