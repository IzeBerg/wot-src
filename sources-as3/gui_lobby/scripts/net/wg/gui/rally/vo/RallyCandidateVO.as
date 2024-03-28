package net.wg.gui.rally.vo
{
   import net.wg.data.VO.ExtendedUserVO;
   import net.wg.gui.interfaces.IRallyCandidateVO;
   
   public class RallyCandidateVO extends ExtendedUserVO implements IRallyCandidateVO
   {
       
      
      public var isInvite:Boolean = false;
      
      public var readyState:Boolean = false;
      
      private var _isCommander:Boolean = false;
      
      private var _rating:String = "";
      
      private var _statusIcon:String = "";
      
      private var _isOffline:Boolean = false;
      
      private var _isRatingAvailable:Boolean = false;
      
      public function RallyCandidateVO(param1:Object)
      {
         _colors = [Number.NaN,Number.NaN];
         super(param1);
      }
      
      public function get isCommander() : Boolean
      {
         return this._isCommander;
      }
      
      public function set isCommander(param1:Boolean) : void
      {
         this._isCommander = param1;
      }
      
      public function get rating() : String
      {
         return this._rating;
      }
      
      public function set rating(param1:String) : void
      {
         this._rating = param1;
      }
      
      public function get statusIcon() : String
      {
         return this._statusIcon;
      }
      
      public function set statusIcon(param1:String) : void
      {
         this._statusIcon = param1;
      }
      
      override public function get colors() : Array
      {
         return _colors;
      }
      
      override public function set colors(param1:Array) : void
      {
         if(_colors && _colors.length > 1)
         {
            _colors = param1;
         }
      }
      
      public function get color() : Number
      {
         return _colors[!!this._isOffline ? 1 : 0];
      }
      
      public function get isOffline() : Boolean
      {
         return this._isOffline;
      }
      
      public function set isOffline(param1:Boolean) : void
      {
         this._isOffline = param1;
      }
      
      public function get isRatingAvailable() : Boolean
      {
         return this._isRatingAvailable;
      }
      
      public function set isRatingAvailable(param1:Boolean) : void
      {
         this._isRatingAvailable = param1;
      }
   }
}
