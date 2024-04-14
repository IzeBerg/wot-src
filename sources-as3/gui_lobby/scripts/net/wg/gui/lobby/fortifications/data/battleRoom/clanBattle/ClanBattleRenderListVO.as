package net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle
{
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.rally.interfaces.IRallyListItemVO;
   
   public class ClanBattleRenderListVO extends DAAPIDataClass implements IRallyListItemVO
   {
      
      private static const TIMER_FIELD:String = "beforeBegins";
       
      
      public var sortieID:Array;
      
      public var battleType:String = "";
      
      public var battleName:String = "";
      
      public var battleDirection:String = "";
      
      public var dayOfBattle:String = "";
      
      public var beforeBegins:Object = null;
      
      public var timer:ClanBattleTimerVO;
      
      public var stateOfBattle:String = "";
      
      public var startTimeLeft:int = -1;
      
      public var direction:int = -1;
      
      public function ClanBattleRenderListVO(param1:Object)
      {
         this.sortieID = [Values.DEFAULT_INT,Values.DEFAULT_INT];
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TIMER_FIELD && param2 != null && param2["timer"] != null)
         {
            this.beforeBegins = param2;
            this.timer = new ClanBattleTimerVO(param2["timer"]);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get peripheryID() : Number
      {
         return this.sortieID[1];
      }
      
      public function get mgrID() : Number
      {
         return this.sortieID[0];
      }
      
      public function get rallyIndex() : Number
      {
         return Values.DEFAULT_INT;
      }
   }
}
