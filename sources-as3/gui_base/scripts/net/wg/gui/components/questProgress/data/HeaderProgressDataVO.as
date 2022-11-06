package net.wg.gui.components.questProgress.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   
   public class HeaderProgressDataVO extends DAAPIDataClass implements IHeaderProgressData
   {
       
      
      private var _header:String = "";
      
      private var _valueTitle:String = "";
      
      private var _value:int = 0;
      
      private var _goal:int = 0;
      
      private var _progress:Array = null;
      
      private var _state:int = 0;
      
      private var _progressType:String = "";
      
      private var _orderType:String = "";
      
      private var _scope:String = "";
      
      private var _conditionIcon:String = "";
      
      public function HeaderProgressDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this._progress)
         {
            this._progress.splice(0,this._progress.length);
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
      
      public function get conditionIcon() : String
      {
         return this._conditionIcon;
      }
      
      public function set conditionIcon(param1:String) : void
      {
         this._conditionIcon = param1;
      }
   }
}
