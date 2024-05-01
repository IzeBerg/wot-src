package net.wg.gui.prebattle.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ReceivedInviteVO extends DAAPIDataClass
   {
       
      
      private var _id:int = 0;
      
      private var _text:String = "";
      
      private var _comment:String = "";
      
      private var _note:String = "";
      
      private var _canAccept:Boolean = false;
      
      private var _canDecline:Boolean = false;
      
      private var _isAcceptVisible:Boolean = false;
      
      private var _isDeclineVisible:Boolean = false;
      
      public function ReceivedInviteVO(param1:Object)
      {
         super(param1);
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
      }
      
      public function get comment() : String
      {
         return this._comment;
      }
      
      public function set comment(param1:String) : void
      {
         this._comment = param1;
      }
      
      public function get note() : String
      {
         return this._note;
      }
      
      public function set note(param1:String) : void
      {
         this._note = param1;
      }
      
      public function get canAccept() : Boolean
      {
         return this._canAccept;
      }
      
      public function set canAccept(param1:Boolean) : void
      {
         this._canAccept = param1;
      }
      
      public function get canDecline() : Boolean
      {
         return this._canDecline;
      }
      
      public function set canDecline(param1:Boolean) : void
      {
         this._canDecline = param1;
      }
      
      public function get isAcceptVisible() : Boolean
      {
         return this._isAcceptVisible;
      }
      
      public function set isAcceptVisible(param1:Boolean) : void
      {
         this._isAcceptVisible = param1;
      }
      
      public function get isDeclineVisible() : Boolean
      {
         return this._isDeclineVisible;
      }
      
      public function set isDeclineVisible(param1:Boolean) : void
      {
         this._isDeclineVisible = param1;
      }
      
      public function hasNote() : Boolean
      {
         return this._note && this._note.length > 0;
      }
   }
}
