package net.wg.gui.messenger.data
{
   public interface ITreeItemInfo
   {
       
      
      function get id() : Object;
      
      function get gui() : Object;
      
      function set gui(param1:Object) : void;
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function get children() : Array;
      
      function set children(param1:Array) : void;
      
      function get isOpened() : Boolean;
      
      function set isOpened(param1:Boolean) : void;
      
      function get isBrunch() : Boolean;
      
      function set parent(param1:ITreeItemInfo) : void;
      
      function get parent() : ITreeItemInfo;
   }
}
