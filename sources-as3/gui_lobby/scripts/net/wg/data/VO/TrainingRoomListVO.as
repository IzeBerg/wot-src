package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TrainingRoomListVO extends DAAPIDataClass
   {
       
      
      private var _other:Array;
      
      private var _team1:Array;
      
      private var _team2:Array;
      
      private var _myId:Number;
      
      public function TrainingRoomListVO(param1:Object)
      {
         this._other = [];
         this._team1 = [];
         this._team2 = [];
         super(param1);
      }
      
      public function get team2() : Array
      {
         return this._team2;
      }
      
      public function set team2(param1:Array) : void
      {
         this._team2 = param1;
      }
      
      public function get team1() : Array
      {
         return this._team1;
      }
      
      public function set team1(param1:Array) : void
      {
         this._team1 = param1;
      }
      
      public function get other() : Array
      {
         return this._other;
      }
      
      public function set other(param1:Array) : void
      {
         this._other = param1;
      }
      
      public function get myId() : Number
      {
         return this._myId;
      }
      
      public function set myId(param1:Number) : void
      {
         this._myId = param1;
      }
      
      public function getTeam(param1:String) : Array
      {
         switch(param1)
         {
            case "team1":
               return this._team1;
            case "team2":
               return this._team2;
            case "other":
               return this._other;
            default:
               DebugUtils.LOG_DEBUG("undefined " + param1 + "in TrainingRoomListVO");
               return [];
         }
      }
   }
}
