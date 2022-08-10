package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProgressBlockVO extends DAAPIDataClass
   {
       
      
      private var _vehicleData:Object = null;
      
      private var _description:String = "";
      
      private var _iconSource:String = "";
      
      private var _counterValue:Number = NaN;
      
      private var _counterDescr:String = "";
      
      private var _progressElements:Array;
      
      private var _linkage:String = "";
      
      private var _showDone:Boolean = false;
      
      public function ProgressBlockVO(param1:Object)
      {
         this._progressElements = [];
         super(param1);
      }
      
      public function get vehicleData() : Object
      {
         return this._vehicleData;
      }
      
      public function set vehicleData(param1:Object) : void
      {
         this._vehicleData = param1;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(param1:String) : void
      {
         this._description = param1;
      }
      
      public function get counterValue() : Number
      {
         return this._counterValue;
      }
      
      public function set counterValue(param1:Number) : void
      {
         this._counterValue = param1;
      }
      
      public function get progressElements() : Array
      {
         return this._progressElements;
      }
      
      public function set progressElements(param1:Array) : void
      {
         this._progressElements = param1;
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
      
      public function set linkage(param1:String) : void
      {
         this._linkage = param1;
      }
      
      public function get iconSource() : String
      {
         return this._iconSource;
      }
      
      public function set iconSource(param1:String) : void
      {
         this._iconSource = param1;
      }
      
      public function get showDone() : Boolean
      {
         return this._showDone;
      }
      
      public function set showDone(param1:Boolean) : void
      {
         this._showDone = param1;
      }
      
      public function get counterDescr() : String
      {
         return this._counterDescr;
      }
      
      public function set counterDescr(param1:String) : void
      {
         this._counterDescr = param1;
      }
   }
}
