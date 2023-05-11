package net.wg.gui.messenger.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ContactsListTreeItemInfo extends DAAPIDataClass implements ITreeItemInfo
   {
      
      public static const CRITERIA_FIELD:String = "criteria";
       
      
      public var parentItemData:Object;
      
      private var _isOpened:Boolean;
      
      private var _gui:Object;
      
      private var _data:Object;
      
      private var _children:Array;
      
      private var _parent:ITreeItemInfo;
      
      public function ContactsListTreeItemInfo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == CRITERIA_FIELD)
         {
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get id() : Object
      {
         return Boolean(this._gui) ? this._gui["id"] : null;
      }
      
      public function get gui() : Object
      {
         return this._gui;
      }
      
      public function set gui(param1:Object) : void
      {
         this._gui = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
      }
      
      public function get children() : Array
      {
         return this._children;
      }
      
      public function set children(param1:Array) : void
      {
         this._children = param1;
      }
      
      public function get isOpened() : Boolean
      {
         return this._isOpened;
      }
      
      public function set isOpened(param1:Boolean) : void
      {
         this._isOpened = param1;
      }
      
      public function get isBrunch() : Boolean
      {
         return this.children != null;
      }
      
      public function get parent() : ITreeItemInfo
      {
         return this._parent;
      }
      
      public function set parent(param1:ITreeItemInfo) : void
      {
         this._parent = param1;
      }
   }
}
