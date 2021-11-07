package net.wg.data.VO
{
   import net.wg.infrastructure.interfaces.IContextItem;
   
   public class ContextItem implements IContextItem
   {
       
      
      private var _id:String;
      
      private var _label:String;
      
      private var _iconType:String;
      
      private var _submenu:Vector.<IContextItem>;
      
      private var _initData:Object = null;
      
      private var _LINKAGE_DEFAULT:String = "";
      
      public function ContextItem(param1:String, param2:String, param3:Object = null, param4:Vector.<IContextItem> = null)
      {
         super();
         this._id = param1;
         this._label = param2;
         this._submenu = param4;
         this._initData = param3;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
      }
      
      public function get submenu() : Vector.<IContextItem>
      {
         return this._submenu;
      }
      
      public function set submenu(param1:Vector.<IContextItem>) : void
      {
         this._submenu = param1;
      }
      
      public function get initData() : Object
      {
         return this._initData;
      }
      
      public function set initData(param1:Object) : void
      {
         this._initData = param1;
      }
      
      public function get linkage() : String
      {
         return this._LINKAGE_DEFAULT;
      }
      
      public function set iconType(param1:String) : void
      {
         this._iconType = param1;
      }
      
      public function get iconType() : String
      {
         return this._iconType;
      }
   }
}
