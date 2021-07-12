package net.wg.gui.prebattle.battleSession
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BSListRendererVO extends DAAPIDataClass
   {
       
      
      private var _prbID:Number;
      
      private var _prbType:Number;
      
      private var _descr:String = "";
      
      private var _opponents:String = "";
      
      private var _startTime:String = "";
      
      public function BSListRendererVO(param1:Object)
      {
         super(param1);
      }
      
      public function get prbID() : Number
      {
         return this._prbID;
      }
      
      public function set prbID(param1:Number) : void
      {
         this._prbID = param1;
      }
      
      public function get prbType() : Number
      {
         return this._prbType;
      }
      
      public function set prbType(param1:Number) : void
      {
         this._prbType = param1;
      }
      
      public function get descr() : String
      {
         return this._descr;
      }
      
      public function set descr(param1:String) : void
      {
         this._descr = param1;
      }
      
      public function get opponents() : String
      {
         return this._opponents;
      }
      
      public function set opponents(param1:String) : void
      {
         this._opponents = param1;
      }
      
      public function get startTime() : String
      {
         return this._startTime;
      }
      
      public function set startTime(param1:String) : void
      {
         this._startTime = param1;
      }
   }
}
