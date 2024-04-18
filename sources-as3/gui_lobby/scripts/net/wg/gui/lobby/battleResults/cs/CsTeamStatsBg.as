package net.wg.gui.lobby.battleResults.cs
{
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CsTeamStatsBg extends UIComponentEx
   {
      
      public static var STATUS_WIN:String = "win";
      
      public static var STATUS_LOSE:String = "lose";
      
      public static var STATUS_TIE:String = "tie";
      
      private static var INVALID_STATUS:String = "invalidStatus";
       
      
      private var _status:String;
      
      public function CsTeamStatsBg()
      {
         this._status = STATUS_WIN;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_STATUS))
         {
            gotoAndStop(this._status);
         }
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function set status(param1:String) : void
      {
         this._status = param1;
         invalidate(INVALID_STATUS);
      }
   }
}
