package net.wg.data.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.IContextItem;
   
   public class ContextMenuOptionVO extends DAAPIDataClass implements IContextItem
   {
      
      private static const ID_FIELD:String = "id";
      
      private static const LABEL_FIELD:String = "label";
      
      private static const INIT_DATA_FIELD:String = "initData";
      
      private static const SUBMENU_FIELD:String = "submenu";
      
      private static const LINKAGE_FIELD:String = "linkage";
      
      private static const ICON_TYPE:String = "iconType";
       
      
      private var _id:String = "";
      
      private var _label:String = "";
      
      private var _initData:Object = null;
      
      private var _iconType:String = "";
      
      private var _submenu:Vector.<IContextItem>;
      
      private var _linkage:String = "";
      
      public function ContextMenuOptionVO(param1:Object)
      {
         super(param1);
      }
      
      public static function transformItems(param1:Array) : Vector.<IContextItem>
      {
         var _loc2_:Vector.<IContextItem> = null;
         var _loc3_:Object = null;
         if(param1)
         {
            _loc2_ = new Vector.<IContextItem>();
            for each(_loc3_ in param1)
            {
               _loc2_.push(new ContextMenuOptionVO(_loc3_));
            }
         }
         return _loc2_;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case ICON_TYPE:
               this._iconType = String(param2);
               return false;
            case ID_FIELD:
               this._id = String(param2);
               return false;
            case LABEL_FIELD:
               this._label = String(param2);
               return false;
            case INIT_DATA_FIELD:
               this._initData = param2;
               return false;
            case SUBMENU_FIELD:
               this._submenu = transformItems(param2 as Array);
               return false;
            case LINKAGE_FIELD:
               this._linkage = String(param2);
               return false;
            default:
               return true;
         }
      }
      
      override protected function onDispose() : void
      {
         this._initData.dispose();
         this._initData = null;
         this._submenu.splice(0,this._submenu.length);
         this._submenu = null;
         super.onDispose();
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function get iconType() : String
      {
         return this._iconType;
      }
      
      public function get submenu() : Vector.<IContextItem>
      {
         return this._submenu;
      }
      
      public function get initData() : Object
      {
         return this._initData;
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
   }
}
