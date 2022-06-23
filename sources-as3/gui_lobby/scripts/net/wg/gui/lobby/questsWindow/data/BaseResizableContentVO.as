package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BaseResizableContentVO extends DAAPIDataClass
   {
       
      
      private var _headerTitle:String = "";
      
      private var _linkage:String = "";
      
      private var _containerElements:Array;
      
      public var id:int;
      
      public function BaseResizableContentVO(param1:Object)
      {
         this._containerElements = [];
         super(param1);
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
      
      public function set linkage(param1:String) : void
      {
         this._linkage = param1;
      }
      
      public function get containerElements() : Array
      {
         return this._containerElements;
      }
      
      public function set containerElements(param1:Array) : void
      {
         this._containerElements = param1;
      }
      
      public function get headerTitle() : String
      {
         return this._headerTitle;
      }
      
      public function set headerTitle(param1:String) : void
      {
         this._headerTitle = param1;
      }
   }
}
