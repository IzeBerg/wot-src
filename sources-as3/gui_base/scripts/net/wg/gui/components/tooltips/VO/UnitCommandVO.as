package net.wg.gui.components.tooltips.VO
{
   public class UnitCommandVO extends SuitableVehicleVO
   {
       
      
      private var _unitComment:String = "";
      
      private var _commanderName:String = "";
      
      private var _commanderRating:String = "";
      
      private var _commanderRatingDesc:String = "";
      
      private var _isPeripheryAnother:Boolean = false;
      
      public function UnitCommandVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._unitComment = null;
         this._commanderName = null;
         this._commanderRating = null;
         this._commanderRatingDesc = null;
         super.onDispose();
      }
      
      public function get unitComment() : String
      {
         return this._unitComment;
      }
      
      public function set unitComment(param1:String) : void
      {
         this._unitComment = param1;
      }
      
      public function get commanderName() : String
      {
         return this._commanderName;
      }
      
      public function set commanderName(param1:String) : void
      {
         this._commanderName = param1;
      }
      
      public function get commanderRating() : String
      {
         return this._commanderRating;
      }
      
      public function set commanderRating(param1:String) : void
      {
         this._commanderRating = param1;
      }
      
      public function get isPeripheryAnother() : Boolean
      {
         return this._isPeripheryAnother;
      }
      
      public function set isPeripheryAnother(param1:Boolean) : void
      {
         this._isPeripheryAnother = param1;
      }
      
      public function get commanderRatingDesc() : String
      {
         return this._commanderRatingDesc;
      }
      
      public function set commanderRatingDesc(param1:String) : void
      {
         this._commanderRatingDesc = param1;
      }
   }
}
