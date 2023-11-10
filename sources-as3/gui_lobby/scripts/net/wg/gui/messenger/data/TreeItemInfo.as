package net.wg.gui.messenger.data
{
   public class TreeItemInfo implements ITreeItemInfo
   {
       
      
      private var _isOpened:Boolean;
      
      private var _gui:Object;
      
      private var _data:Object;
      
      private var _children:Array;
      
      private var _parent:ITreeItemInfo;
      
      public function TreeItemInfo(param1:Object)
      {
         var _loc2_:* = null;
         super();
         for(_loc2_ in param1)
         {
            this[_loc2_] = param1[_loc2_];
         }
      }
      
      public function get id() : Object
      {
         return this._gui;
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
      
      public function set parent(param1:ITreeItemInfo) : void
      {
         this._parent = param1;
      }
      
      public function get parent() : ITreeItemInfo
      {
         return this._parent;
      }
   }
}
