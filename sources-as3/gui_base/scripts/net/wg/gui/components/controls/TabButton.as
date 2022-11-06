package net.wg.gui.components.controls
{
   import net.wg.data.constants.SoundTypes;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class TabButton extends SoundButtonEx implements IListItemRenderer
   {
       
      
      private var _index:uint;
      
      public function TabButton()
      {
         super();
         soundType = SoundTypes.TAB;
      }
      
      override public function toString() : String
      {
         return "[WG TabButton " + name + "]";
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = this.index;
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function setData(param1:Object) : void
      {
      }
      
      public function getData() : Object
      {
         return null;
      }
   }
}
