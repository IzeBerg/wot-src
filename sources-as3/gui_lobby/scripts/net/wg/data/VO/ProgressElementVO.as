package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProgressElementVO extends DAAPIDataClass
   {
       
      
      private var _linkage:String = "";
      
      private var _progrTooltip:Object = null;
      
      private var _progrBarType:String = "";
      
      private var _maxProgrVal:Number = 0;
      
      private var _currentProgrVal:Number = 0;
      
      private var _description:String = "";
      
      private var _progressDiff:String = "";
      
      private var _progressDiffTooltip:String = "";
      
      private var _progrIndex:int = 0;
      
      private var _showDone:Boolean = false;
      
      public function ProgressElementVO(param1:Object)
      {
         super(param1);
      }
      
      public function get progrTooltip() : Object
      {
         return this._progrTooltip;
      }
      
      public function set progrTooltip(param1:Object) : void
      {
         this._progrTooltip = param1;
      }
      
      public function get progrBarType() : String
      {
         return this._progrBarType;
      }
      
      public function set progrBarType(param1:String) : void
      {
         this._progrBarType = param1;
      }
      
      public function get maxProgrVal() : Number
      {
         return this._maxProgrVal;
      }
      
      public function set maxProgrVal(param1:Number) : void
      {
         this._maxProgrVal = param1;
      }
      
      public function get currentProgrVal() : Number
      {
         return this._currentProgrVal;
      }
      
      public function set currentProgrVal(param1:Number) : void
      {
         this._currentProgrVal = param1;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(param1:String) : void
      {
         this._description = param1;
      }
      
      public function get progressDiff() : String
      {
         return this._progressDiff;
      }
      
      public function set progressDiff(param1:String) : void
      {
         this._progressDiff = param1;
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
      
      public function set linkage(param1:String) : void
      {
         this._linkage = param1;
      }
      
      public function get progrIndex() : int
      {
         return this._progrIndex;
      }
      
      public function set progrIndex(param1:int) : void
      {
         this._progrIndex = param1;
      }
      
      public function get showDone() : Boolean
      {
         return this._showDone;
      }
      
      public function set showDone(param1:Boolean) : void
      {
         this._showDone = param1;
      }
      
      public function get progressDiffTooltip() : String
      {
         return this._progressDiffTooltip;
      }
      
      public function set progressDiffTooltip(param1:String) : void
      {
         this._progressDiffTooltip = param1;
      }
   }
}
