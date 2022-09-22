package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ConditionElementVO extends DAAPIDataClass
   {
       
      
      private var _conditionType:String = "";
      
      private var _contentAlign:String = "left";
      
      private var _iconElements:Array;
      
      private var _progrIndex:int = 0;
      
      private var _linkage:String = "ConditionElement_UI";
      
      public function ConditionElementVO(param1:Object)
      {
         this._iconElements = [];
         super(param1);
      }
      
      public function get conditionType() : String
      {
         return this._conditionType;
      }
      
      public function set conditionType(param1:String) : void
      {
         this._conditionType = param1;
      }
      
      public function get iconElements() : Array
      {
         return this._iconElements;
      }
      
      public function set iconElements(param1:Array) : void
      {
         this._iconElements = param1;
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
      
      public function set linkage(param1:String) : void
      {
         this._linkage = param1;
      }
      
      public function get contentAlign() : String
      {
         return this._contentAlign;
      }
      
      public function set contentAlign(param1:String) : void
      {
         this._contentAlign = param1;
      }
      
      public function get progrIndex() : int
      {
         return this._progrIndex;
      }
      
      public function set progrIndex(param1:int) : void
      {
         this._progrIndex = param1;
      }
   }
}
