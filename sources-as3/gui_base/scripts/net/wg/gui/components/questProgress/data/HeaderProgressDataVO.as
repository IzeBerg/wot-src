package net.wg.gui.components.questProgress.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HeaderProgressDataVO extends DAAPIDataClass implements IHeaderProgressData
   {
      
      private static const CONDITIONS_FIELD_NAME:String = "conditions";
       
      
      private var _header:String = "";
      
      private var _valueTitle:String = "";
      
      private var _value:int = 0;
      
      private var _goal:int = 0;
      
      private var _progress:Array = null;
      
      private var _state:int = 0;
      
      private var _progressType:String = "";
      
      private var _orderType:String = "";
      
      private var _scope:String = "";
      
      private var _conditions:Array = null;
      
      public function HeaderProgressDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == CONDITIONS_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            this._conditions = [];
            for each(_loc4_ in _loc3_)
            {
               this._conditions.push(new HeaderProgressConditionVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._conditions)
         {
            for each(_loc1_ in this._conditions)
            {
               _loc1_.dispose();
            }
            this._conditions.length = 0;
            this._conditions = null;
         }
         if(this._progress)
         {
            this._progress.length = 0;
            this._progress = null;
         }
         super.onDispose();
      }
      
      public function get progressType() : String
      {
         return this._progressType;
      }
      
      public function set progressType(param1:String) : void
      {
         this._progressType = param1;
      }
      
      public function get orderType() : String
      {
         return this._orderType;
      }
      
      public function set orderType(param1:String) : void
      {
         this._orderType = param1;
      }
      
      public function get header() : String
      {
         return this._header;
      }
      
      public function set header(param1:String) : void
      {
         this._header = param1;
      }
      
      public function get valueTitle() : String
      {
         return this._valueTitle;
      }
      
      public function set valueTitle(param1:String) : void
      {
         this._valueTitle = param1;
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function set value(param1:int) : void
      {
         this._value = param1;
      }
      
      public function get goal() : int
      {
         return this._goal;
      }
      
      public function set goal(param1:int) : void
      {
         this._goal = param1;
      }
      
      public function get progress() : Array
      {
         return this._progress;
      }
      
      public function set progress(param1:Array) : void
      {
         this._progress = param1;
      }
      
      public function get scope() : String
      {
         return this._scope;
      }
      
      public function set scope(param1:String) : void
      {
         this._scope = param1;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(param1:int) : void
      {
         this._state = param1;
      }
      
      public function get conditions() : Array
      {
         return this._conditions;
      }
   }
}
